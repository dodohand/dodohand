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

#include <util/delay.h>
#include "pca9655e.h"
#include "scanrh.h"
#include "print.h"

#define SCANRH_SM_INIT   (255u)
#define SCANRH_SM_R0_ON  (0u)
#define SCANRH_SM_R1_ON  (1u)
#define SCANRH_SM_R2_ON  (2u)
#define SCANRH_SM_R3_ON  (3u)
#define SCANRH_SM_R4_ON  (4u)

inline void set_LED_0 ( uint8 state )
{
  pca9655e_set_out_state_P0( 6, !state );
}

inline void set_LED_1 ( uint8 state )
{
  pca9655e_set_out_state_P0( 7, !state );
}

inline void set_LED_2 ( uint8 state )
{
  pca9655e_set_out_state_P1( 5, !state );
}

inline void set_LED_3 ( uint8 state )
{
  pca9655e_set_out_state_P1( 6, state );
}

// matrix_a and matrix_b will alternately store the current state and the
// last state. This should allow a scheme which doesn't copy values from
// the new table to the old table, and thus save some copying.

bool matrix_a[KB_ROWS][KB_COLUMNS];
bool matrix_b[KB_ROWS][KB_COLUMNS];

void init_matrices ( void )
{
  uint8 r;
  uint8 c;

  for ( r = 0; r < KB_ROWS; r++ )
    {
      for ( c = 0; c < KB_COLUMNS; c++ )
        {
          matrix_a [ r ][ c ] = 0;
          matrix_b [ r ][ c ] = 0;
        }
    } // rows
}

bool new_in_a = FALSE;

//static bool first_scan = TRUE;

uint8 get_cols_for_row ( uint8 row )
{
  uint8 rv;
  uint8 idx;

  switch ( row ) 
    {
    case 0:
      idx = PCA9655E_N_COL_IDX;
      break;
    case 1:
      idx = PCA9655E_E_COL_IDX;
      break;
    case 2:
      idx = PCA9655E_C_COL_IDX;
      break;
    case 3:
      idx = PCA9655E_S_COL_IDX;
      break;
    case 4:
      idx = PCA9655E_W_COL_IDX;
      break;
    default:
      idx = PCA9655E_N_COL_IDX;
      break;
    }

  rv = pca9655e_scanrh_cmds[idx].dat;

  return rv;
}

void scanrh ( void )
{
  uint8 rowid;
  uint8 c;
  uint8 r;
  uint8 new_rhcolvals;
  uint8 colid;
  uint8 t;
  uint8 kpc;

  if ( new_in_a )
    {
      for ( r=0; r < KB_ROWS; r++ )
        {
          new_rhcolvals = get_cols_for_row ( r );
          for ( c = 0; c < KB_COLUMNS; c++ )
            {
              colid = 5 - c;
              t = ( new_rhcolvals >> ( colid ) ) & 0x01u;
              if ( t ) 
                {
                  kpc++;
                }
              else
                {
                }
              matrix_b [ r ][ c ] = t;
            }
        }
    }
  else
    {
      for ( r=0; r < KB_ROWS; r++ )
        {
          new_rhcolvals = get_cols_for_row ( r );
          for ( c = 0; c < KB_COLUMNS; c++ )
            {
              colid = 5 - c;
              t = ( new_rhcolvals >> ( colid ) ) & 0x01u;
              if ( t ) 
                {
                  kpc++;
                }
              else
                {
                }
              matrix_a [ r ][ c ] = t;
            }
        }

    }

  new_in_a = new_in_a ? 0 : 1 ;

  if ( new_in_a ) 
    {

      set_LED_0 ( matrix_a [2] [2] );
      set_LED_1 ( matrix_a [2] [3] );
    }
  else
    {
      set_LED_0 ( matrix_b [2] [2] );
      set_LED_1 ( matrix_b [2] [3] );
    }

  return;
}

