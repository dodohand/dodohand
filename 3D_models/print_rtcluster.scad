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


//tdds_centered(0, 0, tdds_rot_h, 0, 0, 0, 0);

// x, y, z, a, show_cap, show_trp, show_clip
pots(8, (tf_bp_d / 2.0) + min_sep, 0, 0, 0, 0, 0);
//dots(8, -(tf_bp_d / 2.0) - min_sep, 0, 0, 0, 0, 0);
//dits(-8, -(tf_bp_d / 2.0) - min_sep, 0, 180, 0, 0, 0);
pits(-8, (tf_bp_d / 2.0) + min_sep, 0, 180, 0, 0, 0);

//tdds_bar_c(0, 0, 12, 0);

translate([9,3,4])
rotate(a=90,v=[0,0, 1]) {
 trp(20, 20, 0);
 translate([20, 40, 5]) mirror([0,1,0]) trp(0, 0, 0);
 trp(20, 20, 10);
}
translate([9,20,4]) rotate(a=90, v=[0,0,1])
 translate([20, 40, 0]) mirror([0,1,0]) trp(0, 0, 0);


/*
translate([0, 33, -tf_bp_h - 1.5]) potskc();
translate([5, 41, -tf_bp_h - 1.5]) rotate(a=180,v=[0,0,1]) pitskc();
translate([15, 41, -tf_bp_h - 1.5]) dotskc();
translate([20, 33, -tf_bp_h - 1.5]) rotate(a=180, v=[0,0,1])ditskc();
*/

translate([22, 22, 11]) 
 rotate(a=-90, v=[0,1,0]) 
  rotate(a=180, v=[0,0,1]) 
   potskc();

translate([8, 25, 5]) 
 rotate(a=90, v=[0,0,1]) 
  rotate(a=90, v=[0,1,0]) 
   dotskc();

translate([8, 58, 11]) 
 rotate(a=90, v=[0,0,1]) 
  rotate(a=-90, v=[0,1,0]) 
   ditskc();


