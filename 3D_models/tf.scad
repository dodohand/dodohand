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

// This file defines the frame for the 4-per-side thumb switch
// tf_ (Thumb Frame) is the prefix for these dimensions 

use <carrier.scad>;
use <LiteOn_P_100_E302.scad>;
use <util.scad>;

include <dimensions.scad>;

// an eye-centered, and x-aligned irled component
module eye_centered_m_irled(x, y, z, sch) {
  translate([x, y, z]) {
    translate([-irle_m_x, -irle_m_y, -irle_m_z]) {
      rotate( a=-90, v=[0,0,1]) {
        Max_LiteOn_P_100_E302(0, 0, 0, sch);
      } // end rotate
    } // end translate
  } // end translate
} // end module eye_centered_m_irled

module tf_irled_holder(epx, epy, epz) {
  translate([epx, epy, epz]) {
  union() {
    difference() {
      union() {
        // make holder box 
        translate([tf_irlhb_x, tf_irlhb_y, tf_irlhb_z]) {
          cube([tf_irlhb_w, tf_irlhb_d, tf_irlhb_h]);
        }
        // make cap that blocks light from hitting sensor
        translate([tf_irlhbc_x, tf_irlhbc_y, tf_irlhbc_z])
          cube([tf_irlhbc_w, tf_irlhbc_d, tf_irlhbc_h]);
      }
      // subtract max-tolerance IR device
      eye_centered_m_irled(0, 0, (2.0 * csg_utol), -20);
      // subtract to make lever out of back of sidewall so eye can snap in
      translate([tf_lc_x, tf_lc_y-(csg_tol/2), tf_lc_z+csg_utol])
        cube([tf_lc_w, tf_lc_d+csg_tol, tf_lc_h]);
      translate([tf_lc2_x, tf_lc2_y-(csg_tol/2), tf_lc2_z+csg_utol])
        cube([tf_lc_w, tf_lc_d+csg_tol, tf_lc_h]);


      // subtract cylinder to make opening/shield for eye
      translate([0, -sw_eye_wall_w/2.0, 0])
        rotate(a=90, v=[1,0,0]) 
          cylinder(h=sw_eye_wall_w+2*csg_tol, r=irle_m_r, center=true, $fn=gfn);
    }
    // add in retaining bump to ensure that a nominal IR device is held firm
    translate([tf_irlrb_x, tf_irlrb_y, tf_irlrb_z]) 
      sphere(r=tf_irlrb_r, center=true, $fn=gfn);

  } // end union
  } // end translate
} // end module tf_irled_holder

// the back wall of the thumb frame
module tf_backstop() {
  translate([tf_bs_x, tf_bs_y, tf_bs_z]) {
    cube([tf_bs_w, tf_bs_d, tf_bs_h]);
  } // end translate
} // end module tf_backstop

// the upper wall of the thumb frame
module tf_uw() {
  translate([tf_uw_x, tf_uw_y, tf_uw_z]) {
    cube([tf_uw_w, tf_uw_d, tf_uw_h]);
  } // end translate
  translate([tf_uw_x + tf_uw_w - tf_mat_t, 
             tf_uw_y + tf_mat_t - csg_tol, 
             tf_uw_z]) {
    cube([tf_bs_x + tf_bs_w - tf_uw_x - tf_uw_w + tf_mat_t, tf_uw_d, tf_uw_h]);
  }
} // end module tf_uw

// the lower wall of the thumb frame
module tf_lw() {
  translate([tf_lw_x, tf_lw_y, tf_lw_z]) {
    cube([tf_lw_w, tf_lw_d, tf_lw_h]);
  } // end of translate
} // end of module tf_lw

module tf_llw() {
  translate([tf_llw_x, tf_llw_y, tf_llw_z]) {
    cube([tf_llw_w, tf_llw_d, tf_llw_h]);
  }
}

module tf_catch() {
 translate([tf_catch_x, -tf_catch_y, tf_catch_z])
  intersection() {
    rotate(a=tf_catch_a, v=[1,0,0])
      translate([0, -tf_catch_d, -( tf_catch_h * 3.0 ) / 2.0]) 
        cube([tf_catch_w, tf_catch_d, (2.0 * tf_catch_h)]); 
    rotate(a=tf_catch_a2, v=[1,0,0])
      translate([0, -tf_catch_d, -( tf_catch_h * 3.0 ) / 2.0]) 
        cube([tf_catch_w, tf_catch_d, (2.0 * tf_catch_h)]); 
    translate([0, -tf_catch_d, -tf_catch_h])
      cube([tf_catch_w, 1.5 * tf_catch_d, tf_catch_h + csg_tol]);
  } // end intersection
}

// #2 1/4 316 stainless screw #1 phillips drive for attaching tf to PCB
// done this way to take load off of IRLED leads.
module tf_attachment_screw(x, y, z) {
 color("silver") {
  translate([x, y, z]) {
    // the head of the screw
    translate([0, 0, tf_ash_h / 2.0]) {
      cylinder(r = ( tf_ash_d / 2.0 ), h = tf_ash_h, center=true, $fn=gfn);
    } // end of head translate
    // the shaft of the screw
    translate([0, 0, -tf_ass_h / 2.0]) {
      cylinder(r = ( tf_ass_od / 2.0 ), h = tf_ass_h + csg_tol, 
               center=true, $fn=gfn);
    } // end of shaft translate
  } // end of screw translate
 } // end color silver
} // end of tf_attachment_screw

module tf_mag(x, y, z) {
  translate([x, y, z]) {
    translate([proc_tol + ( tf_mag_h / 2.0 ), 
               0, 
               -proc_tol/2.0 - tf_mag_d/2.0]) {
      cube([tf_mag_h + 2.0 * proc_tol, 
            tf_mag_w + ( 2.0 * proc_tol ), 
            tf_mag_d + proc_tol], center=true);
    }
  } // end translate
} // end module tf_mag

// clip off the corner of the baseplate 
module tf_bp_trim() {
  translate([tf_bpc_x, tf_bpc_y, tf_bpc_z]) 
    rotate(a=-90, v=[0,1,0]) 
      rotate(a=-90, v=[0,0,1]) 
        half_cube(tf_bpc_d, tf_bpc_h, tf_bpc_w);
}

module tf_bp(x, y, z) {
  translate([x, y, z]) {
    difference() {
      // bottom plate
      union() {
        translate([tf_bp_x, tf_bp_y, tf_bp_z]) {
          cube([tf_bp_w, tf_bp_d, tf_bp_h+csg_utol]);
        }
        translate([tf_bp_x + ( tf_mag_h / 2.0 ), 
                   0,
                   ( min_wall / 2.0) - clip_mat_t]) {
          cube([tf_mag_h, 
                tf_mag_w + ( 2.0 * min_wall ), 
                min_wall + csg_tol], center=true);
        }

      } // end union
      // void for clip
      translate([tf_bp_x - csg_tol, ( -trp_blade_t / 2.0 ) - proc_tol, 
                 -clip_mat_t]) {
        cube([tf_mag_h * 1.1, trp_blade_t + ( 2.0 * proc_tol), 
              clip_mat_t + ( 2.0 * csg_tol ) + min_wall]);
      }
      // void for magnet
      tf_mag(tf_bp_x+min_wall-csg_tol, 0, -clip_mat_t+csg_utol);
      // void for magnet, extended out bottom of base
      tf_mag(tf_bp_x+min_wall-csg_tol, 0, -clip_mat_t-csg_utol);

      // trim off unnecessary corners
      tf_bp_trim();
      mirror([0,1,0]) {
        tf_bp_trim();
      }
    } // end difference
  }
}

// side support gusset of thumb frame
module tf_ssg() {
  translate([tf_ss_x, tf_ss_y-csg_tol, tf_ss_z]) {
    rotate(a=90, v=[0,0,1]) {
      half_cube(tf_ss_w, tf_ss_t, tf_ss_h);
    } // end rotate
  } // end translate
}

module tf_screws() {
  tf_attachment_screw(tf_sp1_x, tf_sp1_y, tf_sp1_z);
  tf_attachment_screw(tf_sp2_x, tf_sp2_y, tf_sp2_z);
  tf_attachment_screw(tf_sp3_x, tf_sp3_y, tf_sp3_z);
}

module tf(x, y, z) {
  translate([x, y, z]) {
    union() {
      tf_irled_holder(tf_irle_x, tf_irle_y, tf_irle_z);
      tf_uw();
      tf_lw();
      tf_ssg();
      tf_catch();
      mirror([0,1,0]) {
        tf_irled_holder(tf_irle_x, tf_irle_y, tf_irle_z);
        tf_uw();
        tf_lw();
        tf_ssg();
        tf_catch();
      } // end mirror
      tf_backstop();

      difference() {
        union() {
          tf_bp(0, 0, 0);
          tf_llw();
          mirror([0,1,0]) {
            tf_llw();
          }
        }

        eye_centered_m_irled(tf_irle_x, tf_irle_y, tf_irle_z, -tf_irle_scz);
        mirror([0, 1, 0]) {
          eye_centered_m_irled(tf_irle_x, tf_irle_y, tf_irle_z, -tf_irle_scz);
        }
        // subtract out holes for screws
        tf_screws();
      }

    } // end union
  } // end translate
} // end module tf

