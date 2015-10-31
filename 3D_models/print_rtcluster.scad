/*
    This file is part of the DodoHand project. This project aims to create 
    an open implementation of the DataHand keyboard, capable of being created
    with commercial 3D printing services.

    Copyright (C) 2014 Scott Fohey

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

// printable arrangement of right-hand thumb cluster parts.
// make a mirror of this for the left hand parts.

use <tdds.scad>;
use <util.scad>;
use <tc.scad>;
use <trp.scad>;

include <dimensions.scad>;

tdds_centered(0, 0, tdds_rot_h, 0, 0, 0, 0);

// x, y, z, a, show_cap, show_trp, show_clip
pots(8, (tf_bp_d / 2.0) + min_sep, 0, 0, 0, 0, 0);
dots(8, -(tf_bp_d / 2.0) - min_sep, 0, 0, 0, 0, 0);
dits(8, -((3*tf_bp_d) / 2.0) - 3*min_sep, 0, 0, 0, 0, 0);
pits(8, -((5*tf_bp_d) / 2.0) - 5*min_sep, 0, 0, 0, 0, 0);

tdds_bar_c(0, 0, 12, 0);

trp(10,1,17);
mirror([0,1,0]) trp(10,1,17);

translate([0, -2*(tf_bp_d+2*min_sep), 0]) {
 trp(10,1,17);
 mirror([0,1,0]) trp(10,1,17);
}

translate([1, -22, 5])
 rotate(a=60, v=[1,0,0])
  rotate(a=90, v=[0,0,1])
   pitskc();

translate([21, 52, 12])
 rotate(a=90, v=[0,0,1]) 
  rotate(a=-90, v=[0,1,0]) 
   rotate(a=180, v=[0,0,1]) 
    potskc();

translate([8, 23, 5]) 
 rotate(a=90, v=[0,0,1]) 
  rotate(a=90, v=[0,1,0]) 
   dotskc();

translate([8, 52, 10.5]) 
 rotate(a=90, v=[0,0,1]) 
  rotate(a=-90, v=[0,1,0]) 
   ditskc();

translate([-3, -45, 0])
rotate(a=180, v=[0,0,1])
rotate(a=tdds_kc_aor, v=[1,0,0])
tdds_kc(0, 0, 8);
