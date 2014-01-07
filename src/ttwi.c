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

#include "ttwi.h"

#include "dh_twi.h"

#include <util/twi.h>

#define DH_IOE_ADDR ( 0x30u )
#define PCA9655E_REG_CMD_IP0   (0U)

#define PCA9655E_RD_INP_CMD_CNT ( 8u )
t_dh_twi_cmd pca9655e_rd_inp_cmds[PCA9655E_RD_INP_CMD_CNT] = {
  { DH_TWI_CMD_START, 0 },
  { 0, DH_IOE_ADDR | TW_WRITE },           // address the PCA9655E
  { 0, PCA9655E_REG_CMD_IP0 },             // address IP0 register
  { DH_TWI_CMD_START, 0 },
  { 0, DH_IOE_ADDR | TW_READ },            // re-address PCA9655E
  { DH_TWI_CMD_READ | DH_TWI_CMD_ACK, 0 }, // elicit IP0 register contents
  { DH_TWI_CMD_READ, 0 },                  // elicit IP1 register contents
  { DH_TWI_CMD_STOP, 0 }
};

static t_dh_twi_packet rd_inp_pkt = { PCA9655E_RD_INP_CMD_CNT, 
                                      0,
                                      0,
                                      &(pca9655e_rd_inp_cmds[0]) };


extern void dh_twi_setpkt ( uint8 client, t_dh_twi_packet *ppkt);
extern void dh_twi_init ( void );


int main(void)
{
  unsigned short i = 0;
  unsigned short j = 0;

  dh_twi_init();

  while(1)
    {
      for ( i=0; i < 15000; i++ )
        {
          j++;
        }

      dh_twi_setpkt( 0, &rd_inp_pkt );

    }
  return 0;
}
