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

// this is the 5-key assembly scad file.

use <lever.scad>;
use <carrier.scad>;
use <LiteOn_P_100_E302.scad>;

// Nom_LiteOn_P_100_E302(-10, 0, 0);

include <dimensions.scad>;

echo("width of magnet showing is:", mag_w-2*lip_w);
echo("height of magnet is:", mag_h);

module key_assy(x, y, z, ang, t, ll, sk, sc, sm, pr, fs) {
  // a is angle to rotate about vertical axis
  // t parameter is 1 for big key, 0 for small key
  // ll parameter means make it a lower lever base.
  // sk = show key
  // sm = show magnet
  // pr = pinkie riser
  // fs = make it with a "frontstop" (opposite of ll base)
  
  translate([x, y, z]) {
    rotate(a=ang, v=[0,0,1]) {
      carrier(0, 0, 0, ll, sc, pr, fs);

      if(1 == sk) {
        if(0 == t) {
          small_key(wl_x, wl_y, wl_z, sm);
        }
        if(1 == t) {
          big_key(wl_x, wl_y, wl_z, sm);
        }
      } // if(1 == sk)
    }
  }
}

module cbutton(x, y, z) {
  translate([x, y, z]) {
    union() {

      translate([cb_x, cb_y, cb_z]) {
        intersection () {
          difference() {
            cylinder(h=cb_h, r=cb_r, $fn=gfn);
            translate([0,0,cbsdr_z]) sphere(r = cbsd_r, $fn=gfn);
          }
          translate([0,0,-7.5]) sphere(r=cbsd_r, $fn=gfn);
        }
      }

      // make the stem of the center pushbutton
      translate([stem_x, stem_y, stem_z]) {
        difference() {
          // starting volume of stem
          union() {
            cube([stem_w, stem_d, stem_h+csg_tol]);
            // spheres for stem retention
            translate([0, stem_d/2, stem_d/4]) 
              scale(v=[min_detail+min_wall,stem_d/4,stem_d/4]) 
                sphere(r=1, $fn=gfn);
            translate([stem_w, stem_d/2, stem_d/4]) 
              scale(v=[min_detail+min_wall,stem_d/4,stem_d/4]) 
                sphere(r=1, $fn=gfn);
            // spines on edges to reduce friction
            translate([-ss_d, stem_d/2-ss_w/2, 0]) 
              cube([ss_d, ss_w, stem_h+csg_tol]);
            translate([stem_w, stem_d/2-ss_w/2, 0]) 
              cube([ss_d, ss_w, stem_h+csg_tol]);
          }
          // split the bottom of stem for room to snap into position
          translate([stem_w/2 - min_sep, -csg_tol/2, -csg_tol])
            cube([2*min_sep, stem_d+csg_tol, 6.5*min_sep]);
          // round the top of the split to reduce concentration of stress
          translate([stem_w/2, 0, 6.5*min_sep-csg_tol]) rotate(a=-90, v=[1,0,0]) 
            cylinder(r=min_sep, h=stem_d, $fn=gfn);
          // recess both sides of the stem to reduce friction
          translate([2*min_detail, stem_d-min_detail, -min_detail])
            cube([stem_w-4*min_detail, min_detail+csg_tol, stem_h]);
          translate([2*min_detail, -csg_tol, -min_detail])
            cube([stem_w-4*min_detail, min_detail+csg_tol, stem_h]);

          difference() {
            // starting volume of "round the bottom of the stem" box
            translate([-csg_tol-min_sep, -csg_tol, -csg_tol]) 
              cube([stem_w + 2*min_sep + 2*csg_tol, 
                    stem_d + 2*csg_tol, 
                    stem_d/2 + csg_tol]);
            // subtract out a cylinder to get a matching cyl on stem bottom
            translate([-2*csg_tol-min_sep, stem_d/2, stem_d/2]) 
              rotate(a=90, v=[0,1,0]) 
                cylinder(h=sbrc_w, r=(stem_d/2), $fn=gfn);
          } // difference for rounded bottom

        } // difference for stem subtractions

      } // translate stem    

    } // union
  } // translate([x,y,z])
}

module clip2_retainer(x, y, z) {
  // add retainer for center pushbutton clip
  translate([x, y, z])
    intersection() {
      rotate(a=clip2_ret_yrot, v=[0,1,0]) {
        rotate(a=-clip2_ret_zrot, v=[0,0,1]) {
          translate([-1 * (clip2_ret_w_ex + csg_tol), 0, 0]) {
            cube([clip2_ret_w + clip2_ret_w_ex, clip2_ret_d, clip2_ret_h]);
          }
        }
      }

      // trim off the end(s) to make certain that it doesn't end up
      // violating the minimum separations.
      translate([-csg_utol, -2.5 * clip2_ret_d, -2.5*clip2_ret_h ])
        cube([clip2_ret_w + 2 * csg_utol, 5 * clip2_ret_d, 5*clip2_ret_h]);

  } // intersection
}

module chock(x, y, z, ck) {
  // ck = chock: 0=not shown, 1=shown, 2=ghost
  // add in chock which keeps clip2 in position
  if(1 == ck) {
    translate([x, y, z]) {
      cube([clip2_chock_w, clip2_chock_d, clip2_chock_h]);
    }
  }
  if(2 == ck) {
    translate([x, y, z]) {
      %cube([clip2_chock_w, clip2_chock_d, clip2_chock_h]);
    }
  }
}

module chock_tree(x, y, z, tr) {
  // tr = tree for printing: 1=top, 2=bottom
  // add in chock which keeps clip2 in position
  if(1 == tr) {
    translate([x, y, z]) {
      union() {
        cube([clip2_chock_w, clip2_chock_d, clip2_chock_h]);
        cube([min_wire, min_wire, 2.0 * clip2_chock_h]);
      }
    }
  }
  if(2 == tr) {
    translate([x, y, z]) {
      union() {
        cube([clip2_chock_w, clip2_chock_d, clip2_chock_h]);
        translate([0, 0, -clip2_chock_h]) 
          cube([min_wire, min_wire, 2.0 * clip2_chock_h]);
      }
    }
  }
}


module carrier_group(x, y, z, sk, sc, sm, sh, pr, ck, sl) {
  // sk = show keys
  // sc = show clips (ferrous targets)
  // sm = show magnet
  // sh = show holes 
  // pr = pinkie riser
  // ck = chock: 0=not shown, 1=shown, 2=ghost
  // sl = show lower lever 0=not shown, 1=shown

  translate([x, y, z]) {
    union () {

      key_assy(0, 0, 0, 0, 1, 1, sk, sc, sm, pr, 0);
    
      key_assy(floor_w + sw_d - min_wall, sw_d - min_wall, 0, 90, 0, 0, 
               sk, sc, sm, pr, 0);
    
      key_assy(floor_w, 2*sw_d - 2*min_wall + floor_w, 0, 180, 0, 0, 
               sk, sc, sm, pr, 1);
    
      key_assy(-sw_d+min_wall, floor_w + sw_d - min_wall, 0, 270, 0, 0, 
               sk, sc, sm, pr, 0);
    
      // add in support for center PB IR eyes
      // add in volume to hold center pushbutton IRLEDs
      difference() {
        translate([cpilh_x, cpilh_y, cpilh_z-pr]) 
          cube([cpilh_w, cpilh_d, cpilh_h+pr]);

        Max_LiteOn_P_100_E302(cpil_x, cpil_y, cpil_z-csg_utol, -15*min_wall);
        // this doesn't exactly meet the sides of the sphere, 
        // but seems close enough.
        translate([cpilhs_x, cpilhs_y, cpilhs_z-csg_utol-pr]) 
          cylinder(r=irle_m_r, h=irle_z+csg_utol+pr, $fn=gfn);

        if ( 0.0 != pr ) {
          translate([cpil_x, cpil_y, cpil_z-csg_utol-pr]) {
            rotate(a=90, v=[0,0,1]) {
              color("Salmon") {
                cube([irlb_m_w, irlb_m_d, pr+csg_tol]);
              }
            }
          }
        }
      }

      // add in support/guide for center pushbutton stem 
      // long support walls
      translate([cbsw_x-csg_tol/2, cbsw_y, cbsw_z]) 
        cube([cbsw_w+csg_tol, cbsw_d, cbsw_h]);
      translate([cbsw_x-csg_tol/2, 
                 cbsw2_y, 
                 cbsw_z]) 
        cube([cbsw_w+csg_tol, cbsw_d, cbsw_h]);
      // short support walls / retaining function for stem
      translate([cbssw_x, cbssw_y-csg_tol/2, cbssw_z]) 
        cube([cbssw_w, cbssw_d+csg_tol, cbssw_h]);
      translate([cbssw_x + cbssw_w + stem_w + 2*ss_d, 
                 cbssw_y-csg_tol/2, 
                 cbssw_z]) 
        cube([cbssw_w, cbssw_d+csg_tol, cbssw_h]);
      // end walls to tie into surrounding carrier structure
      translate([cbsswc_x, cbsswc_y, cbsswc_z])
        cube([cbsswc_w, cbsswc_d, cbsswc_h]);
      translate([cbsswc_x+cbsw_w+min_wall, cbsswc_y, cbsswc_z])
        cube([cbsswc_w, cbsswc_d, cbsswc_h]);


      translate([floor_w, 0, 0]) {
        mirror(v=[1,0,0]) {
          difference() {
            translate([cpilh_x, cpilh_y, cpilh_z-pr]) 
              cube([cpilh_w, cpilh_d, cpilh_h+pr]);
    
            Max_LiteOn_P_100_E302(cpil_x, cpil_y, cpil_z-csg_utol, -15*min_wall);
            // this doesn't exactly meet the sides of the sphere, 
            // but seems close enough.
            translate([cpilhs_x, cpilhs_y, cpilhs_z-csg_utol-pr]) 
              cylinder(r=irle_m_r, h=irle_z+csg_utol+pr, $fn=gfn);

            if ( 0.0 != pr ) {
              translate([cpil_x, cpil_y, cpil_z-csg_utol-pr]) {
                rotate(a=90, v=[0,0,1]) {
                  color("Salmon") {
                    cube([irlb_m_w, irlb_m_d, pr+csg_tol]);
                  }
                }
              }
            }
          }
        }
      } // translate([floor_w, 0, 0])

      // add retainers for center pushbutton clip
      clip2_retainer(clip2_rb_x + clvw_w + clip2_ret_w - 2*csg_tol, clip2_ret_y + clip2_ret_d/2, clip2_ret_z);

      // add second retainer for center pushbutton clip
      translate([floor_w, 0, 0])
        mirror(v=[1,0,0])
          clip2_retainer(clip2_rb_x + clvw_w + clip2_ret_w - 2*csg_tol, clip2_ret_y + clip2_ret_d/2, clip2_ret_z);

      // add in chock which keeps clip2 in position
      chock(clip2_chock_x, clip2_chock_y, clip2_chock_z, ck);

      echo("x,y,z, d,w,h:", clip2_chock_x, clip2_chock_y, clip2_chock_z, clip2_chock_w, clip2_chock_d, clip2_chock_h);


      // add in little retaining bumps to keep clip2 in position
      translate([cpilh_x + min_wall + ptp_clearance, 
                 clip2_y + clip2_w + proc_tol,
                 cpilh_h + cpilh_z - csg_tol ]) 
        cube([min_wire, min_detail, min_detail + csg_tol]);

      // add in second little retaining bump to keep clip2 in position
      translate([floor_w, 0, 0])
        mirror(v=[1,0,0])
          translate([cpilh_x + min_wall + ptp_clearance, 
                     clip2_y + clip2_w + proc_tol,
                     cpilh_h + cpilh_z - csg_tol]) 
            cube([min_wire, min_detail, min_detail + csg_tol]);
 
      if(1 == sk) {
        cbutton(0, 0, 0);
      }

      if(1 == sl) {
        // make the lower lever for the center button
        translate([wl_x + lev_w, wl_z + lbs_y + min_wall, cpl_z]) 
          rotate(a=-90, v=[1,0,0]) 
            rotate(a=180, v=[0,0,1]) 
              lowlev(0, 0, 0, sm);
      }
 
      if(1 == sc) {
        clip2(clip2_x, clip2_y, clip2_z);
      }
  
    } // union

      if(1 == sh) {
%translate([h01_x - sw_d + min_wall, h01_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h02_x - sw_d + min_wall, h02_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h03_x - sw_d + min_wall, h03_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h04_x - sw_d + min_wall, h04_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h05_x - sw_d + min_wall, h05_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h06_x - sw_d + min_wall, h06_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h07_x - sw_d + min_wall, h07_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h08_x - sw_d + min_wall, h08_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h09_x - sw_d + min_wall, h09_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0A_x - sw_d + min_wall, h0A_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0B_x - sw_d + min_wall, h0B_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0C_x - sw_d + min_wall, h0C_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0D_x - sw_d + min_wall, h0D_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0E_x - sw_d + min_wall, h0E_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0F_x - sw_d + min_wall, h0F_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0G_x - sw_d + min_wall, h0G_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0H_x - sw_d + min_wall, h0H_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0I_x - sw_d + min_wall, h0I_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0J_x - sw_d + min_wall, h0J_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);
%translate([h0K_x - sw_d + min_wall, h0K_y, -2]) cylinder(h=6, r=irll_w/2, $fn=gfn);

    }

  } // translate
} // carrier_group


// magnet height should be at top of opening in nylon housing for ir eye.
// the top of this opening is sqrt(irle_m_r^2 - minwall^2) above eye center.


