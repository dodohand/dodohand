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

include <dimensions.scad>;

use <LiteOn_P_100_E302.scad>;

// bend_1 goes out from into the X direction and up
module c_r_bend_1(x, y, z) {
  // the piece of a clip which composes the corner-bend,
  // will be used to show the bend instead of a perfect square connection

  translate([x, y, z]) {

    translate([0, 0, clip_bend_h]) rotate(a=-90, v=[1,0,0]) {
    
      intersection() {
    
        difference() {
          // cylinder which has it's outer surface as the outside of the bend
          cylinder(h=clip_w, r=clip_bend_h, $fn=gfn);
          
          // subtract cylinder to leave inner radius of bend -- leaves a toroid
          translate([0, 0, -csg_tol/2]) 
            cylinder(h=clip_w+csg_tol, r=clip_inn_r, $fn=gfn);
      
        } // end difference
    
        cube([clip_bend_h, clip_bend_h, clip_w]);
    
      } // intersection
    } // translate/rotate
  } // translate([x,y,z])
}

// bend_2 goes out into the x direction and down.
module c_r_bend_2(x, y, z) {
  // the piece of a clip which composes the corner-bend,
  // will be used to show the bend instead of a perfect square connection

  translate([x, y, z]) {

    translate([0, clip_w, -clip_inn_r]) rotate(a=90, v=[1,0,0]) {
    
      intersection() {
    
        difference() {
          // cylinder which has it's outer surface as the outside of the bend
          cylinder(h=clip_w, r=clip_bend_h, $fn=gfn);
          
          // subtract cylinder to leave inner radius of bend -- leaves a toroid
          translate([0, 0, -csg_tol/2]) 
            cylinder(h=clip_w+csg_tol, r=clip_inn_r, $fn=gfn);
      
        } // end difference
    
        cube([clip_bend_h, clip_bend_h, clip_w]);
    
      } // intersection
    } // translate/rotate
  } // translate([x,y,z])
}

// bend_3 goes up into the z direction and then curves into X.
module c_r_bend_3(x, y, z) {
  // the piece of a clip which composes the corner-bend,
  // will be used to show the bend instead of a perfect square connection

  translate([x, y, z]) {

    translate([clip_mat_t, 0, 0]) rotate(a=-90, v=[0,1,0]) 
    translate([0, clip_w, -clip_inn_r]) rotate(a=90, v=[1,0,0]) {
    
      intersection() {
    
        difference() {
          // cylinder which has it's outer surface as the outside of the bend
          cylinder(h=clip_w, r=clip_bend_h, $fn=gfn);
          
          // subtract cylinder to leave inner radius of bend -- leaves a toroid
          translate([0, 0, -csg_tol/2]) 
            cylinder(h=clip_w+csg_tol, r=clip_inn_r, $fn=gfn);
      
        } // end difference
    
        cube([clip_bend_h, clip_bend_h, clip_w]);
    
      } // intersection
    } // translate/rotate
  } // translate([x,y,z])
}

// bend_4 goes down in the z direction and then curves into X.
module c_r_bend_4(x, y, z) {
  // the piece of a clip which composes the corner-bend,
  // will be used to show the bend instead of a perfect square connection

  translate([x, y, z]) {
    translate([0, clip_w, 0]) rotate(a=180, v=[1,0,0])
    translate([clip_mat_t, 0, 0]) rotate(a=-90, v=[0,1,0]) 
    translate([0, clip_w, -clip_inn_r]) rotate(a=90, v=[1,0,0]) {
    
      intersection() {
    
        difference() {
          // cylinder which has it's outer surface as the outside of the bend
          cylinder(h=clip_w, r=clip_bend_h, $fn=gfn);
          
          // subtract cylinder to leave inner radius of bend -- leaves a toroid
          translate([0, 0, -csg_tol/2]) 
            cylinder(h=clip_w+csg_tol, r=clip_inn_r, $fn=gfn);
      
        } // end difference
    
        cube([clip_bend_h, clip_bend_h, clip_w]);
    
      } // intersection
    } // translate/rotate
  } // translate([x,y,z])
}

module clip(x, y, z) {
  translate([x, y, z]) {
    
    color("Silver") union() {

// Clip #1 ( for N,S,E,W buttons )
//
//       <-- A -->
//      ----------
//     D|<-B>
//      -----
//           |E
//         --
//         C

      translate([0, 0, -clip_A]) cube([clip_w, clip_mat_t, clip_A -clip_inn_r]);
      rotate(a=90, v=[0,0,1]) c_r_bend_3(0, -clip_w, -clip_inn_r);
      translate([0, clip_bend_h, 0]) 
        cube([clip_w, clip_D-clip_bend_h-clip_bend_h, clip_mat_t]);
      rotate(a=90, v=[0,0,1]) c_r_bend_2(clip_D-clip_bend_h, -clip_w, 0);
      translate([0, clip_D-clip_mat_t, -clip_B+clip_inn_r ])
        cube([clip_w, clip_mat_t, clip_B-(2*clip_inn_r)]);
      rotate(a=90, v=[0,0,1]) 
        c_r_bend_4(clip_D-clip_mat_t,-clip_w,-clip_B-clip_mat_t+clip_bend_h);
      translate([0, clip_D-clip_mat_t+clip_bend_h, -clip_B-clip_mat_t]) 
        cube([clip_w, clip_E-clip_bend_h-clip_bend_h, clip_mat_t]);
      rotate(a=90, v=[0,0,1]) 
        c_r_bend_1(clip_D+clip_E-clip_mat_t-clip_bend_h, -clip_w, -clip_B-clip_mat_t);
      translate([0, clip_D+clip_E-2*clip_mat_t, -clip_B+clip_inn_r])
        cube([clip_w, clip_mat_t, clip_C-clip_inn_r]);
    } // union
  } // translate
} // module clip

module clip2(x, y, z) {
  translate([x, y, z]) {
    color("Silver") union() {

// Clip #2 (for center button)
//
//   C             C
// ------       ------
//     B|       |B
//      ---------
//          A

      translate([ clip2_C1_x, 0, clip2_B]) {
        cube([clip2_C-clip_bend_h, clip2_w, clip_mat_t]);
        c_r_bend_2(clip2_C-clip_bend_h, 0, 0);
      }
      translate([ clip2_B1_x, 0, clip_bend_h]) {
        cube([clip_mat_t, clip2_w, clip2_B-clip_inn_r-clip_bend_h]);
        c_r_bend_4(0, 0, 0);
      }
      translate([ clip2_A_x, 0, 0]) {
        cube([clip2_A-(2*clip_bend_h), clip2_w, clip_mat_t]);
        c_r_bend_1(clip2_A-(2*clip_bend_h), 0, 0);
      }
      translate([ clip2_B2_x, 0, clip_bend_h]) {
        cube([clip_mat_t, clip2_w, clip2_B-clip_bend_h-clip_inn_r]);
        c_r_bend_3(0, 0, clip2_B-clip_inn_r-clip_bend_h);
      }
      translate([ clip2_C2_x, 0, clip2_B]) 
        cube([clip2_C-clip_bend_h, clip2_w, clip_mat_t]);

    } // union
  } // translate
} // module clip2

module sidewall(pr) {
  // pr = pinkie riser
  union() {
    difference() {
      union() {
        // make sidewall 
        translate([sw_x, sw_y, sw_z]) cube([sw_w, sw_d, sw_h]);
        // make cap that blocks light from hitting sensor
        translate([swcap_x, swcap_y, swcap_z])
          cube([swcap_w, swcap_d, swcap_h]);
      }
      // subtract sidewall lock void
      translate([swlv_x, swlv_y-csg_tol, swlv_z]) 
        cube([swlv_w+csg_tol, swlv_d+csg_tol, swlv_h]);
      // subtract the sidewall lock void relief
      translate([swlvr_x, swlvr_y, swlvr_z]) 
        rotate(a=swlvr_a, v=[1,0,0]) 
          cube([swlvr_w+csg_tol, swlvr_d, swlvr_h]);
      // subtract max-tolerance IR device
      Max_LiteOn_P_100_E302(irl_x, irl_y, irl_z, -min_wall-csg_utol-pr);
      // subtract to make lever out of back of sidewall so eye can snap in
      translate([swlc_x-(csg_tol/2), swlc_y, swlc_z]) 
        cube([swlc_w+irltol+csg_tol, swlc_d, swlc_h]);
      translate([swlc_x-(csg_tol/2), swlc_y + irlb_w + irltol -swlc_d, swlc_z]) 
        cube([swlc_w+irltol+csg_tol, swlc_d, swlc_h]);
      // subtract cylinder to make opening/shield for eye
      translate([-csg_tol+min_wall+irlb_m_d, min_wall+irle_m_x, irl_z+irle_m_z])
        rotate(a=90, v=[0,1,0]) 
          cylinder(h=sw_eye_wall_w+2*csg_tol, r=irle_m_r, $fn=gfn);
    }
    // add in retaining bump to ensure that a nominal IR device is held firm
    translate([min_wall, irl_y + irle_x, irl_z + irle_z]) 
    sphere(r=irltol*1.5, $fn=gfn);

  }
}

module sll(pr) {
  // ll parameter means make accomodations for lowlev 
  // pr = pinkie relief
  union() {
    difference() {
      // make sidewall 
      union() {
        translate([sw_x, sw_y, sw_z]) cube([sw_w, sw_d, sw_h]);
        // make cap that blocks light from hitting sensor
        translate([swcap_x, swcap_y, swcap_z])
          cube([swcap_w, swcap_d, swcap_h]);
        // sidewall extension
        translate([sw_x, lbs_y + lbs_d, sw_z]) 
          cube([sw_w, swlv_h + swlv_z + min_wall, sw_d]);
        // add xtra material to stop sharp point for angled relief
      }
      // subtract sidewall lock void
      translate([swlv_x, swlv_y-csg_tol, swlv_z]) 
        cube([swlv_w+csg_tol, swlv_d+csg_tol, swlv_h]);
      // subtract the sidewall lock void relief
      translate([swlvr_x, swlvr_y, swlvr_z]) 
        rotate(a=swlvr_a, v=[1,0,0]) 
          cube([swlvr_w+csg_tol, swlvr_d, swlvr_h]);

      // subtract max-tolerance IR device
      Max_LiteOn_P_100_E302(irl_x, irl_y, irl_z, -min_wall-csg_utol-pr);
      // subtract to make lever out of back of sidewall so eye can snap in
      translate([swlc_x-(csg_tol/2), swlc_y, swlc_z]) 
        cube([swlc_w+irltol+csg_tol, swlc_d, swlc_h]);
      translate([swlc_x-(csg_tol/2), swlc_y + irlb_w + irltol - swlc_d, swlc_z])
        cube([swlc_w+irltol+csg_tol, swlc_d, swlc_h]);

      // subtract cylinder to make opening/shield for eye
      translate([-csg_tol+min_wall+irlb_m_d, min_wall+irle_m_x, irl_z+irle_m_z])
        rotate(a=90, v=[0,1,0]) 
          cylinder(h=sw_eye_wall_w+2*csg_tol, r=irle_m_r, $fn=gfn);

      // ll lock void:
      translate([0, lbs_y + lbs_d, 0]) {
        rotate(a=-90, v=[1, 0, 0]) {
          mirror(v=[0,1,0]) {
            // subtract sidewall lock void
            translate([swlv_x, swlv_y-csg_tol, swlv_z]) 
              cube([swlv_w+csg_tol, cpl_z+lev_d+csg_tol, swlv_h]);
            // subtract the sidewall lock void relief
            translate([swlvr_x, swlvr_y+cpl_catch_z, swlvr_z]) 
              rotate(a=swlvr_a, v=[1,0,0]) 
                translate([0, -0.5, 0]) 
		  cube([swlvr_w+csg_tol, swlvr_d+0.5, swlvr_h+2]);
          } // end of mirror
        } // end of rotate
      } // end translate

    } // end of difference

    // add in retaining bump to ensure that a nominal IR device is held firm
    translate([min_wall, irl_y + irle_x, irl_z + irle_z]) 
    sphere(r=irltol*1.5, $fn=gfn);

    translate([sw_x + sw_w - swlvr_w - min_wall, lbs_y + lbs_d + swlv_h + swlv_z + min_wall - csg_tol, sw_z]) 
      cube([swlvr_w+min_wall, min_wall+csg_tol, 3]);


  } // end of union
}


module carrier(x, y, z, ll, sc, pr, fs) {
  // ll parameter means make accomodations for lowlev 
  // sc = show clip (ferrous target)
  // pr = pinkie riser
  // fs = frontstop (not because it is on the front, but already have backstop)

  translate([x,y,z]) {
    union() {
      difference() {
        translate([0, 0, -floor_h-pr]) cube([floor_w, floor_d, floor_h+pr]);
        // make clearance for leads of IR devices
        Max_LiteOn_P_100_E302(irl_x, irl_y, irl_z, -min_wall-csg_utol-pr);
        translate([floor_w, 0, 0]) 
          mirror([1,0,0])
            Max_LiteOn_P_100_E302(irl_x, irl_y, irl_z, -min_wall-csg_utol-pr);
      } // end difference
      translate([catch_x, catch_y, catch_z - csg_tol]) cube([catch_w, catch_d, catch_h + csg_tol]);
      difference() {
        union () {
          translate([lbs_x, lbs_y, lbs_z - csg_tol]) cube([lbs_w, lbs_d, lbs_h + csg_tol]);
          translate([pg_x, pg_y, pg_z]) cube([pg_w, pg_d, pg_h]);
        }
        // subtract clearance for magnet keeper
        translate([lbs_x + lbs_w/2 - (min_wire/2+proc_tol), 
                   lbs_y-proc_tol, 
                   keeper_pos_z]) 
          cube([min_wire+2*proc_tol, 
                min_wall+2*proc_tol, 
                min_wire+2*proc_tol+csg_tol]);
      }
      // create a fillet for bottom of catch
      translate([catch_x, catch_y+catch_d, catch_z])
        difference() {
          cube([catch_w, pivot_r, pivot_r]);
          translate([-csg_tol/2, pivot_r, pivot_r]) 
            rotate(a=90, v=[0,1,0]) 
              cylinder(h=catch_w+csg_tol, r=pivot_r, $fn=gfn);
        } // end difference

      if(ll == 1) {
        sll(pr);
        // make other sidewall
        translate([floor_w, 0, 0]) mirror([1,0,0]) sll(pr);

        // correct location for llev catch:
        // cpl_z - catch_h/tan(acos(cpl_z/llev_h)) - catch_d
        // make catch for lowlev
        translate([catch_x, lbs_y + lbs_d-csg_tol, cpl_catch_z]) 
          cube([catch_w, catch_h+csg_tol, catch_d]);

        // create a gap filler to restrict the play of the lowlev and 
        // create a fillet for bottom of catch
        translate([catch_x, lbs_y + lbs_d, cpl_catch_z+catch_d]) {
          difference() {
            cube([catch_w, pivot_r, pivot_r]);
            translate([-csg_tol/2, pivot_r, pivot_r]) 
              rotate(a=90, v=[0,1,0]) 
                cylinder(h=catch_w+csg_tol, r=pivot_r, $fn=gfn);
          } // end difference

          cube([catch_w, pivot_r*2, (cpl_z - (cpl_catch_z+catch_d))/2]);

        } // end translate
      } //end if(ll == 1)

      if(ll == 0) {
        sidewall(pr);
        // make other sidewall
        translate([floor_w, 0, 0]) mirror([1,0,0]) sidewall(pr);
      } // end if (ll == 0)

      // make clip support structure
      // make clip support wall
      difference() {
        union() {
          translate([cswb_x, cswb_y, cswb_z]) cube([cswb_w, cswb_d, cswb_h]);
          if(fs == 0) {
            translate([csw_x-csg_tol, csw_y, csw_z]) cube([csw_w+2*csg_tol, csw_d, csw_h]);
          }
          if(fs == 1) {
            translate([csw_x-csg_tol, csw_y, 0]) cube([csw_w+2*csg_tol, csw_d, csw_k_h]);
          }
        } // end union

        translate([cswc_x, cswc_y, cswc_z]) cube([cswc_w, cswc_d, cswc_h+csg_tol]);
        // try a radius, knowing that the clip will be more round than squared
        translate([cswc_x, cswc_y-(csg_tol/2), cswc_z-cswc_h]) {
          difference() {
            cube([cswc_w, cswc_d+csg_tol, clip_D_inner/2]);
            translate([0, clip_D_inner/2+(csg_tol/2), 0]) {
              rotate(a=90, v=[0,1,0]) 
                cylinder(r=clip_D_inner/2, h=cswc_w, $fn=gfn);
            }
          } // difference
        } // translate
      } // difference

      // make pocket which locks clip into position
      difference() {
        // outer volume
        translate([clvw_x, clvw_y, clvw_z]) cube([clvw_w, clvw_d, clvw_h]);
        // inner void
        translate([clv_x, clv_y-csg_tol, clv_z-csg_tol/2]) 
          cube([clv_w, clv_d+csg_tol, clv_h+csg_tol]);
      }

      if(1 == sc) {
        clip(clip_x, clip_y, clip_z);
      }

    } // end union

  } // end translate
}
