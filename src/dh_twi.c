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

#include "dh_twi.h"
#include <avr/io.h>
#include <util/twi.h>
#include <util/atomic.h>

static t_dh_twi_stat dh_twi_data;
static t_dh_twi_packet dead_pkt = {0, 1, 1, 0};

void dh_twi_isr ( void );
void dh_twi_queue_stop_isr ( void );

void dh_twi_setpkt ( uint8 client, t_dh_twi_packet *ppkt)
{
  // disable interrupts while processing this
  ATOMIC_BLOCK ( ATOMIC_RESTORESTATE )
  {
    if ( dh_twi_data.c_id != client )
      {
        dh_twi_data.cmd_pkts[client] = ppkt;
        ppkt->lstidx = 0;
        ppkt->nxtidx = 0;
      }

    // TODO: if driver is inactive, kickstart activity

    if ( dh_twi_data.c_id == DH_TWI_CLIENT_NONE )
      { // driver is inactive
        dh_twi_data.c_id = client;
        dh_twi_isr();
      }

  } // reenable interrupts
}

void dh_twi_init ( void )
{
  // turn off internal pull-ups in ATmega32u4 SCL and SDA pins
  // TODO: see above   

  int i;

  dh_twi_data.state = 0;
  dh_twi_data.c_id = DH_TWI_CLIENT_NONE;
  dh_twi_data.lst_c_id = DH_TWI_CLIENT_CNT - 1;
  for ( i=0; i<DH_TWI_CLIENT_CNT; i++ )
    {
      dh_twi_data.cmd_pkts[i] = &dead_pkt;
    }

  // set Power Reduction Register PRR0 to zero to enable TWI
  PRR0 = PRR0 & 0x7F; // turn on twi

  PORTD = PORTD & 0xFC; // turn off  pull-ups for SCL and SDA

  // set TWI Bit Rate Register TWBR and prescaler in TWI Status Register TWSR
  // aim for 100kHz.
  // SCL frequency is (CPU Clock frequency) / (16 + 2(TWBR)*4^TWPS)
  // Teensy 2.0 clock is 16MHz
  // 
  // TWBR should be 10 or higher for TWI to operate in Master Mode
  // (see note in section 20.5.2 of the atmega32u4 datasheet)
  // TWBR is an 8-bit register - all 8 bits are for the TWBR field.
  // 
  // TWSR contains a two-bit field for TWPS.
  //
  // the ATmega32u4 supports up to 400kHz
  //
  // 100kHz requires a divisor of 160 in the above equation. 
  // 2(TWBR)*4^TWPS must be 144.
  // 
  // set TWPS to 0
  // and TWBR to 72.
  TWBR = 72;
  // for 200kHz, TWBR would be 32
  TWSR = 0; // set twps to zero
  
  // set TWCR register appropriately for initialization.
  // set TWIE = 0
  // set bit 1 (reserved) as 0
  // set TWEN = 1
  // set TWWC to 0
  // set TWSTO to 0
  // set TWISTA to 0
  // set TWEA to 0 // never acknowledge - we're the master here!
  // set TWINT to 0 

  TWCR = (1 << TWIE) | (1 << TWEN);
  
  // set global interrupt enable flag
  SREG = SREG | 0x80;
  
  return;
}    

uint8 dh_twi_tx   ( uint8 addr, uint8 cmd, uint8 data, uint8 clnt )
{
  uint8 rv = 0;
  
  // TODO: make certain that the TWI module is idle
  
  // TODO: if idle then load dh_twi_data with address, cmd, ( data ? ), clnt 
  
  // TODO: trigger start of transmit activities in ISR by clearing TWINT bit.
  
  return rv;
}

uint8 dh_twi_rx   ( uint8 *dst, uint8 clnt )
{
  uint8 rv = 0;
  
  // TODO: check status of last transaction for this client and report.
  
  // TODO: return data if it was a read and has completed.
  
  return rv;
}

void  dh_twi_isr  ( void )
{
  // TODO: look at status and history and act appropriately!
  uint8 idx;
  uint8 idx2;
  uint8 tmp;
  t_dh_twi_packet * ppkt = 0;
  t_dh_twi_cmd * pcmd = 0;

  if ( DH_TWI_CLIENT_NONE == dh_twi_data.c_id )
    {
      // figure out of there is a new client packet to send

      // start by looking at the next client after the last completed
      // this will avoid starvation of one of the clients
      idx2 = dh_twi_data.lst_c_id + 1;
      if ( idx2 >= DH_TWI_CLIENT_CNT )
        {
          idx2 = 0;
        }

      for ( idx = 0; idx < DH_TWI_CLIENT_CNT; idx++ )
        {
          // 0 for lstidx and nxtidx means that this packet is ready to go
          if ( ( 0 == dh_twi_data.cmd_pkts[idx2]->lstidx )
               && ( 0 == dh_twi_data.cmd_pkts[idx2]->nxtidx ) )
            {
              // select this client/packet as the next to be transmitted
              dh_twi_data.c_id = idx2;
            }
          else
            {
              idx2++;
              if ( idx2 >= DH_TWI_CLIENT_CNT )
                {
                  idx2 = 0;
                }
            }
        }
    }

  // if there is an active client/packet
  if ( DH_TWI_CLIENT_NONE != dh_twi_data.c_id )
    {
      idx = dh_twi_data.c_id;

      ppkt = dh_twi_data.cmd_pkts[idx];

      if ( ppkt->lstidx != ppkt->nxtidx && ppkt->lstidx < ppkt->cnt )
        { // This message is partially processed. Check if data is waiting
          pcmd = &(ppkt->pcmds[ppkt->lstidx]);

          ppkt->lstidx++;
          
          if ( ppkt->lstidx >= ppkt->cnt )
            { // done with this packet
              dh_twi_data.lst_c_id = dh_twi_data.c_id;

              // TODO: Check to see if there is another packet waiting...

              // set driver state to idle.
              dh_twi_data.c_id = DH_TWI_CLIENT_NONE;
            }

          if ( DH_TWI_CMD_READ & pcmd->flags )
            {
              if ( ( ( DH_TWI_CMD_ACK & pcmd->flags ) 
                     && ( TW_MR_DATA_ACK & 0xF8 & TWSR ) ) 
                   || ( ! ( DH_TWI_CMD_ACK & pcmd->flags ) 
                        && ( TW_MR_DATA_NACK & 0xF8 & TWSR ) ) )
                {
                  pcmd->dat = TWDR;
                }
              else
                {
                  // TODO: Note Error Condition. Re-init command 
                  goto err;
                }
            } // end of READ command processing

          switch ( TWSR & 0xF8 )
            {
            case 0x08:
            case 0x10:
            case 0x18:
            case 0x28:
            case 0x40:
            case 0x50:
            case 0x58:
            case 0xF8: // after STOP has been sent?
              // normal return codes
              break;
            case 0x20:
            case 0x30:
            case 0x38:
            case 0x48:
            default:
              // Note error condition. Re-Init command.
              goto err;
            } 

        } // end of processing of results from previous operation

      if ( ppkt->nxtidx < ppkt->cnt )
        {
          pcmd = &(ppkt->pcmds[ppkt->nxtidx]);
          
          if ( DH_TWI_CMD_START & pcmd->flags )
            {
              // Send START condition
              TWCR = (1 << TWINT)|(1 << TWSTA)|(1 << TWEN)|(1 << TWIE);
            }
          else if ( DH_TWI_CMD_STOP & pcmd->flags )
            {
              // Transmit STOP condition
              TWCR = ( 1 << TWINT )|( 1 << TWEN )|( 1 << TWSTO )|(1 << TWIE);
              if ( ppkt->nxtidx >= ppkt->cnt - 1 ) 
                {
                  goto pktend;
                }
              else
                {
                  dh_twi_queue_stop_isr();
                }
            }
          else if ( DH_TWI_CMD_READ & pcmd->flags )
            {
              tmp = (1 << TWINT) | (1 << TWEN) | (1 << TWIE);
              if ( DH_TWI_CMD_ACK & pcmd->flags )
                {
                  tmp |= ( 1 << TWEA );
                }
              TWCR = tmp;
            }
          else
            { // just a regular write
              // Load Registers with data
              TWDR = pcmd->dat;
              TWCR = (1 << TWINT) | (1 << TWEN) | (1 << TWIE);
            }

          ppkt->nxtidx++;

        } // end of ppkt->nxtidx is less than count
      
    } // end of processing client c_id;

  goto norm;

 err:
  // packet transmission did not complete. re-activate packet.
  ppkt->nxtidx = 0;
  ppkt->lstidx = 0;
  dh_twi_data.state = 1;
  // mark this client as served to prevent starvation of other clients
  dh_twi_data.lst_c_id = dh_twi_data.c_id;
  // TODO: if there is another active client, select that client instead:
  dh_twi_data.c_id = DH_TWI_CLIENT_NONE;

  goto norm;

 pktend:
  // packet transmission completed.
  ppkt->nxtidx = ppkt->cnt;
  ppkt->lstidx = ppkt->cnt;
  dh_twi_data.lst_c_id = dh_twi_data.c_id;
  dh_twi_data.state = 2;
  // TODO: if there is another active client, select that client instead:
  dh_twi_data.c_id = DH_TWI_CLIENT_NONE;

 norm:
  
  return;
}

ISR(TWI_vect)
{
  dh_twi_isr();
}

/* 
 * ATmega32u4 TWI doesn't provide an interrupt upon completion of STOP.
 * This doesn't play that well with the PCA9655e since it seems to need
 * a stop after each change of command. A timer resource will be used
 * in the TWI ISR when a stop is generated to trigger an ISR after the
 * STOP generation must have completed. This way, the transmission of a
 * matrix scan I2C series can continue without wasting time.
 */

// only call this when interrupts are already disabled (like from an ISR)
void dh_twi_queue_stop_isr ( void )
{
  // set WGM to 4 - CTC mode - set clock source to Stopped while setting up.  
  TCCR1B = ( 1 << WGM12 ) | ( 0 << CS12 ) | ( 0 << CS11 ) | ( 0 << CS10 );

  TCCR1A = 0; // do not control output pins from this timer, WGM10 and WGM11 = 0
  // init counter to zero.
  TCNT1 = 0; 
  // 128 ticks @ 16MHz is 8 us - plenty of time to generate a 4us STOP condition
  OCR1A = 256; // upped to 256 to play it safe.
  TIMSK1 = TIMSK1 | ( 1 << OCIE1A );
  // set WGM to 4 - CTC mode - set clock source to no prescaling  
  TCCR1B = ( 1 << WGM12 ) | ( 0 << CS12 ) | ( 0 << CS11 ) | ( 1 << CS10 );
}

ISR(TIMER1_COMPA_vect)
{
  // set WGM to 4 - CTC mode - set clock to stopped to avoid extra interrupt
  TCCR1B = ( 1 << WGM12 ) | ( 0 << CS12 ) | ( 0 << CS11 ) | ( 0 << CS10 );
  dh_twi_isr();
}

uint8 dh_twi_getstat ( uint8 clnt )
{
  uint8 rv = 0;
  
  // TODO: Examine status of this client and report.
  
  return rv;
  
}

#define IS_READ_CYCLE(addr) (addr & TW_READ)

/*
 * dh_twi_imm will be used during initialization and in cases
 * where the ISR solution is not desired.
 */

uint8 dh_twi_err_TWSR;

uint8 dh_twi_imm ( t_dh_twi_packet *ppkt )
{
  uint8 rv = 0;
  uint8 tmp;
  uint8 done = 0;
  t_dh_twi_cmd * pcmd;

  ppkt->lstidx = 0;
  ppkt->nxtidx = 0;

  while ( !done )
    {
      if ( ppkt->lstidx != ppkt->nxtidx && ppkt->lstidx < ppkt->cnt )
        { // This message is partially processed. Check if data is waiting
          pcmd = &(ppkt->pcmds[ppkt->lstidx]);
          rv = ppkt->lstidx;
          ppkt->lstidx++;
          
          if ( ppkt->lstidx >= ppkt->cnt )
            { // done with this packet
              done = 1;
            }

          if ( DH_TWI_CMD_READ & pcmd->flags )
            {
              if ( ( ( DH_TWI_CMD_ACK & pcmd->flags ) 
                     && ( TW_MR_DATA_ACK & 0xF8 & TWSR ) ) 
                   || ( ! ( DH_TWI_CMD_ACK & pcmd->flags ) 
                        && ( TW_MR_DATA_NACK & 0xF8 & TWSR ) ) )
                {
                  pcmd->dat = TWDR;
                }
              else
                {
                  // TODO: Note Error Condition. return failure code 
                  rv = rv | 0x30u;
                  goto err;
                }
            } // end of READ command processing
          
          switch ( TWSR & 0xF8 )
            {
            case 0x08:
            case 0x10:
            case 0x18:
            case 0x28:
            case 0x40:
            case 0x50:
            case 0x58:
              // normal return codes
              break;
            case 0x20:
              rv = rv | 0x10u;
              goto err;
              break;
            case 0x30:
              rv = rv | 0x20u;
              goto err;
              break;
            case 0x38:
              rv = rv | 0x40u;
              goto err;
              break;
            case 0x48:
              rv = rv | 0x80u;
              break;
            default:
              // Note error condition. Re-Init command.
              rv = rv | 0xC0u;
              dh_twi_err_TWSR = TWSR & 0xF8;
              goto err;
              break;
            } 

        } // end of processing of results from previous operation

      if ( ppkt->nxtidx < ppkt->cnt )
        {
          pcmd = &(ppkt->pcmds[ppkt->nxtidx]);
          
          if ( DH_TWI_CMD_START & pcmd->flags )
            {
              // Send START condition
              TWCR = (1 << TWINT) | (1 << TWSTA) | (1 << TWEN);
              // Wait for TWINT Flag to be set.
              while (!(TWCR & (1<<TWINT)))
                {}
            }
          else if ( DH_TWI_CMD_STOP & pcmd->flags )
            {
              // Transmit STOP condition
              TWCR = ( 1 << TWINT ) | ( 1 << TWEN ) | ( 1 << TWSTO );
              done = 1;
            }
          else if ( DH_TWI_CMD_READ & pcmd->flags )
            {
              tmp = (1 << TWINT) | (1 << TWEN);
              if ( DH_TWI_CMD_ACK & pcmd->flags )
                {
                  tmp |= ( 1 << TWEA );
                }
              TWCR = tmp;
              // Wait for TWINT Flag to be set.
              while (!(TWCR & (1<<TWINT)))
                {}
            }
          else
            { // just a regular write
              // Load Registers with data
              TWDR = pcmd->dat;
              TWCR = (1 << TWINT) | (1 << TWEN);
              // Wait for TWINT Flag to be set.
              while (!(TWCR & (1<<TWINT)))
                {}
            }

          ppkt->nxtidx++;

        } // end of ppkt->nxtidx is less than count
      
    } // end of while ( !done )

  // packet transmission completed.
  ppkt->nxtidx = ppkt->cnt;
  ppkt->lstidx = ppkt->cnt;
  rv = 0;
  
  return rv;

 err:
  // packet transmission did not complete. re-activate packet.
  ppkt->nxtidx = 0;
  ppkt->lstidx = 0;
  // Transmit STOP condition
  TWCR = ( 1 << TWINT ) | ( 1 << TWEN ) | ( 1 << TWSTO );

  return rv;
}



/*
// this function is an untested first attempt based on the datasheet.

uint8 dh_twi_tx_imm ( uint8 addr, uint8 cmd, uint8 dcnt, uint8 * data )
{
  uint8 rv = 0;
  uint8 i = 0;
  
  // TODO: make certain that the driver is in immediate mode
  
  // TODO: make certain that the TWI module is idle
  
  // This comes largely directly from the ATMega32u4 datasheet
  //
  // Send START condition
  TWCR = (1<<TWINT)|(1<<TWSTA)|(1<<TWEN);
  
  // Wait for TWINT Flag to be set.
  while (!(TWCR & (1<<TWINT)))
    {}
  
  // Check value of TWI Status Register.
  if ((TWSR & 0xF8) != TW_START)
    {   // This is an error condition
      return 3;
    }
  
  // Load tx register with addr  and send
  TWDR = addr;
  TWCR = (1 << TWINT) | (1 << TWEN);
  
  // Wait for TWINT Flag to be set.
  while (!(TWCR & (1<<TWINT)))
    {}
  
  if ((TWSR & 0xF8) != TW_MT_SLA_ACK)
    {   // this is an error condition
      return 4;
    }
  
  // Load Registers with command and send
  TWDR = cmd;
  TWCR = (1 << TWINT) | (1 << TWEN);
  
  // Wait for TWINT Flag to be set.
  while (!(TWCR & (1<<TWINT)))
    {}
  
  if (( TWSR & 0xF8 ) != TW_MT_DATA_ACK )
    {   // this is an error condition
      return 5;
    } 
  
  if ( IS_READ_CYCLE(addr) )
    { // this is a read cycle
      
      for ( i = 0; i < dcnt; i++ )
        {
          TWCR = (1 << TWINT) | (1 << TWEN) | 
            ( ( (i+1) != dcnt ) << TWEA); // send NACK after last 
          
          // Wait for TWINT Flag to be set.
          while (!(TWCR & (1<<TWINT)))
            {}
          
          if ( (i+1) != dcnt && ( TWSR & 0xF8 ) != TW_MR_DATA_ACK )
            { // this is an error condition
              return 0x06 + i;
            }
          
          if ( (i+1 == dcnt) && ( TWSR & 0xF8 ) != TW_MR_DATA_NACK )
            { // this is an error condition
              return 0x06 + i;
            }
        }
    } // end of read cycle
  else
    { // this is a write cycle
      for ( i = 0; i < dcnt; i++ )
        {
          // Load Registers with data
          TWDR = data[i];
          TWCR = (1 << TWINT) | (1 << TWEN);
          
          // Wait for TWINT Flag to be set.
          while (!(TWCR & (1<<TWINT)))
            {}
          
          if (( TWSR & 0xF8 ) != TW_MT_DATA_ACK )
            {   // this is an error condition
              return 0x86 + i;
            }
        }
    } // end of write cycle
  
  // TODO: Transmit STOP condition
  TWCR = ( 1 << TWINT ) | ( 1 << TWEN ) | ( 1 << TWSTO );
  
  return rv;
}

*/
