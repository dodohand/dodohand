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

#ifndef __N35P112_H__
#define __N35P112_H__

#include "dh_twi.h"

// ID Code register
#define N35P112_IDC_ADDR (0x0Cu)
// ID Version register
#define N35P112_IDV_ADDR (0x0Du)
// Silicon Revision
#define N35P112_SRR_ADDR (0x0Eu)
// Control register 1
#define N35P112_CR1_ADDR (0x0Fu)
// X position register
#define N35P112_XR_ADDR  (0x10u)
// Y position register
#define N35P112_YR_ADDR  (0x11u)
// X positive (left) threshold for activation of INTn if enabled
#define N35P112_XPR_ADDR (0x12u)
// X negative (right) threshold for activation of INTn if enabled
#define N35P112_XNR_ADDR (0x13u)
// Y positive (top) threshold for activation of INTn if enabled
#define N35P112_YPR_ADDR (0x14u)
// Y negative (bottom) threshold for activation of INTn if enabled
#define N35P112_YNR_ADDR (0x15u)
// Middle Hall element Control Register - must be set to 0x00 after power-up
#define N35P112_MCR_ADDR (0x2Bu)
// J_ctrl register - must be set to 0x06h after power-up
#define N35P112_JCR_ADDR (0x2Cu)
// scaling control register - must be set to 0x06h after power-up
#define N35P112_TCR_ADDR (0x2Du)
// control register 2 - must be set to 0x86 for easypoint module.
#define N35P112_CR2_ADDR (0x2Eu)

// There are other registers on the N35P112, but I hope to never access them.

// default SparkFun Easypoint I2C address is 0x41
// the " << 1 " puts it into the addres field range in the TWDR register
#define EASYPOINT_I2C_ADDR (0x41u << 1)


#endif //__N35P112_H__
