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

#ifndef __DH_TWI_H__
#define __DH_TWI_H__

#include "dh_types.h"

// defines

// will likely try out 200kHz and 400kHz
// to attempt to achieve a faster scan.
//
// I2C clock for DodoHand in Hz (100kHz)
#define DH_I2C_CLOCK (100000u)

// I/O Expander
#define DH_TWI_CLIENT_IOX  ( 0u )
// EasyPoint Module
#define DH_TWI_CLIENT_EP   ( 1u )
#define DH_TWI_CLIENT_CNT  ( 2u )
// inactive
#define DH_TWI_CLIENT_NONE ( 255u )

#define DH_TWI_CMD_NAK   ( 0x00u )
#define DH_TWI_CMD_START ( 0x01u )
#define DH_TWI_CMD_STOP  ( 0x02u )
#define DH_TWI_CMD_ACK   ( 0x04u )
#define DH_TWI_CMD_READ  ( 0x08u )

// typedefs

typedef struct dh_twi_cmd_s
{
  uint8 flags; // START, STOP, ACK/NACK, 
  uint8 dat;
} t_dh_twi_cmd;

typedef struct dh_twi_packet_s
{
  const uint8 cnt;
  uint8 lstidx;
  uint8 nxtidx;
  t_dh_twi_cmd * const pcmds;
} t_dh_twi_packet;

typedef struct dh_twi_stat_s
{
  uint8 state; // current state
  uint8 c_id; // current client ID
  uint8 lst_c_id; // last client ID 
  t_dh_twi_packet * cmd_pkts[DH_TWI_CLIENT_CNT];
} t_dh_twi_stat;

// function prototypes

extern void  dh_twi_init ( void );

extern uint8 dh_twi_tx   ( uint8 addr, uint8 cmd, uint8 data, uint8 clnt );

extern uint8 dh_twi_rx   ( uint8 *dst, uint8 clnt );

extern void  dh_twi_isr  ( void );

extern uint8 dh_twi_getstat ( uint8 clnt );

extern void dh_twi_setpkt ( uint8 client, t_dh_twi_packet *ppkt);

extern uint8 dh_twi_imm  ( t_dh_twi_packet *ppkt );

extern uint8 dh_twi_err_TWSR;

#endif // __DH_TWI_H__
