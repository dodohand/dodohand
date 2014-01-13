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
#ifndef __SCANLH_H__
#define __SCANLH_H__

#include "dh_types.h"

#define LH_KB_COLS ( 6u )

/*
 * Row0 = Pin F0
 * Row1 = Pin F1
 * Row2 = Pin F4
 * Row3 = Pin F5
 * Row4 = Pin F6
 *
 * Col0 = Pin B0
 * Col1 = Pin B1
 * Col2 = Pin B2
 * Col3 = Pin B3
 * Col4 = Pin D2
 * Col5 = Pin D3
 *
 */

#define PORTF_ROW_MASK ( 0x73u )
#define PORTF_ROW_0    ( 0x01u )
#define PORTF_ROW_1    ( 0x02u )
#define PORTF_ROW_2    ( 0x10u )
#define PORTF_ROW_3    ( 0x20u )
#define PORTF_ROW_4    ( 0x40u )

#define PORTB_COL0_PIN ( 0x00u )
#define PORTB_COL1_PIN ( 0x01u )
#define PORTB_COL2_PIN ( 0x02u )
#define PORTB_COL3_PIN ( 0x03u )
#define PORTD_COL4_PIN ( 0x02u )
#define PORTD_COL5_PIN ( 0x03u )

#define COL_STAB_T_US ( 300u )

#define KB_ROWS    (5u)

extern bool lh_matrix[KB_ROWS][LH_KB_COLS];

extern void scanlh ( void );




#endif // __SCANLH_H__
