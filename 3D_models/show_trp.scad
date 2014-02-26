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

use <trp.scad>;
use <carrier.scad>;
use <LiteOn_P_100_E302.scad>;
use <tf.scad>;

include <dimensions.scad>;

rotate(a=90, v=[1,0,0]) trp(0, 0, 0);

echo("trp_tstop_x: ", trp_tstop_x);
echo("trp_tstop_y: ", trp_tstop_y);
echo("trp_tstop_z: ", trp_tstop_z);
echo("trp_tstop_r: ", trp_tstop_r);
echo("trp_tstop_h: ", trp_tstop_h);
echo("trp_tstop_x_int: ", trp_tstop_x_int);
echo("trp_angleside_b: ", trp_angleside_b);
echo("trp_angleside_m: ", trp_angleside_m);
echo("trp_angleface_angle: ", trp_angleface_angle);
echo("clip_mat_t: ", clip_mat_t);
echo("tf_irle_scz: ", tf_irle_scz);

rotate(a=90, v=[1,0,0]) translate([clip_mat_t, -clip_mat_t, -clip_w/2]) rotate(a=-90, v=[0,1,0]) clip(0, 0, 0);

//translate([-irle_m_x + tf_irle_x, -irle_m_y-2, -irle_m_z+tf_irle_z]) rotate( a=-90, v=[0,0,1]) Max_LiteOn_P_100_E302(0, 0, 0, 0);

//#eye_centered_m_irled(0, 0, 0, -5);

tf(0, 0, 0);
color("silver") translate([tf_bp_x, -mag_w/2, -mag_d-clip_mat_t]) cube([mag_h, mag_w, mag_d]);

