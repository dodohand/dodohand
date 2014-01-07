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

extern void pca9655e_init ( void );
extern void dh_twi_init ( void );

#define CPU_PRESCALE(n)	(CLKPR = 0x80, CLKPR = (n))

extern uint8 pca9655e_init_stat;

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
  _delay_ms ( 50 );
  pca9655e_trig_init();
  _delay_ms ( 50 );

  scanrh();

  // turn on only LED0
  PORTB = (PORTB & 0xBF) | 0xB0;
  PORTD = (PORTD & 0xBF);

  _delay_ms ( 100 );

  scanrh();

  // turn on only LED1
  PORTB = (PORTB & 0xDF) | 0xC0;

  _delay_ms ( 100 );

  scanrh();

  // turn on only LED2
  PORTB = (PORTB & 0x7F) | 0x60;

  _delay_ms ( 100 );

  scanrh();

  // turn on only LED3
  PORTB = PORTB | 0xE0;
  PORTD = (PORTD & 0xBF) | 0x40;


  goto top;
  
}
