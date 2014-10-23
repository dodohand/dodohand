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

use <tdds.scad>;
use <util.scad>;
use <tc.scad>;

include <dimensions.scad>;

// print out the parameters of hole locations for one thumb switch:
echo("tf_sp1_x: ", tf_sp1_x);
echo("tf_sp1_y: ", tf_sp1_y);
echo("tf_sp2_x: ", tf_sp2_x);
echo("tf_sp2_y: ", tf_sp2_y);
echo("tf_sp3_x: ", tf_sp3_x);
echo("tf_sp3_y: ", tf_sp3_y);
echo("tf_bp_x: ", tf_bp_x);

echo("trp_angleside_b: ", trp_angleside_b);
echo("trp_angleside_m: ", trp_angleside_m);
echo("trp_angleface_angle: ", trp_angleface_angle);
echo("clip_mat_t: ", clip_mat_t);
echo("tf_irle_scz: ", tf_irle_scz);
echo("tf_bp_w: ", tf_bp_w);
echo("tf_bp_d: ", tf_bp_d);
echo("trp_max_trv: ", trp_max_trv);
echo("trp_irler_a: ", trp_irler_a);



tdds_centered(0, 0, tdds_rot_h, 0, 0, 0, 0);
// x, y, z, a, show_cap, show_trp, show_clip
pots(9.5, 10, 0, 0, 0, 0, 0);
dots(8, -16, 0, -14, 0, 0, 0);
dits(-10, -14, 0, 200, 0, 0, 0);
pits(-20, 6, 0, 190, 0, 0, 0);


