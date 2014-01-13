/*
    This file is part of the DodoHand project. This project aims to create 
    an open implementation of the DataHand keyboard, capable of being created
    with commercial 3D printing services.

    Copyright (C) 2014 Scott Fohey

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

/*
 * The left-hand side switch matrix of the Dodohand is connected diretly 
 * to Teensy 2.0 pins. A row needs to be turned on for >= 300us before
 * the columns are read. During this time the state of the columns are
 * settling into their actual values - seems to be necessary in order
 * to allow the phototransistors to turn completely off if the switch is 
 * not pressed.
 */

#include <avr/io.h>
#include <util/delay.h>
#include "scanlh.h"

bool lh_matrix[KB_ROWS][LH_KB_COLS];

static void scanlh_setrow ( uint8 row );


/*
 * turn on specified row. If invalid row specified, turn off all rows.
 */
static void scanlh_setrow ( uint8 row )
{
  switch ( row )
    {
    case 0:
      PORTF = (PORTF & (~ PORTF_ROW_MASK)) | PORTF_ROW_0;
      break;
    case 1:
      PORTF = (PORTF & (~ PORTF_ROW_MASK)) | PORTF_ROW_1;
      break;
    case 2:
      PORTF = (PORTF & (~ PORTF_ROW_MASK)) | PORTF_ROW_2;
      break;
    case 3:
      PORTF = (PORTF & (~ PORTF_ROW_MASK)) | PORTF_ROW_3;
      break;
    case 4:
      PORTF = (PORTF & (~ PORTF_ROW_MASK)) | PORTF_ROW_4;
      break;
    default:
      PORTF = (PORTF & (~ PORTF_ROW_MASK)); // turn off all rows.
      break;
    }
}

void scanlh ( void )
{
  // an improvement would be to use a timer to ISR through the state machine
  // rather than to _delay_us while we wait for the column to stabilize.
  
  uint8 r;

  for ( r = 0; r < KB_ROWS; r++ )
    {
      // set the row scan active
      scanlh_setrow ( r );
      // wait for the column value to stabilize
      _delay_us ( COL_STAB_T_US );
      // read in the switch states from the columns.
      lh_matrix[r][0] = ( PINB >> PORTB_COL0_PIN ) & 0x01u;
      lh_matrix[r][1] = ( PINB >> PORTB_COL1_PIN ) & 0x01u;
      lh_matrix[r][2] = ( PINB >> PORTB_COL2_PIN ) & 0x01u;
      lh_matrix[r][3] = ( PINB >> PORTB_COL3_PIN ) & 0x01u;
      lh_matrix[r][4] = ( PIND >> PORTD_COL4_PIN ) & 0x01u;
      lh_matrix[r][5] = ( PIND >> PORTD_COL5_PIN ) & 0x01u;

    }
  
  // turn off all rows to preserve LED life.
  scanlh_setrow ( KB_ROWS );

  return;
}
