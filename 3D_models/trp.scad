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

use <carrier.scad>;
use <util.scad>;

include <dimensions.scad>;

module trp_blade(x, y, z) {
  translate([x, y, z]) {
    polyhedron(trp_blade_pointarr, trp_blade_facetarr);
  }
}

module trp(x, y, z) {
  translate([x, y, z]) {
    difference () {
      union() {
        // the main part of the blade of the trp
        trp_blade(0, 0, trp_blade_z);
        // the spline part of the top of the blade
        translate([trp_spline_x, trp_spline_y-csg_utol, trp_spline_z]) {
          cube([trp_spline_w, trp_spline_h, trp_spline_t]);
        } // end spline translate
        // now add the travel stop
        translate([trp_tstop_x, trp_tstop_y, trp_tstop_z]) {
          cylinder(r=trp_tstop_r, h=trp_tstop_h, center=true, $fn=gfn);
        } // end tstop translate
        // add second tstop
        translate([trp_ts2_x, trp_ts2_y, trp_ts2_z]) {
          cylinder(r=trp_ts2_r, h=trp_ts2_h, center=true, $fn=gfn);
        } // end ts2 translate
        // now add the pivot
        translate([trp_pivot_x, trp_pivot_y, trp_pivot_z]) {
          cylinder(r=trp_pivot_r, h=trp_pivot_h, center=true, $fn=gfn);
        } // end translate of pivot
        // now add the shoulder to the pivot
        // begin by getting the intersection of the positioned pivot
        // and the blade. Then stretch and center that shape.
        translate([0, 0, 0]) {
          scale([1.0, 1.0, trp_ps_scale]) {
            intersection() {
              trp_blade(0, 0, trp_blade_z);
              translate([trp_ps_x, trp_ps_y, trp_ps_z]) {
                cylinder(r=trp_ps_r, h=trp_ps_h, center=true, $fn=gfn);
              } // end translate
            } // end intersection
          } // end scale
        } // end translate to center extrusion
        // now add in the support mass for the clip lock
        translate([trp_clw_x, trp_clw_y, trp_clw_z]) {
           cube([trp_clw_w, trp_clw_h, trp_clw_d], center=true);
        } // end translate clip lock support mass
      } // end union

      // now subtract out the clip lock void
      translate([trp_clv_x, trp_clv_y, trp_clv_z]) {
        cube([trp_clv_w + csg_tol, trp_clv_h, trp_clv_d], center=true);
      } // end translate clip lock support mass
      // now subtract out the clip lock cleanout void
      translate([trp_clcv_x, trp_clcv_y, trp_clcv_z]) {
        cube([trp_clcv_w, trp_clcv_h, trp_clcv_d], center=true);
      } // end translate clcv

      // now subtract out the hole through which the beam shines
      translate([trp_irleh_x, trp_irleh_y, 0.0]) {
        cylinder( r=trp_irleh_r, h=trp_blade_t+csg_tol, center=true, $fn=gfn);
      }

      // now round off the area where the clip will attach so that
      // the profile matches the radius of the clip.

      difference() {
        union() {
          translate([0, clip_inn_r, 0]) 
            scale([1, 1, (trp_blade_t+csg_tol)/clip_w]) 
              rotate(a=-90,v=[1,0,0]) 
                c_r_bend_4(0, -clip_w/2, 0);
          cube([clip_mat_t, 2.0 * clip_inn_r, trp_blade_t+csg_tol], center=true);       } // end union

        // now subtract out the support mass for the clip lock
        translate([trp_clw_x, trp_clw_y, trp_clw_z]) {
           cube([trp_clw_w, trp_clw_h, trp_clw_d], center=true);
        } // end translate clip lock support mass
      } // end difference for corner removal

      // subtract out the upper part of the bend for the clip
      scale([1, 1, ( clip_m_w / clip_w ) - csg_utol]) {
        translate([clip_mat_t, -clip_mat_t, -clip_w/2]) {
          rotate(a=-90, v=[0,1,0]) clip(0, 0, 0);
        } // end tranlate for whole clip
      } // end scale for clip

      // cleanup of remainder that clip didn't remove
      translate([-csg_tol/2+clip_mat_t/2, clip_bend_h, 0]) 
        cube([clip_mat_t + csg_tol, 2.0 * clip_bend_h, clip_m_w], center=true);

      // subtract out the void of the keycap lock on the spline
      translate([trp_sv_x, trp_sv_y, trp_sv_z]) 
        cube([trp_sv_w, trp_sv_d, trp_sv_h]);
      
    } // end difference
  } // end translate
} // end module trp


module keycapbase(x, y, z)
{
  translate([x, y, z]) {
    union() {
      difference() {
        // the keycapbase
        translate([kcb_x, kcb_y, kcb_z]) 
          cube([kcb_w, kcb_d, kcb_h], center=true  );
        
        // the central void in the keycap base
        translate([kcb_v_x, kcb_v_y, kcb_v_z]) 
          cube([kcb_v_w, kcb_v_d, kcb_v_h], center=true);
        // the hole for the locking clip
        translate([kcb_lch_x, kcb_lch_y, kcb_lch_z]) 
          cube([kcb_lch_w, kcb_lch_d, kcb_lch_h], center=true);
      } // end difference
      // the clip arm
      translate([kcb_lc_x, kcb_lc_y, kcb_lc_z]) 
        cube([kcb_lc_w, kcb_lc_d, kcb_lc_h], center=true);
      // the locking bump
      translate([kcb_lb_x, kcb_lb_y, kcb_lb_z]) 
       cube([kcb_lb_w, kcb_lb_d, kcb_lb_h], center=true);
      // the ramp up to the locking bump
      translate([kcb_lbr_x, kcb_lbr_y, kcb_lbr_z])
        rotate(a=180, v=[0,1,0])
        translate([kcb_lbr_w / 2.0, 0, 0])
        rotate(a=90, v=[0,0,1])
        half_cube(kcb_lbr_d, kcb_lbr_w, kcb_lbr_h);
    } // end union
  } // end translate
} // end module keycapbase
