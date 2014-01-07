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

// this file is to show the components, separated for easy viewing.

use <lever.scad>;
use <carrier.scad>;
use <LiteOn_P_100_E302.scad>;
use <5key_assy.scad>;

include <dimensions.scad>;


Nom_LiteOn_P_100_E302(0, 10, 0);
Nom_Everlight_PT908_7B_F(0, 15, 0);
Nom_LiteOn_P_100_E302(0, 20, 0);
Nom_Everlight_PT908_7B_F(0, 25, 0);
Nom_LiteOn_P_100_E302(0, 30, 0);
Nom_Everlight_PT908_7B_F(0, 35, 0);
Nom_LiteOn_P_100_E302(0, 40, 0);
Nom_Everlight_PT908_7B_F(0, 45, 0);
Nom_LiteOn_P_100_E302(0, 50, 0);
Nom_Everlight_PT908_7B_F(0, 55, 0);

smag(0, 60, 0);
smag(0, 65, 0);
smag(0, 70, 0);
smag(0, 75, 0);
magnet(0, 80, 0);

clip(-5, 0, 0);
clip(-10, 0, 0);
clip(-15, 0, 0);
clip(-20, 0, 0);
clip2(-30, 0, 0);

small_key(0, 0, 0, 1);
small_key(15, 0, 0, show_mag);
small_key(30, 0, 0, show_mag);
big_key(45, 0, 0, show_mag);
cbutton(60, 0, 0);
lowlev(80, 0, 0, show_mag);

//              x, y, z,sk,sc,sm,sh,pr,ck,sl
carrier_group(100, 0, 0, 0, 1, 0, 1, 0, 2, 0);

chock(120, 0, 0, 1);
chock(135, 0, 0, 1);
chock(150, 0, 0, 1);
chock(165, 0, 0, 1);

echo("carrier oaw:", 2*sw_d - 2*min_wall + floor_w);
echo("ctc distance IRtx2rx:", floor_w - sw_w);
echo("hole pattern:");
echo("h01", h01_x, h01_y);
echo("h02", h02_x, h02_y);
echo("h03", h03_x, h03_y);
echo("h04", h04_x, h04_y);
echo("h05", h05_x, h05_y);
echo("h06", h06_x, h06_y);
echo("h07", h07_x, h07_y);
echo("h08", h08_x, h08_y);
echo("h09", h09_x, h09_y);
echo("h0A", h0A_x, h0A_y);
echo("h0B", h0B_x, h0B_y);
echo("h0C", h0C_x, h0C_y);
echo("h0D", h0D_x, h0D_y);
echo("h0E", h0E_x, h0E_y);
echo("h0F", h0F_x, h0F_y);
echo("h0G", h0G_x, h0G_y);
echo("h0H", h0H_x, h0H_y);
echo("h0I", h0I_x, h0I_y);
echo("h0J", h0J_x, h0J_y);
echo("h0K", h0K_x, h0K_y);

echo("oaw: ", carrier_oaw);
clip_len = clip_A + clip_B + clip_C + clip_D + clip_E;
echo("clip_len (mm, in): ", clip_len, clip_len / 25.4);
echo("clip_w: ", clip_w, clip_w/25.4);

lclip_len = clip2_A + 2*clip2_B + 2*clip2_C;
echo("clip2_len: ", lclip_len, lclip_len/25.4);
echo("clip2_A: ", clip2_A);
echo("clip2_B: ", clip2_B, clip2_B/25.4);
echo("clip2_C: ", clip2_C);
echo("clip_A: ", clip_A);
echo("clip_B: ", clip_B);
echo("clip_C: ", clip_C);
echo("clip_D: ", clip_D);
echo("clip_E: ", clip_E);
