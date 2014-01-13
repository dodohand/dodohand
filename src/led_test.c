/*
    This file is part of the DodoHand project. This project aims to create 
    an open implementation of the DataHand keyboard, capable of being created
    with commercial 3D printing services.

    Copyright (C) 2013 Scott Fohey

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#define F_CPU 16000000

#include <avr/io.h>
#include <util/delay.h>

#include "dh_twi.h"
#include "pca9655e.h"

#include "print.h"
#include "usb_debug_only.h"

#include "scanrh.h"
#include "scanlh.h"

extern void pca9655e_init ( void );
extern void dh_twi_init ( void );

#define RHLED_0_ON  (0)
#define RHLED_0_OFF (1)
#define RHLED_1_ON  (0)
#define RHLED_1_OFF (1)
#define RHLED_2_ON  (0)
#define RHLED_2_OFF (1)
#define RHLED_3_ON  (1)
#define RHLED_3_OFF (0)

#define SET_RHLED_0(state)   pca9655e_set_out_state_P0 ( 6, RHLED_0_##state )
#define SET_RHLED_1(state)   pca9655e_set_out_state_P0 ( 7, RHLED_1_##state )
#define SET_RHLED_2(state)   pca9655e_set_out_state_P1 ( 5, RHLED_2_##state )
#define SET_RHLED_3(state)   pca9655e_set_out_state_P1 ( 6, RHLED_3_##state )

#define CPU_PRESCALE(n)	(CLKPR = 0x80, CLKPR = (n))

extern uint8 pca9655e_init_stat;

extern void dh_twi_isr(void);

#define LHLED_0_ON  (0)
#define LHLED_0_OFF (1)
#define LHLED_1_ON  (0)
#define LHLED_1_OFF (1)
#define LHLED_2_ON  (0)
#define LHLED_2_OFF (1)
#define LHLED_3_ON  (1)
#define LHLED_3_OFF (0)

#define SET_LHLED_0(state) ( PORTB = (PORTB & (~0x40)) | (LHLED_0_##state << 6))
#define SET_LHLED_1(state) ( PORTB = (PORTB & (~0x20)) | (LHLED_1_##state << 5))
#define SET_LHLED_2(state) ( PORTB = (PORTB & (~0x80)) | (LHLED_2_##state << 7))
#define SET_LHLED_3(state) ( PORTD = (PORTD & (~0x40)) | (LHLED_3_##state << 6))

void show_key_state ( void )
{
  if ( lh_matrix[2][2] )
    {
      SET_LHLED_0(ON);
    }
  else
    {
      SET_LHLED_0(OFF);
    }
  if ( lh_matrix[2][3] )
    {
      SET_LHLED_1(ON);
    }
  else
    {
      SET_LHLED_1(OFF);
    }

  return;
}

extern uint8 save_PORTB;

void main ( void )
{

  // B4, B5, and B6 and D6 are LEDs.
  // LED0 = B6  (active low)
  // LED1 = B5  (active low)
  // LED2 = B7  (active low)
  // LED3 = D6 ** (active high)

  CPU_PRESCALE(0);

  usb_init();

  dh_twi_init();
  
  pca9655e_init();

  init_matrices();

  while (!usb_configured());

  DDRB = DDRB | 0xE0; // configure B5, B6, and B7 as outputs.

  DDRD = DDRD | 0x40; // configure D6 as output

  DDRF = DDRF | PORTF_ROW_MASK; // configure LH matrix rows as outputs.

  SET_LHLED_0(OFF);
  SET_LHLED_1(OFF);
  SET_LHLED_2(OFF);
  SET_LHLED_3(OFF);

  SET_RHLED_0(OFF);
  SET_RHLED_1(OFF);
  SET_RHLED_2(OFF);
  SET_RHLED_3(OFF);

  _delay_ms(1000);

  switch ( pca9655e_init_stat )
    {
    case 255:
      print( "IOE no init\n" );
      break;
    case 0:
      print( "IOE init pass\n" );
      break;
    default:
      print( "IOE init pkt err:" );
      phex( pca9655e_init_stat );
      print( " TWSR: " );
      phex( dh_twi_err_TWSR );
      break;
    }

 top:
  pca9655e_set_row_strobes();

  pca9655e_trig_scanrh();

  SET_LHLED_2(ON);
  SET_LHLED_3(OFF);

  scanlh();

  show_key_state();

  //pca9655e_wait_for_scanrh();
  _delay_ms ( 3 );
  scanrh();

  SET_LHLED_2(OFF);
  SET_LHLED_3(ON);

  pca9655e_trig_scanrh();

  scanlh();
  show_key_state();

  _delay_ms ( 3 );
  scanrh();

  SET_LHLED_2(ON);
  SET_LHLED_3(OFF);

  pca9655e_trig_scanrh();

  scanlh();
  show_key_state();

  _delay_ms ( 3 );
  scanrh();

  SET_LHLED_2(OFF);
  SET_LHLED_3(ON);

  pca9655e_trig_scanrh();

  // IP0 -- all columns are in this one
  //  print ( "0:" );
  //  phex ( PCA9655E_GET_INP_STATE_P0 );
    // IP1 -- all rows are in this one
  //  print ( ",");
  // phex ( PCA9655E_GET_INP_STATE_P1 );
  //  print (",");
  // column 3 is in bit 2
  phex ( matrix_a[2][2] );
  print (",");
  // column 2 is in spot 3
  phex ( matrix_a[2][3] );
  print ("\n");

  scanlh();
  show_key_state();

  _delay_ms ( 3 );
  scanrh();

  goto top;
  

}
