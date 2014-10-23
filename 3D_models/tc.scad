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

// This file creates the modules for the thumb cluster

use <trp.scad>;
use <tf.scad>;
use <tdds.scad>;
use <util.scad>;

include <dimensions.scad>;

module base_ts(st, sclip) {
  translate([-tf_bp_x, 0, tf_bp_h]) {

    if( 1 == st ) rotate(a=90, v=[1,0,0]) trp(0, 0, 0);

    if( 1 == sclip ) rotate(a=90, v=[1,0,0]) 
                      translate([clip_mat_t, -clip_mat_t, -clip_w/2]) 
                       rotate(a=-90, v=[0,1,0]) 
                        clip(0, 0, 0);

    //translate([-irle_m_x + tf_irle_x, -irle_m_y-2, -irle_m_z+tf_irle_z]) rotate( a=-90, v=[0,0,1]) Max_LiteOn_P_100_E302(0, 0, 0, 0);

    //#eye_centered_m_irled(0, 0, 0, -5);

    tf(0, 0, 0);


    //tf_screws();

    //color("silver") translate([tf_bp_x, -mag_w/2, -mag_d-clip_mat_t]) cube([mag_h, mag_w, mag_d]);

    translate([trp_spline_x + trp_spline_w/2.0, 0, trp_blade_h + trp_spline_h - kcb_v_h]) {
    
    //keycapbase(0, 0, 0);
    } // translate
  } // translate
} // module base_ts

module potskc() {
 union() {
  keycapbase(0, 0, 0);
  proximal_outer_thumb_keycap(-tf_bp_x, 0, tf_bp_h);
 }
}

module pots(x, y, z, ang, sc, st, sclip) {
  // sc = show cap
  // st = show trp
  translate([x, y, z]) {
    rotate(a=ang, v=[0,0,1]) {
      union() {
        base_ts(st, sclip);
        translate([ trp_spline_x + trp_spline_w/2.0, 
                    0, 
                    trp_blade_h + trp_spline_h - kcb_v_h ]) {
      
          if( 1 == sc ) potskc();

        } // translate
      } // union
    } // rotate
  } // outer translate
} // module

module dotskc() {
 union() {
  keycapbase(0, 0, 0);
  distal_outer_thumb_keycap(-tf_bp_x, 0, tf_bp_h);
 }
}

module dots(x, y, z, ang, sc, st, sclip) {
  // sc = show cap
  // st = show trp
  translate([x, y, z]) {
    rotate(a=ang, v=[0,0,1]) {
      union() {
        base_ts(st, sclip);
        translate([ trp_spline_x + trp_spline_w/2.0, 
                    0, 
                    trp_blade_h + trp_spline_h - kcb_v_h ]) {
    
          if( 1 == sc ) dotskc();

        } // translate
      } // union
    } // rotate
  } // outer translate
} // module

module ditskc() {
 union() {
  keycapbase(0, 0, 0);
  main_inner_thumb_keycap(-tf_bp_x, 0, tf_bp_h);
 }
}

module dits(x, y, z, ang, sc, st, sclip) {
  // sc = show cap
  // st = show trp
  translate([x, y, z]) {
    rotate(a=ang, v=[0,0,1]) {
      union() {
        base_ts(st, sclip);
        translate([ trp_spline_x + trp_spline_w/2.0, 
                    0, 
                    trp_blade_h + trp_spline_h - kcb_v_h ]) {
    
          if( 1 == sc ) ditskc();

        } // translate
      } // union
    } // rotate
  } // outer translate
} // module

module pitskc() {
 union() {
  keycapbase(0, 0, 0);
  upper_inner_thumb_keycap(-tf_bp_x, 0, tf_bp_h); 
 }
}

module pits(x, y, z, ang, sc, st, sclip) {
 // sc = show cap
 // st = show trp
  translate([x, y, z]) {
    rotate(a=ang, v=[0,0,1]) {
      union() {
        base_ts(st, sclip);
        translate([ trp_spline_x + trp_spline_w/2.0, 
                    0, 
                    trp_blade_h + trp_spline_h - kcb_v_h ]) {
    
          if( 1 == sc ) pitskc();

        } // translate
      } // union
    } // rotate
  } // outer translate
} // module
