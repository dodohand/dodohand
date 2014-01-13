Please see the GeekHack thread on this topic for details.

http://geekhack.org/index.php?topic=41422.0

This project is built around the Teensy 2.0 and is currently using
debug tools from PJRC. Please find the hid_listen tool from PJRC
in order to receive the debug messages from the test DodoHand 
firmware.

At attempt at some more coherent notes:

A Brief History

The DataHand keyboard is a design that I have come to rely heavily
upon and do not want to be without. It allows me to type pain-free
for hours at a time, day after day. DataHand Systems has been out
of production for some 10 years now, and their website has even
recently been taken down so I feel left to my own devices to ensure
a long-term future of pain-free typing. This has spawned the DodoHand
project - an attempt to resurrect the now-extinct DataHand.

So you want to create a DodoHand

Current status: The finger switch design is usable. The thumb cluster 
is not yet designed. A case has been designed by Turbinia, but has 
never been built. There are provisions in hardware for supporting an 
EasyPoint or another joystick but these have not been implemented in
software.

The first step is to get all the parts headed your way. There is 
a BOM.ods (Bill of Materials) in the documentation folder which 
contains a list of the parts needed. That should be your guide.

- Electronics:

There are part numbers and links to Digikey which should make
it easier to get the electronics order placed. 

- 3D-printed parts:

In the 3D_models directory the files plf.scad and show_prf.scad 
should be opened with a recent version of OpenSCAD, compiled, and 
exported as .STL files. These can then be uploaded to Shapeways 
and printed in the "Black, Strong and Flexible" material. Please 
note that there are some fairly tight tolerances and that the 
design requires a bit of flexibility in the printed models in 
order to retain the magnets and center button clips, so don't 
try to print them in an inflexible, or fragile material, or one
with less fidelity than the SLS Nylon "Black, Strong and Flexible".

- PCB:

In the sch_and_pcb folder open up kicad_fingers.brd with a recent
build of KiCAD (I have been working with a build from sources
downloaded in November, 2013) and plot the Gerber files. Verify 
that the drill file matches up with the other files using gerbview
or another Gerber file viewer, then send to a suitable PCB fab
operation like OSH Park, pcbwing, etc. Note that OSH Park will
silently drop overlapping holes so the double-sided TRRS connector
footprint will not be manufactured exactly correctly, but is very
usable anyhow.

Note that you're likely going to need to edit the KiCAD library 
settings in order to point KiCAD at the appropriate library files
in the component_lib directory.

- Metal "clips" which serve as a magnetic attractor

These you'll need to fabricate on your own until/unless I (or you!) 
can find a shop to make them. There is a drawing: tooling/clip_bending_jig.dxf
which I used to create a bending jig. LibreCAD was used to create 
this drawing (turn various layers on/off to help see what's going on).
I substituted 1mm pins for all positions since that is what I was 
able to find from McMaster-Carr, and have been satisfied with the 
results. I used 7075 aluminum IIRC for the body of the jig. Be 
certain to order several drill bits of these small sizes - they're 
very fragile. Also, find a drill press or mill - you aren't likely 
to be successful trying to drill these holes by hand.

Assembly

The only challenging part of assembly is fitting the 3D-printed parts
together. The Shapeways process has varied enough that some batches
fall right together without much work while others require quite a 
bit of time with a hobby knife, pick, and pin vise. These tools are
needed to re-open the passages for the infrared LED and phototransistor
leads, remove partially sintered material that was not cleaned away
by shapeways, and trim away excess material when their process is 
running on the extra-material end of the spectrum. You are likely
to spend between 2 and 15 minutes on each finger, depending upon 
your luck with Shapeways. Be thorough with the pick in removing
partially sintered material, or each time you insert a part, it
won't go well and you'll end up picking out another little batch
of dust to clear up the void that should have been there.

You should consider ordering a solder-paste stencil for each side
of the PCB. I did the 160 0-Ohm jumpers by-hand, meting out little
dabs of paste onto each pad. That went fine, but I would really
have liked to be able to just squeege across and get on to dropping
those little buggers onto their homes. If you do this, let me know
how it goes!

Don't be afraid of SMD soldering if you haven't done it before.
Particularly with a hot-air wand, it is magically easy. Just a dab
of paste on each pad, drop the part into position, warm it up, and 
when the solder flows the part is pulled into the right spot by
surface tension in the solder. It is just so cool!

Tools used for Assembly:

Here is the list of tools that I recall using so-far in this process:

- a file for cleaning up the little tabs left on the edge of the PCB
  which inevitably get placed right in front of the TRRS connector 
  which is the one spot that they cannot be tolerated.
- no-clean flux
- no-clean wire solder (leaded)
- no-clean solder paste (leaded) (in a syringe)
- no-clean de-soldering braid
- temperature controlled iron - small chisel tip
- hot-air re-work wand
- flush-cut lead snips
- various curved and straight tweezers
- bench shear for cutting metal clips
- dial calipers for measuring and setting metal clip dimensions
- digital multimeter for testing solder joints
- dental pick
- hobby knife
- Mill for accurately placing holes in bending jig
- tiny drill bits for holes for 1mm pins in bending jig
- pin vise and assorted pin vise drill bits for opening IR lead passages

Programming the keyboard

Yeah, about that... I don't have the actual keyboard firmware written
quite yet. src/led_test.c scans the matrix of the right-hand side of
the keyboard via I2C and recognizes switch presses, but that is as
far as I have currently taken it. Soon...

In any case, the Teensy 2.0 comes with a nice bootloader, and the
tactile switch SW1 is hooked to the teensy reset switch which starts
the bootloader. If you get the paths set correctly in Makefile for 
your system, and type make test_prog, the source will build and then
wait to recognize the Teensy bootloader - just press that reset at
that time and away you go.



