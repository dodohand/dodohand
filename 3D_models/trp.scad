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
        //polyhedron(trp_blade_pointarr, trp_blade_facetarr);
        // the spline part of the top of the blade
        translate([trp_spline_x, trp_spline_y, trp_spline_z]) {
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
      translate([trp_irleh_x, trp_irleh_y, trp_irleh_z]) {
        cube([trp_irleh_w, trp_irleh_h, trp_irleh_d], center=true);
      } // end translate for trp_irleh
    } // end difference
  } // end translate
} // end module trp