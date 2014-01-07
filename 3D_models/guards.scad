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

module ks_point_remover(x1, y1, x2, y2) {
  translate([(x2-x1)/2+x1, (y2-y1)/2+y1, -csg_tol/2])
    cylinder(h=ks_pink_h+csg_tol, 
     r=( sqrt(ks_inn_r*ks_inn_r - (sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))/2-min_wall/2)*(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))/2-min_wall/2)) ), 
     $fn=gfn);

}

module ks_m3_mounting_hole(x, y, z) {
  translate([x, y, z-csg_tol])
    cylinder(h=ks_wall_t+2*csg_tol, r=(ks_m3ms_d/2.0), $fn=gfn); 
}

module ks_m3_mounting_tab(x, y, z) {
  translate([x, y, z])
    cylinder(h=ks_wall_t, r=(ks_m3mt_d/2.0), $fn=gfn); 
}

module left_guard(x, y, z) {
  translate([x, y, z]) {
    difference() {
      union() {
        translate([lh_i_x, lh_i_y, 0]) 
          cylinder(h=ks_wall_t, r=ks_fla_r, $fn=gfn);
        translate([lh_m_x, lh_m_y, 0]) 
          cylinder(h=ks_wall_t, r=ks_fla_r, $fn=gfn);
        translate([lh_r_x, lh_r_y, 0]) 
          cylinder(h=ks_wall_t, r=ks_fla_r, $fn=gfn);
        translate([lh_p_x, lh_p_y, 0]) 
          cylinder(h=ks_wall_t, r=ks_fla_r, $fn=gfn);

        translate([lh_i_x, lh_i_y, 0]) 
          cylinder(h=ks_norm_h, r=ks_out_r, $fn=gfn);
        translate([lh_m_x, lh_m_y, 0]) 
          cylinder(h=ks_norm_h, r=ks_out_r, $fn=gfn);
        translate([lh_r_x, lh_r_y, 0]) 
          cylinder(h=ks_norm_h, r=ks_out_r, $fn=gfn);
        translate([lh_p_x, lh_p_y, 0]) 
          cylinder(h=ks_pink_h, r=ks_out_r, $fn=gfn);

        // pads for mounting m3 screws
        ks_m3_mounting_tab(ks_m3ms_i_t_x, ks_m3ms_i_t_y, 0);
        ks_m3_mounting_tab(ks_m3ms_i_b_x, ks_m3ms_i_b_y, 0);
        ks_m3_mounting_tab(ks_m3ms_m_t_x, ks_m3ms_m_t_y, 0);
        ks_m3_mounting_tab(ks_m3ms_m_b_x, ks_m3ms_m_b_y, 0);
        ks_m3_mounting_tab(ks_m3ms_r_t_x, ks_m3ms_r_t_y, 0);
        ks_m3_mounting_tab(ks_m3ms_r_b_x, ks_m3ms_r_b_y, 0);
        ks_m3_mounting_tab(ks_m3ms_p_t_x, ks_m3ms_p_t_y, 0);
        ks_m3_mounting_tab(ks_m3ms_p_b_x, ks_m3ms_p_b_y, 0);

      } // end union

      translate([lh_i_x, lh_i_y, -csg_tol/2]) 
        cylinder(h=ks_pink_h+csg_tol, r=ks_inn_r, $fn=gfn);
      translate([lh_m_x, lh_m_y, -csg_tol/2]) 
        cylinder(h=ks_pink_h+csg_tol, r=ks_inn_r, $fn=gfn);
      translate([lh_r_x, lh_r_y, -csg_tol/2]) 
        cylinder(h=ks_pink_h+csg_tol, r=ks_inn_r, $fn=gfn);
      translate([lh_p_x, lh_p_y, -csg_tol/2]) 
        cylinder(h=ks_pink_h+csg_tol, r=ks_inn_r, $fn=gfn);

// dont want infinitely small points.  Minkowski seems to die trying this...
// try to just subtract off the points.

      ks_point_remover(lh_i_x, lh_i_y, lh_m_x, lh_m_y);
      ks_point_remover(lh_m_x, lh_m_y, lh_r_x, lh_r_y);
      ks_point_remover(lh_r_x, lh_r_y, lh_p_x, lh_p_y);

      // knock off the outer edges to reduce PCB size
      translate([lh_i_x + ks_out_r, -ks_fla_r, -csg_tol])
        cube([10, 2*ks_fla_r, 2*ks_wall_t]);

      translate([lh_p_x - ks_out_r-10, lh_p_y-ks_fla_r, -csg_tol])
        cube([10, 2*ks_fla_r, 2*ks_wall_t]);

      // holes for M3 mounting screws
      ks_m3_mounting_hole(ks_m3ms_i_t_x, ks_m3ms_i_t_y, 0);
      ks_m3_mounting_hole(ks_m3ms_i_b_x, ks_m3ms_i_b_y, 0);
      ks_m3_mounting_hole(ks_m3ms_m_t_x, ks_m3ms_m_t_y, 0);
      ks_m3_mounting_hole(ks_m3ms_m_b_x, ks_m3ms_m_b_y, 0);
      ks_m3_mounting_hole(ks_m3ms_r_t_x, ks_m3ms_r_t_y, 0);
      ks_m3_mounting_hole(ks_m3ms_r_b_x, ks_m3ms_r_b_y, 0);
      ks_m3_mounting_hole(ks_m3ms_p_t_x, ks_m3ms_p_t_y, 0);
      ks_m3_mounting_hole(ks_m3ms_p_b_x, ks_m3ms_p_b_y, 0);

    } // end difference
  } // end translate
} // end module left_guard.scad
