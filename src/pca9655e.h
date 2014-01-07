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

#ifndef _PCA9655E_H_
#define _PCA9655E_H_

#include "dh_twi.h"

// Input Port 0
#define PCA9655E_REG_CMD_IP0   (0U)
// Input Port 1
#define PCA9655E_REG_CMD_IP1   (1U)
// Output Port 0
#define PCA9655E_REG_CMD_OP0   (2U)
// Output Port 1
#define PCA9655E_REG_CMD_OP1   (3U)
// Polarity Inversion Port 0
#define PCA9655E_REG_CMD_PI0   (4U)
// Polarity Inversion Port 1
#define PCA9655E_REG_CMD_PI1   (5U)
// Configuration Port 0
#define PCA9655E_REG_CMD_CFG0  (6U)
// Configuration Port 0
#define PCA9655E_REG_CMD_CFG1  (7U)

#define PCA9655E_GET_BIT(reg_val, bitno) ( ( reg_val >> bitno ) & 0x1u )

#define PCA9655E_SET_BIT(reg_val, bitno) ( reg_val |= (1 << bitno) )

#define PCA9655E_CLR_BIT(reg_val, bitno) ( reg_val &= ~(1 << bitno) )

#define PCA9655E_OP_INITVAL  (0xFFu)
#define PCA9655E_PI_INITVAL  (0x00u)
#define PCA9655E_CFG_INITVAL (0xFFu)

extern void pca9655e_init ( void ); // immediate (blocking) init
extern void pca9655e_trig_scanrh ( void ); // queued scan of right hand matrix
extern void pca9655e_wait_for_scanrh ( void ); // wait for scan to complete
extern void pca9655e_trig_cyc ( void ); // queued read/write
extern void pca9655e_trig_init ( void ); // queued init

// pins 0 through 5 of Port 0 are inputs on DH Fingers F1 board. 6 & 7 outputs
#define DH_PCA9655E_CR0_DEF ( 0x3Fu )
// pins 0 through 7 of Port 1 are outputs
#define DH_PCA9655E_CR1_DEF ( 0x00u )

// dodohand Fingers F1 has I2C address set to 0x30 for PCA9655E
// the datasheet value of 0x30 accounts for the shifted position in the 
// word. no further shift is necessary - just put this in the register.
#define DH_IOE_ADDR ( 0x30u )

extern t_dh_twi_cmd pca9655e_scanrh_cmds[];

#define PCA9655E_OP0_IDX   ( 9u )
#define PCA9655E_OP1_IDXA  ( 10u )
#define PCA9655E_OP1_IDXB  ( 21u )
#define PCA9655E_OP1_IDXC  ( 32u )
#define PCA9655E_OP1_IDXD  ( 43u )
#define PCA9655E_OP1_IDXE  ( 54u )
#define PCA9655E_OP1_IDXF  ( 65u )
#define PCA9655E_N_COL_IDX ( 17u )
#define PCA9655E_E_COL_IDX ( 28u )
#define PCA9655E_C_COL_IDX ( 39u )
#define PCA9655E_S_COL_IDX ( 50u )
#define PCA9655E_W_COL_IDX ( 61u )

inline void pca9655e_set_out_state_P0( uint8 bit, uint8 state ) 
{
  pca9655e_scanrh_cmds[PCA9655E_OP0_IDX].dat = 
    ( pca9655e_scanrh_cmds[PCA9655E_OP0_IDX].dat & ~( 1 << bit )) 
    | ( ( state ? 1 : 0 ) << bit ) ;
}

inline void pca9655e_set_out_state_P1( uint8 bit, uint8 state )
{
  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXA].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXA].dat & ~( 1 << bit ))
    | ( ( state ? 1 : 0 ) << bit ) ;

  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXB].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXB].dat & ~( 1 << bit ))
    | ( ( state ? 1 : 0 ) << bit ) ;

  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXC].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXC].dat & ~( 1 << bit ))
    | ( ( state ? 1 : 0 ) << bit ) ;

  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXD].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXD].dat & ~( 1 << bit ))
    | ( ( state ? 1 : 0 ) << bit ) ;

  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXE].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXE].dat & ~( 1 << bit ))
    | ( ( state ? 1 : 0 ) << bit ) ;

  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXF].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXF].dat & ~( 1 << bit ))
    | ( ( state ? 1 : 0 ) << bit ) ;

}

inline void pca9655e_set_row_strobes( void )
{
  // turn on Row0
  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXA].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXA].dat | ( 1 << 0 ));
  // turn off Row0, turn on Row1
  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXB].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXB].dat & ~( 1 << 0 ))
    | ( 1 << 1 ) ;
  // turn off Row1, turn on Row2
  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXC].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXC].dat & ~( 1 << 1 ))
    | ( 1 << 2 ) ;
  // turn off Row2, turn on Row3
  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXD].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXD].dat & ~( 1 << 2 ))
    | ( 1 << 3 ) ;
  // turn off Row3, turn on Row4
  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXE].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXE].dat & ~( 1 << 3 ))
    | ( 1 << 4 ) ;
  // turn off Row4
  pca9655e_scanrh_cmds[PCA9655E_OP1_IDXF].dat = 
    (pca9655e_scanrh_cmds[PCA9655E_OP1_IDXF].dat & ~( 1 << 4 ));

}

/*
 * pca9655E write requires START, SLA+W, DATA, (repeat?), STOP to be efficient. 
 * This will work with the Output Port 0/1, Polarity Inversion 0/1, and Cfg 0/1
 * register pairs.
 *
 * reads requires START, SLA+W, CMD, START, SLA+R, wait for data (ACK or NACK), 
 * (optional repeat) NACK, STOP
 * This will read the Input Port registers, and presumably the others.
 */

#endif //_PCA9655E_H_
