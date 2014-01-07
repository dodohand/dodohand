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

#ifndef __DH_LEDS_H__
#define __DH_LEDS_D__

#include "pca9655e.h"

#define LH_LED0_PORTB_MASK ( 0x40u )
#define LH_LED1_PORTB_MASK ( 0x20u )
#define LH_LED2_PORTB_MASK ( 0x80u )
#define LH_LED3_PORTD_MASK ( 0x40u )

inline void set_rh_LED_0 ( uint8 state )
{
  pca9655e_set_out_state_P0( 6, state );
}

inline void set_rh_LED_1 ( uint8 state )
{
  pca9655e_set_out_state_P0( 7, state );
}

inline void set_rh_LED_2 ( uint8 state )
{
  pca9655e_set_out_state_P1( 5, state );
}

inline void set_rh_LED_3 ( uint8 state )
{
  pca9655e_set_out_state_P0( 6, state );
}

inline void set_lh_LED_0 ( uint8 state )
{ // state = logical state = 1 == on, 0 == off
  // LED0 is active at output low.
  PORTB = (PORTB & ( ~LH_LED0_PORTB_MASK )) | ( state ? 0 : LH_LED0_PORTB_MASK );
}

inline void set_lh_LED_1 ( uint8 state )
{ // state = logical state = 1 == on, 0 == off
  // LED1 is active at output low.
  PORTB = (PORTB & ( ~LH_LED1_PORTB_MASK )) | ( state ? 0 : LH_LED1_PORTB_MASK );
}

inline void set_lh_LED_2 ( uint8 state )
{ // state = logical state = 1 == on, 0 == off
  // LED2 is active at output low.
  PORTB = (PORTB & ( ~LH_LED2_PORTB_MASK )) | ( state ? 0 : LH_LED2_PORTB_MASK );
}

inline void set_lh_LED_3 ( uint8 state )
{ // state = logical state = 1 == on, 0 == off
  // LED3 is active at output high.
  PORTD = (PORTD & ( ~LH_LED3_PORTD_MASK )) | ( state ? LH_LED3_PORTD_MASK : 0 );
}


#endif // __DH_LEDS_H__
