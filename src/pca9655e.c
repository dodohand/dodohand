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

#include "pca9655e.h"
#include <util/twi.h>


#define PCA9655E_WR_CFG_CMD_CNT ( 6u )
t_dh_twi_cmd pca9655e_wr_cfg_cmds[PCA9655E_WR_CFG_CMD_CNT] = {
  { DH_TWI_CMD_START, 0 },
  { 0, DH_IOE_ADDR | TW_WRITE },           // address the PCA9655E
  { 0, PCA9655E_REG_CMD_CFG0 },            // address config register 0
  { 0, DH_PCA9655E_CR0_DEF },              // write to CR0
  { 0, DH_PCA9655E_CR1_DEF },              // write to CR1
  { DH_TWI_CMD_STOP, 0 } 
};

static t_dh_twi_packet wr_cfg_pkt = { PCA9655E_WR_CFG_CMD_CNT, 
                                      0,
                                      0,
                                      pca9655e_wr_cfg_cmds };

// note that this reads the inputs before writing the outputs so that status 
// can be read before changing outputs invalidates results.
#define PCA9655E_CYC_CMD_CNT ( 13u )
t_dh_twi_cmd pca9655e_cyc_cmds[PCA9655E_CYC_CMD_CNT] = {
  { DH_TWI_CMD_START, 0 },
  { 0, DH_IOE_ADDR | TW_WRITE },           // address the PCA9655E
  { 0, PCA9655E_REG_CMD_IP0 },             // address IP0 register
  { DH_TWI_CMD_START, 0 },
  { 0, DH_IOE_ADDR | TW_READ },            // re-address PCA9655E
  { DH_TWI_CMD_READ | DH_TWI_CMD_ACK, 0 }, // elicit IP0 register contents
  { DH_TWI_CMD_READ, 0 },                  // elicit IP1 register contents
  { DH_TWI_CMD_START, 0 },
  { 0, DH_IOE_ADDR | TW_WRITE },
  { 0, PCA9655E_REG_CMD_OP0 },
  { 0, 0 }, // default to turning off the outputs
  { 0, 0 }, // default to turning off the outputs
  { DH_TWI_CMD_STOP, 0 }
};

static t_dh_twi_packet cyc_pkt = { PCA9655E_CYC_CMD_CNT,
                                   0,
                                   0,
                                   pca9655e_cyc_cmds };


#define PCA9655E_SCANRH_CMD_CNT ( 67u )
/* 
 * Important Note: This approach will work at 100kHz, but may not work 
 * at higher I2C frequencies as the phototransistors need some time to
 * stabilize before being read. Careful evaluation of actual timing
 * will be needed to determine if higher I2C frequencies will drive a
 * need to re-structure the communications to ensure acceptable switch
 * state evaluation timing. Alternately, the intra-packet Stop->Start
 * Timer1A delayed interrupt might be extended to achieve acceptable
 * timing at higher clock speeds...
 */
t_dh_twi_cmd pca9655e_scanrh_cmds[PCA9655E_SCANRH_CMD_CNT] = {
  /* Send init sequence so that keyboard recovers quickly if reattached */
  { DH_TWI_CMD_START, 0 },
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_CFG0 },           // address config register 0
  { 0, DH_PCA9655E_CR0_DEF },             // write to CR0
  { 0, DH_PCA9655E_CR1_DEF },             // write to CR1
  { DH_TWI_CMD_STOP, 0 },
  /* start scanning matrix */
  { DH_TWI_CMD_START, 0 },                // send START on I2C - write addr
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_OP0 },            // address the OP0 register ( 2 LEDs )
  { 0, 0 }, // idx=9  OP0 outputs ( 2 LEDs ) default to turning off the outputs
  /* Turn ON Row0 */
  { 0, 0 }, // idx=10  OP1 outputs ( Matrix Rows, etc ) default to off
  { DH_TWI_CMD_STOP, 0 },
  { DH_TWI_CMD_START, 0 },                // send START on I2C - write addr
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_IP0 },            // address the IP0 register
  { DH_TWI_CMD_START, 0 },                // send Re-Start on I2C - read inputs
  { 0, DH_IOE_ADDR | TW_READ },           // address the PCA9655E
  /* Read state of North Switches */
  { DH_TWI_CMD_READ | DH_TWI_CMD_NAK, 0}, // idx=17 elicit IP0 register contents
  { DH_TWI_CMD_START, 0 },                // send Re-Start - write outputs
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_OP1 },            // address the OP0 register ( 2 LEDs )
  /* Turn ON Row1 */
  { 0, 0 }, // idx=21  OP1 outputs ( Matrix Rows, etc ) default to off
  { DH_TWI_CMD_STOP, 0 },
  { DH_TWI_CMD_START, 0 },                // send START on I2C - write addr
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_IP0 },            // address the IP0 register
  { DH_TWI_CMD_START, 0 },                // send Re-Start on I2C - read inputs
  { 0, DH_IOE_ADDR | TW_READ },           // address the PCA9655E
  /* Read state of East Switches */
  { DH_TWI_CMD_READ | DH_TWI_CMD_NAK, 0}, // idx=28 elicit IP0 register contents
  { DH_TWI_CMD_START, 0 },                // send Re-Start - write outputs
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_OP1 },            // address the OP0 register ( 2 LEDs )
  /* Turn ON Row2 */
  { 0, 0 }, // idx=32  OP1 outputs ( Matrix Rows, etc ) default to off
  { DH_TWI_CMD_STOP, 0 },
  { DH_TWI_CMD_START, 0 },                // send START on I2C - write addr
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_IP0 },            // address the IP0 register
  { DH_TWI_CMD_START, 0 },                // send Re-Start on I2C - read inputs
  { 0, DH_IOE_ADDR | TW_READ },           // address the PCA9655E
  /* Read state of Center Switches */
  { DH_TWI_CMD_READ | DH_TWI_CMD_NAK, 0}, // idx=39 elicit IP0 register contents
  { DH_TWI_CMD_START, 0 },                // send Re-Start - write outputs
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_OP1 },            // address the OP0 register ( 2 LEDs )
  /* Turn ON Row3 */
  { 0, 0 }, // idx=43 OP1 outputs ( Matrix Rows, etc ) default to off
  { DH_TWI_CMD_STOP, 0 },
  { DH_TWI_CMD_START, 0 },                // send START on I2C - write addr
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_IP0 },            // address the IP0 register
  { DH_TWI_CMD_START, 0 },                // send Re-Start on I2C - read inputs
  { 0, DH_IOE_ADDR | TW_READ },           // address the PCA9655E
  /* Read state of South Switches */
  { DH_TWI_CMD_READ | DH_TWI_CMD_NAK, 0}, // idx=50 elicit IP0 register contents
  { DH_TWI_CMD_START, 0 },                // send Re-Start - write outputs
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_OP1 },            // address the OP0 register ( 2 LEDs )
  /* Turn ON Row4 */
  { 0, 0 }, // idx=54 OP1 outputs ( Matrix Rows, etc ) default to off
  { DH_TWI_CMD_STOP, 0 },
  { DH_TWI_CMD_START, 0 },                // send START on I2C - write addr
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_IP0 },            // address the IP0 register
  { DH_TWI_CMD_START, 0 },                // send Re-Start on I2C - read inputs
  { 0, DH_IOE_ADDR | TW_READ },           // address the PCA9655E
  /* Read state of West Switches */
  { DH_TWI_CMD_READ | DH_TWI_CMD_NAK, 0}, // idx=61 elicit IP0 register contents
  { DH_TWI_CMD_START, 0 },                // send Re-Start - write outputs
  { 0, DH_IOE_ADDR | TW_WRITE },          // address the PCA9655E
  { 0, PCA9655E_REG_CMD_OP1 },            // address the OP0 register ( 2 LEDs )
  /* Turn OFF Row4 ( leave diodes OFF by default to extend life ) */
  { 0, 0 }, // idx=65 OP1 outputs ( Matrix Rows, etc ) default to off
  { DH_TWI_CMD_STOP, 0 }
};

static t_dh_twi_packet scanrh_pkt = { PCA9655E_SCANRH_CMD_CNT,
                                      0,
                                      0,
                                      pca9655e_scanrh_cmds };


uint8 pca9655e_init_stat = 255;

void pca9655e_init(void)
{
  // PCA9655E supports 100kHz, 400kHz, and 1MHz
  // the ATmega32u4 supports up to 400kHz
  //

  pca9655e_init_stat = dh_twi_imm ( &wr_cfg_pkt );

  return;
}

void pca9655e_trig_scanrh(void)
{
  dh_twi_setpkt(DH_TWI_CLIENT_IOX, &scanrh_pkt);
}

void pca9655e_wait_for_scanrh(void)
{
  while ( scanrh_pkt.cnt != scanrh_pkt.lstidx 
          && scanrh_pkt.cnt != scanrh_pkt.nxtidx );
}

void pca9655e_trig_cyc(void)
{
  dh_twi_setpkt(DH_TWI_CLIENT_IOX, &cyc_pkt);
}

void pca9655e_trig_init(void)
{
  dh_twi_setpkt(DH_TWI_CLIENT_IOX, &wr_cfg_pkt);
  pca9655e_set_row_strobes();
}
