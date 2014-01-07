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

// this file is to show the left guard component

use <guards.scad>;

include <dimensions.scad>;

//left_guard(0, 0, 0);

//import("../documentation/left_hand_key_guard_footprint.dxf");


// This block shows the key-stop / guard along with bounding boxes for the
// PCB and for 3D printing
rotate(a=-14.17, v=[0,0,1]) {
  left_guard(0, 0, 0);

  translate([lh_p_x - ks_out_r, lh_p_y-ks_fla_r, -2*ks_wall_t])
   color([0.65, 0.85, 0.65, 0.25])
    cube([lh_i_x+ks_out_r-lh_p_x+ks_out_r, 
          lh_m_y +2*ks_fla_r - lh_p_y, 
          ks_wall_t]);

}
translate([lh_p_x - ks_out_r - 5, -ks_fla_r, -ks_wall_t])
 color([0.65, 0.65, 0.85, 0.25])
  cube([lh_i_x+ks_fla_r-lh_p_x+ks_fla_r, 2*ks_fla_r + lh_m_y+7, ks_wall_t]);



echo("lh_i_sty: ", lh_i_sty);

echo("ks_m3ms_i_t_x: ", ks_m3ms_i_t_x);
echo("ks_m3ms_i_t_y: ", ks_m3ms_i_t_y);
echo("ks_m3ms_i_b_x: ", ks_m3ms_i_b_x);
echo("ks_m3ms_i_b_y: ", ks_m3ms_i_b_y);
echo("ks_m3ms_m_t_x: ", ks_m3ms_m_t_x);
echo("ks_m3ms_m_t_y: ", ks_m3ms_m_t_y);
echo("ks_m3ms_m_b_x: ", ks_m3ms_m_b_x);
echo("ks_m3ms_m_b_y: ", ks_m3ms_m_b_y);
echo("ks_m3ms_r_t_x: ", ks_m3ms_r_t_x);
echo("ks_m3ms_r_t_y: ", ks_m3ms_r_t_y);
echo("ks_m3ms_r_b_x: ", ks_m3ms_r_b_x);
echo("ks_m3ms_r_b_y: ", ks_m3ms_r_b_y);
echo("ks_m3ms_p_t_x: ", ks_m3ms_p_t_x);
echo("ks_m3ms_p_t_y: ", ks_m3ms_p_t_y);
echo("ks_m3ms_p_b_x: ", ks_m3ms_p_b_x);
echo("ks_m3ms_p_b_y: ", ks_m3ms_p_b_y);

echo("lh_i_x: ", lh_i_x);
echo("lh_i_y: ", lh_i_y);
echo("lh_m_x: ", lh_m_x);
echo("lh_m_y: ", lh_m_y);
echo("lh_r_x: ", lh_r_x);
echo("lh_r_y: ", lh_r_y);
echo("lh_p_x: ", lh_p_x);
echo("lh_p_y: ", lh_p_y);

echo("ks_out_r: ", ks_out_r);
echo("ks_fla_r: ", ks_fla_r);
