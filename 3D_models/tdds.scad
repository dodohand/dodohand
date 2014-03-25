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
use <LiteOn_P_100_E302.scad>;

include <dimensions.scad>;

module tdds_bar(x, y, z, sc) {
// sc == show clip
  translate([x, y, z]) {
    difference() {
      pos_cube(tdds_bar_x, tdds_bar_y, tdds_bar_z, 
               tdds_bar_w, tdds_bar_l, tdds_bar_h);
      // now start removing the parts that shouldn't be there

      pos_cube(tdds_cbv_x, tdds_cbv_y, tdds_cbv_z,
               tdds_cbv_w, tdds_cbv_l, tdds_cbv_h);
      
      pos_cube(tdds_sub_x, tdds_sub_y, tdds_sub_z,
               tdds_sub_w, tdds_sub_l, tdds_sub_h);

      pos_cube(tdds_sub2_x, tdds_sub2_y, tdds_sub2_z,
               tdds_sub_w, tdds_sub_l, tdds_sub_h);
    } // end difference

    if(1 == sc) {
      translate([tdds_clip_x, tdds_clip_y, tdds_clip_z])
      translate([0, 0, clip_mat_t]) 
        rotate(a=180, v=[0,0,1]) rotate(a=-90, v=[1,0,0]) 
          clip(0, 0, 0);

      translate([tdds_clip_x - clip_w, tdds_bar_l - tdds_clip_y, tdds_clip_z])
      translate([0, 0, clip_mat_t]) 
        rotate(a=-90, v=[1,0,0]) 
          clip(0, 0, 0);
    }

  } // end translate
}

module tdds_box(x, y, z) {
  translate(x, y, z) {
    difference() {
      union() {
        difference() {
          pos_cube(tdds_box_x, tdds_box_y, tdds_box_z,
                   tdds_box_w, tdds_box_l, tdds_box_h);

          pos_cube(tdds_bh_x, tdds_bh_y, tdds_bh_z,
                   tdds_bh_w, tdds_bh_l, tdds_bh_h);

          Max_LiteOn_P_100_E302(-irle_m_r - proc_tol, 0, tdds_irl_z, -10);

          translate([tdds_bar_w + proc_tol + irle_m_r, irlb_m_w, tdds_irl_z]) 
            rotate(a=180, v=[0,0,1]) 
              Max_LiteOn_P_100_E302(0, 0, 0, -10);

        } // end diff

        // add in the fins which contain the IR beam passage
        pos_cube(tdds_bar_w/2.0 - min_wall/2.0, -csg_tol-proc_tol, tdds_box_z,
                 min_wall, irlb_w - proc_tol, tdds_box_h);

        // add in the fins which contain the IR beam passage
        pos_cube(tdds_bar_w/2.0 - min_wall/2.0, tdds_bh_l+csg_tol-irlb_w, tdds_box_z,
                 min_wall, irlb_w - proc_tol, tdds_box_h);

      } // end union

      translate([( tdds_box_w / 2.0 ) -tdds_mat_t-proc_tol, 
                 irle_m_x, irle_m_z + tdds_irl_z]) 
        rotate(a=-90,v=[0,1,0]) 
          cylinder(r=irle_m_r, h=tdds_box_w + ( 2.0 * csg_tol ), 
                   center=true, $fn=gfn);

      translate([( tdds_box_w / 2.0 ) -tdds_mat_t-proc_tol, 
                 tdds_bar_l - irle_m_x, irle_m_z + tdds_irl_z]) 
        rotate(a=-90,v=[0,1,0]) 
          cylinder(r=irle_m_r, h=tdds_box_w + ( 2.0 * csg_tol ), 
                   center=true, $fn=gfn);

    } // end difference

  } // end translate
}

module tdds(x, y, z, sc) {
 
  difference() {

    union() {
      //rotate(a=-tdds_rot_a, v=[1,0,0]) tdds_bar(x, y, z, sc);
      translate([0, 1.5 * proc_tol, -tdds_rot_h]) rotate(a=tdds_rot_a, v=[1,0,0]) tdds_bar(x, y, z, sc);
      tdds_box(x, y, z);
    } // end union

  //pos_cube(-10, 15, -5, 20, 20, 20);

  } // end difference

  Max_LiteOn_P_100_E302(-5, 0, 0, -10);

}

