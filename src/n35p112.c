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


#include "n35p112.h"



/*
 * Define the I2C command sequences for initialization and for reading
 *
 * Initalialization first:
 *
 * Datasheet says after power-on, a reset is required for >100ns.
 * Then loop on register 0x0F until 0xF0 or 0xF1 is present.
 * Then write 0x06h to register 0x2D (TCR)
 */


#define N35P112_W4RDY_CMD_CNT ( 7u )
t_dh_twi_cmd n35p112_w4rdy_cmds[N35P112_W4RDY_CMD_CNT] = {
  { DH_TWI_CMD_START, 0 },
  { 0, EASYPOINT_I2C_ADDR | TW_WRITE },
  { 0, N35P112_CR1_ADDR },
  { DH_TWI_CMD_START, 0 },
  { 0, EASYPOINT_I2C_ADDR | TW_READ },
  { DH_TWI_CMD_READ, 0 }, // elicit value of CR1
  { DH_TWI_CMD_STOP, 0 }
};

static t_dh_twi_packet w4rdy_pkt = { N35P112_W4RDY_CMD_CNT,
                                     0,
                                     0,
                                     n35p112_w4rdy_cmds };

#define N35P112_W4RDY_GET_CR1 ( n35p112_w4rdy_cmds[5].dat )

#define N35P112_RDPOS_CMD_CNT ( 9u )
t_dh_twi_cmd n35p112_rdpos_cmds[N35P112_RDPOS_CMD_CNT] = {
  { DH_TWI_CMD_START, 0 },
  { 0, EASYPOINT_I2C_ADDR | TW_WRITE },
  { 0, N35P112_CR1_ADDR },
  { DH_TWI_CMD_START, 0 },
  { 0, EASYPOINT_I2C_ADDR | TW_READ },
  { DH_TWI_CMD_READ | DH_TWI_CMD_ACK, 0 }, // elicit value of CR1
  { DH_TWI_CMD_READ | DH_TWI_CMD_ACK, 0 }, // elicit value of XR
  { DH_TWI_CMD_READ, 0 },                  // elicit value of YR
  { DH_TWI_CMD_STOP, 0 }
};

static t_dh_twi_packet rdpos_pkt = { N35P112_RDPOS_CMD_CNT,
                                     0,
                                     0,
                                     n35p112_rdpos_cmds };

#define N35P112_RDPOS_GET_CR1 ( n35p112_rdpos_cmds[5].dat )
#define N35P112_RDPOS_GET_XR ( n35p112_rdpos_cmds[6].dat )
#define N35P112_RDPOS_GET_YR ( n35p112_rdpos_cmds[7].dat )


#define N35P112_INIT_CMD_CNT ( 8u )
const t_dh_twi_cmd n35p112_init_cmds[N35P112_INIT_CMD_CNT] = {
  { DH_TWI_CMD_START, 0 },
  { 0, EASYPOINT_I2C_ADDR | TW_WRITE },
  { 0, N35P112_MCR_ADDR },
  { 0, 0 }, // MCR must be set to zero after power-up
  { 0, 0x06u }, // JCR must be set to 0x06 after power-up
  { 0, 0x06u }, // tcr must be set to 0x06 after power-up
  { 0, 0x86u }, // CR2 must be set to 0x86 for easpoint module  
  { DH_TWI_CMD_STOP, 0 }
};

static t_dh_twi_packed init_pkt = { N35P112_INIT_CMD_CNT,
                                    0,
                                    0,
                                    n35p112_init_cmds };

