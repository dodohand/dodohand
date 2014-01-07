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

// this file is to show the components in their installed positions.

use <lever.scad>;
use <carrier.scad>;
use <LiteOn_P_100_E302.scad>;
use <5key_assy.scad>;

include <dimensions.scad>;

//            x, y, z,sk,sc,sm,sh
difference() {
  carrier_group(0, 0, 0, 1, 1, 1, 0, 0, 2, 1);
  translate([floor_w/2, -1, -5]) cube([50,50,50]);
}
echo("oaw: ", carrier_oaw);
clip_len = clip_A + clip_B + clip_C + clip_D + clip_E;
echo("clip_len (mm, in): ", clip_len, clip_len / 25.4);
echo("clip_w: ", clip_w, clip_w/25.4);

lclip_len = clip2_A + 2*clip2_B + 2*clip2_C;
echo("clip2_len: ", lclip_len, lclip_len/25.4);
echo("clip2_A: ", clip2_A);
echo("clip2_B: ", clip2_B, clip2_B/25.4);
echo("clip2_C: ", clip2_C);
echo("clip_A: ", clip_A);
echo("clip_B: ", clip_B);
echo("clip_C: ", clip_C);
echo("clip_D: ", clip_D);
echo("clip_E: ", clip_E);
