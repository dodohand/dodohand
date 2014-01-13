AVRLIB=/usr/lib/avr/include

CC=/usr/bin/avr-gcc

TPROG=~/prj/keyboard/teensy_loader_cli/teensy_loader_cli

# Target micro: atmega128 supported by avrsim and supports TWI
#MICRO=atmega128
MICRO=atmega32u4
FREQ=16000000

COPTS=-mmcu=$(MICRO) -std=gnu99 -Os -gdwarf-2 -fpack-struct -fshort-enums -funsigned-char -funsigned-bitfields -Wall -Wstrict-prototypes -MMD -MP -DF_CPU=$(FREQ)
LOPTS=$(COPTS)

all: led_test.lss led_test.sym led_test.eep led_test.hex led_test.elf

ttwi_all: ttwi.lss ttwi.sym ttwi.eep ttwi.hex ttwi.elf

TAGS:
	find . -name "*.c" -or -name "*.h" | etags -o TAGS -l c -
	find $(AVRLIB) -name "*.h" -or -name "*.c" | etags -a -o TAGS -l c -



%.o: %.c %.h
	$(CC) -c $(COPTS) -Wa,-adhlns=./$(*F).lst -MF $@.d $(*F).c -o $@

#dh_twi.o: dh_twi.c dh_twi.h
#	$(CC) -c $(COPTS) -Wa,-adhlns=./dh_twi.lst dh_twi.c -o dh_twi.o
#
#ttwi.o: ttwi.c ttwi.h
#	$(CC) -c $(COPTS) -Wa,-adhlns=./ttwi.lst ttwi.c -o ttwi.o

ttwi.elf: ttwi.o dh_twi.o
	$(CC) $(LOPTS)  -Wa,-adhlns=./ttwi_elf.lst ttwi.o dh_twi.o -o ttwi.elf -Wl,-Map=ttwi.map,--cref 

ttwi.hex: ttwi.elf
	avr-objcopy -O ihex -R .eeprom -R .fuse -R .lock -R .signature ttwi.elf ttwi.hex

ttwi.eep: ttwi.elf
	avr-objcopy -j .eeprom --set-section-flags=.eeprom="alloc,load" --change-section-lma .eeprom=0 --no-change-warnings -O ihex ttwi.elf ttwi.eep

ttwi.lss: ttwi.elf
	avr-objdump -h -S -z ttwi.elf > ttwi.lss

ttwi.sym: ttwi.elf
	avr-nm -n ttwi.elf > ttwi.sym

clean:
	rm -f *.o *.h~ *.c~ Makefile~ ttwi.elf ttwi.lss ttwi.sym ttwi.eep ttwi.hex *.o.d *.lst ttwi.map led_test.sym led_test.map led_test.lss led_test.hex led_test.elf led_test.eep

led_test.elf: scanlh.o scanrh.o led_test.o pca9655e.o dh_twi.o print.o usb_debug_only.o
	$(CC) $(LOPTS)  -Wa,-adhlns=./led_test.lst scanlh.o scanrh.o led_test.o pca9655e.o dh_twi.o print.o usb_debug_only.o -o led_test.elf -Wl,-Map=led_test.map,--cref 

led_test.hex: led_test.elf
	avr-objcopy -O ihex -R .eeprom -R .fuse -R .lock -R .signature led_test.elf led_test.hex

led_test.eep: led_test.elf
	avr-objcopy -j .eeprom --set-section-flags=.eeprom="alloc,load" --change-section-lma .eeprom=0 --no-change-warnings -O ihex led_test.elf led_test.eep

led_test.lss: led_test.elf
	avr-objdump -h -S -z led_test.elf > led_test.lss

led_test.sym: led_test.elf
	avr-nm -n led_test.elf > led_test.sym

testprog: led_test.hex
	$(TPROG) -mmcu=$(MICRO) -w led_test.hex

# connect to the simulator with gdb like: "gdb ttwi.elf" then issue the command
# > target remote localhost:1234
# to connect to the simulator.
#
sim:
	~/simavr/simavr/run_avr -g -m $(MICRO) -f 16000000 ttwi.hex

