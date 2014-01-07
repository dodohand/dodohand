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

// this file is to show the 5key assemblies lined up in 
// their installed positions for the left hand.

use <lever.scad>;
use <carrier.scad>;
use <LiteOn_P_100_E302.scad>;
use <5key_assy.scad>;

include <dimensions.scad>;
// 4.545        = x
// 2.315 inches = y position of index finger

// 3.450        = x
// 2.045 inches = y position of middle finger

// 2.407
// 2.549 inches = y position of ring finger

// 1.535        = x
// 3.350 inches = y position of pinkie

//index: 0,0
//middle: -1.095, 0.270
//ring: -2.138, -0.234
//pinkie: -3.010, -1.035

lf_show_keys = 1;

module ks_point_remover(x1, y1, x2, y2) {
  translate([(x2-x1)/2+x1, (y2-y1)/2+y1, -csg_tol/2])
    cylinder(h=ks_pink_h+csg_tol, 
     r=( sqrt(ks_inn_r*ks_inn_r - (sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))/2-min_wall/2)*(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))/2-min_wall/2)) ), 
     $fn=gfn);

}

// final carrier group. centers carrier group, then rotates, then translates.

module fcg(ang, x, y, z, pr) {
  translate([x,y,z]) {
    rotate(a=ang, v=[0,0,1]) {
      carrier_group(-floor_w/2, -sw_d+min_wall-floor_w/2, min_wall, 
                  lf_show_keys, 0, 0, 0, pr, 2, 1);
    }
  }
}

fcg(lh_i_a, lh_i_x, lh_i_y, 0, 0.0);
fcg(lh_m_a, lh_m_x, lh_m_y, 0, 0.0);
fcg(lh_r_a, lh_r_x, lh_r_y, 0, 0.0);
fcg(lh_p_a, lh_p_x, lh_p_y, pinkie_riser, pinkie_riser);

h1f_x = h01_x - sw_d + min_wall - floor_w/2;
h1f_y = h01_y - sw_d + min_wall - floor_w/2;
h2f_x = h02_x - sw_d + min_wall - floor_w/2;
h2f_y = h02_y - sw_d + min_wall - floor_w/2;
h3f_x = h03_x - sw_d + min_wall - floor_w/2;
h3f_y = h03_y - sw_d + min_wall - floor_w/2;
h4f_x = h04_x - sw_d + min_wall - floor_w/2;
h4f_y = h04_y - sw_d + min_wall - floor_w/2;
h5f_x = h05_x - sw_d + min_wall - floor_w/2;
h5f_y = h05_y - sw_d + min_wall - floor_w/2;
h6f_x = h06_x - sw_d + min_wall - floor_w/2;
h6f_y = h06_y - sw_d + min_wall - floor_w/2;
h7f_x = h07_x - sw_d + min_wall - floor_w/2;
h7f_y = h07_y - sw_d + min_wall - floor_w/2;
h8f_x = h08_x - sw_d + min_wall - floor_w/2;
h8f_y = h08_y - sw_d + min_wall - floor_w/2;
h9f_x = h09_x - sw_d + min_wall - floor_w/2;
h9f_y = h09_y - sw_d + min_wall - floor_w/2;
hAf_x = h0A_x - sw_d + min_wall - floor_w/2;
hAf_y = h0A_y - sw_d + min_wall - floor_w/2;
hBf_x = h0B_x - sw_d + min_wall - floor_w/2;
hBf_y = h0B_y - sw_d + min_wall - floor_w/2;
hCf_x = h0C_x - sw_d + min_wall - floor_w/2;
hCf_y = h0C_y - sw_d + min_wall - floor_w/2;
hDf_x = h0D_x - sw_d + min_wall - floor_w/2;
hDf_y = h0D_y - sw_d + min_wall - floor_w/2;
hEf_x = h0E_x - sw_d + min_wall - floor_w/2;
hEf_y = h0E_y - sw_d + min_wall - floor_w/2;
hFf_x = h0F_x - sw_d + min_wall - floor_w/2;
hFf_y = h0F_y - sw_d + min_wall - floor_w/2;
hGf_x = h0G_x - sw_d + min_wall - floor_w/2;
hGf_y = h0G_y - sw_d + min_wall - floor_w/2;
hHf_x = h0H_x - sw_d + min_wall - floor_w/2;
hHf_y = h0H_y - sw_d + min_wall - floor_w/2;
hIf_x = h0I_x - sw_d + min_wall - floor_w/2;
hIf_y = h0I_y - sw_d + min_wall - floor_w/2;
hJf_x = h0J_x - sw_d + min_wall - floor_w/2;
hJf_y = h0J_y - sw_d + min_wall - floor_w/2;
hKf_x = h0K_x - sw_d + min_wall - floor_w/2;
hKf_y = h0K_y - sw_d + min_wall - floor_w/2;

h1r = sqrt(h1f_x*h1f_x + h1f_y*h1f_y);
h2r = sqrt(h2f_x*h2f_x + h2f_y*h2f_y);
h3r = sqrt(h3f_x*h3f_x + h3f_y*h3f_y);
h4r = sqrt(h4f_x*h4f_x + h4f_y*h4f_y);
h5r = sqrt(h5f_x*h5f_x + h5f_y*h5f_y);
h6r = sqrt(h6f_x*h6f_x + h6f_y*h6f_y);
h7r = sqrt(h7f_x*h7f_x + h7f_y*h7f_y);
h8r = sqrt(h8f_x*h8f_x + h8f_y*h8f_y);
h9r = sqrt(h9f_x*h9f_x + h9f_y*h9f_y);
hAr = sqrt(hAf_x*hAf_x + hAf_y*hAf_y);
hBr = sqrt(hBf_x*hBf_x + hBf_y*hBf_y);
hCr = sqrt(hCf_x*hCf_x + hCf_y*hCf_y);
hDr = sqrt(hDf_x*hDf_x + hDf_y*hDf_y);
hEr = sqrt(hEf_x*hEf_x + hEf_y*hEf_y);
hFr = sqrt(hFf_x*hFf_x + hFf_y*hFf_y);
hGr = sqrt(hGf_x*hGf_x + hGf_y*hGf_y);
hHr = sqrt(hHf_x*hHf_x + hHf_y*hHf_y);
hIr = sqrt(hIf_x*hIf_x + hIf_y*hIf_y);
hJr = sqrt(hJf_x*hJf_x + hJf_y*hJf_y);
hKr = sqrt(hKf_x*hKf_x + hKf_y*hKf_y);

h1ia = atan(h1f_y/h1f_x) + ((h1f_x < 0) ? 180 : 0);
h2ia = atan(h2f_y/h2f_x) + ((h2f_x < 0) ? 180 : 0);
h3ia = atan(h3f_y/h3f_x) + ((h3f_x < 0) ? 180 : 0);
h4ia = atan(h4f_y/h4f_x) + ((h4f_x < 0) ? 180 : 0);
h5ia = atan(h5f_y/h5f_x) + ((h5f_x < 0) ? 180 : 0);
h6ia = atan(h6f_y/h6f_x) + ((h6f_x < 0) ? 180 : 0);
h7ia = atan(h7f_y/h7f_x) + ((h7f_x < 0) ? 180 : 0);
h8ia = atan(h8f_y/h8f_x) + ((h8f_x < 0) ? 180 : 0);
h9ia = atan(h9f_y/h9f_x) + ((h9f_x < 0) ? 180 : 0);
hAia = atan(hAf_y/hAf_x) + ((hAf_x < 0) ? 180 : 0);
hBia = atan(hBf_y/hBf_x) + ((hBf_x < 0) ? 180 : 0);
hCia = atan(hCf_y/hCf_x) + ((hCf_x < 0) ? 180 : 0);
hDia = atan(hDf_y/hDf_x) + ((hDf_x < 0) ? 180 : 0);
hEia = atan(hEf_y/hEf_x) + ((hEf_x < 0) ? 180 : 0);
hFia = atan(hFf_y/hFf_x) + ((hFf_x < 0) ? 180 : 0);
hGia = atan(hGf_y/hGf_x) + ((hGf_x < 0) ? 180 : 0);
hHia = atan(hHf_y/hHf_x) + ((hHf_x < 0) ? 180 : 0);
hIia = atan(hIf_y/hIf_x) + ((hIf_x < 0) ? 180 : 0);
hJia = atan(hJf_y/hJf_x) + ((hJf_x < 0) ? 180 : 0);
hKia = atan(hKf_y/hKf_x) + ((hKf_x < 0) ? 180 : 0);

// calculate index finger opto-lead positions
echo("index finger opto lead position array");
echo("[", h1r*cos(lh_i_a+h1ia) + lh_i_x,  h1r*sin(lh_i_a+h1ia) + lh_i_y); 
echo("", h2r*cos(lh_i_a+h2ia) + lh_i_x,  h2r*sin(lh_i_a+h2ia) + lh_i_y); 
echo("", h3r*cos(lh_i_a+h3ia) + lh_i_x,  h3r*sin(lh_i_a+h3ia) + lh_i_y); 
echo("", h4r*cos(lh_i_a+h4ia) + lh_i_x,  h4r*sin(lh_i_a+h4ia) + lh_i_y); 
echo("", h5r*cos(lh_i_a+h5ia) + lh_i_x,  h5r*sin(lh_i_a+h5ia) + lh_i_y); 
echo("", h6r*cos(lh_i_a+h6ia) + lh_i_x,  h6r*sin(lh_i_a+h6ia) + lh_i_y); 
echo("", h7r*cos(lh_i_a+h7ia) + lh_i_x,  h7r*sin(lh_i_a+h7ia) + lh_i_y); 
echo("", h8r*cos(lh_i_a+h8ia) + lh_i_x,  h8r*sin(lh_i_a+h8ia) + lh_i_y); 
echo("", h9r*cos(lh_i_a+h9ia) + lh_i_x,  h9r*sin(lh_i_a+h9ia) + lh_i_y); 
echo("", hAr*cos(lh_i_a+hAia) + lh_i_x,  hAr*sin(lh_i_a+hAia) + lh_i_y); 
echo("", hBr*cos(lh_i_a+hBia) + lh_i_x,  hBr*sin(lh_i_a+hBia) + lh_i_y); 
echo("", hCr*cos(lh_i_a+hCia) + lh_i_x,  hCr*sin(lh_i_a+hCia) + lh_i_y); 
echo("", hDr*cos(lh_i_a+hDia) + lh_i_x,  hDr*sin(lh_i_a+hDia) + lh_i_y); 
echo("", hEr*cos(lh_i_a+hEia) + lh_i_x,  hEr*sin(lh_i_a+hEia) + lh_i_y); 
echo("", hFr*cos(lh_i_a+hFia) + lh_i_x,  hFr*sin(lh_i_a+hFia) + lh_i_y); 
echo("", hGr*cos(lh_i_a+hGia) + lh_i_x,  hGr*sin(lh_i_a+hGia) + lh_i_y); 
echo("", hHr*cos(lh_i_a+hHia) + lh_i_x,  hHr*sin(lh_i_a+hHia) + lh_i_y); 
echo("", hIr*cos(lh_i_a+hIia) + lh_i_x,  hIr*sin(lh_i_a+hIia) + lh_i_y); 
echo("", hJr*cos(lh_i_a+hJia) + lh_i_x,  hJr*sin(lh_i_a+hJia) + lh_i_y); 
echo("", hKr*cos(lh_i_a+hKia) + lh_i_x,  hKr*sin(lh_i_a+hKia) + lh_i_y, "]");

echo("middle finger opto lead position array");
echo("[", h1r*cos(lh_m_a+h1ia) + lh_m_x,  h1r*sin(lh_m_a+h1ia) + lh_m_y); 
echo("", h2r*cos(lh_m_a+h2ia) + lh_m_x,  h2r*sin(lh_m_a+h2ia) + lh_m_y); 
echo("", h3r*cos(lh_m_a+h3ia) + lh_m_x,  h3r*sin(lh_m_a+h3ia) + lh_m_y); 
echo("", h4r*cos(lh_m_a+h4ia) + lh_m_x,  h4r*sin(lh_m_a+h4ia) + lh_m_y); 
echo("", h5r*cos(lh_m_a+h5ia) + lh_m_x,  h5r*sin(lh_m_a+h5ia) + lh_m_y); 
echo("", h6r*cos(lh_m_a+h6ia) + lh_m_x,  h6r*sin(lh_m_a+h6ia) + lh_m_y); 
echo("", h7r*cos(lh_m_a+h7ia) + lh_m_x,  h7r*sin(lh_m_a+h7ia) + lh_m_y); 
echo("", h8r*cos(lh_m_a+h8ia) + lh_m_x,  h8r*sin(lh_m_a+h8ia) + lh_m_y); 
echo("", h9r*cos(lh_m_a+h9ia) + lh_m_x,  h9r*sin(lh_m_a+h9ia) + lh_m_y); 
echo("", hAr*cos(lh_m_a+hAia) + lh_m_x,  hAr*sin(lh_m_a+hAia) + lh_m_y); 
echo("", hBr*cos(lh_m_a+hBia) + lh_m_x,  hBr*sin(lh_m_a+hBia) + lh_m_y); 
echo("", hCr*cos(lh_m_a+hCia) + lh_m_x,  hCr*sin(lh_m_a+hCia) + lh_m_y); 
echo("", hDr*cos(lh_m_a+hDia) + lh_m_x,  hDr*sin(lh_m_a+hDia) + lh_m_y); 
echo("", hEr*cos(lh_m_a+hEia) + lh_m_x,  hEr*sin(lh_m_a+hEia) + lh_m_y); 
echo("", hFr*cos(lh_m_a+hFia) + lh_m_x,  hFr*sin(lh_m_a+hFia) + lh_m_y); 
echo("", hGr*cos(lh_m_a+hGia) + lh_m_x,  hGr*sin(lh_m_a+hGia) + lh_m_y); 
echo("", hHr*cos(lh_m_a+hHia) + lh_m_x,  hHr*sin(lh_m_a+hHia) + lh_m_y); 
echo("", hIr*cos(lh_m_a+hIia) + lh_m_x,  hIr*sin(lh_m_a+hIia) + lh_m_y); 
echo("", hJr*cos(lh_m_a+hJia) + lh_m_x,  hJr*sin(lh_m_a+hJia) + lh_m_y); 
echo("", hKr*cos(lh_m_a+hKia) + lh_m_x,  hKr*sin(lh_m_a+hKia) + lh_m_y, "]");

echo("ring finger opto lead position array");
echo("[", h1r*cos(lh_r_a+h1ia) + lh_r_x,  h1r*sin(lh_r_a+h1ia) + lh_r_y); 
echo("", h2r*cos(lh_r_a+h2ia) + lh_r_x,  h2r*sin(lh_r_a+h2ia) + lh_r_y); 
echo("", h3r*cos(lh_r_a+h3ia) + lh_r_x,  h3r*sin(lh_r_a+h3ia) + lh_r_y); 
echo("", h4r*cos(lh_r_a+h4ia) + lh_r_x,  h4r*sin(lh_r_a+h4ia) + lh_r_y); 
echo("", h5r*cos(lh_r_a+h5ia) + lh_r_x,  h5r*sin(lh_r_a+h5ia) + lh_r_y); 
echo("", h6r*cos(lh_r_a+h6ia) + lh_r_x,  h6r*sin(lh_r_a+h6ia) + lh_r_y); 
echo("", h7r*cos(lh_r_a+h7ia) + lh_r_x,  h7r*sin(lh_r_a+h7ia) + lh_r_y); 
echo("", h8r*cos(lh_r_a+h8ia) + lh_r_x,  h8r*sin(lh_r_a+h8ia) + lh_r_y); 
echo("", h9r*cos(lh_r_a+h9ia) + lh_r_x,  h9r*sin(lh_r_a+h9ia) + lh_r_y); 
echo("", hAr*cos(lh_r_a+hAia) + lh_r_x,  hAr*sin(lh_r_a+hAia) + lh_r_y); 
echo("", hBr*cos(lh_r_a+hBia) + lh_r_x,  hBr*sin(lh_r_a+hBia) + lh_r_y); 
echo("", hCr*cos(lh_r_a+hCia) + lh_r_x,  hCr*sin(lh_r_a+hCia) + lh_r_y); 
echo("", hDr*cos(lh_r_a+hDia) + lh_r_x,  hDr*sin(lh_r_a+hDia) + lh_r_y); 
echo("", hEr*cos(lh_r_a+hEia) + lh_r_x,  hEr*sin(lh_r_a+hEia) + lh_r_y); 
echo("", hFr*cos(lh_r_a+hFia) + lh_r_x,  hFr*sin(lh_r_a+hFia) + lh_r_y); 
echo("", hGr*cos(lh_r_a+hGia) + lh_r_x,  hGr*sin(lh_r_a+hGia) + lh_r_y); 
echo("", hHr*cos(lh_r_a+hHia) + lh_r_x,  hHr*sin(lh_r_a+hHia) + lh_r_y); 
echo("", hIr*cos(lh_r_a+hIia) + lh_r_x,  hIr*sin(lh_r_a+hIia) + lh_r_y); 
echo("", hJr*cos(lh_r_a+hJia) + lh_r_x,  hJr*sin(lh_r_a+hJia) + lh_r_y); 
echo("", hKr*cos(lh_r_a+hKia) + lh_r_x,  hKr*sin(lh_r_a+hKia) + lh_r_y, "]");

echo("pinkie finger opto lead position array");
echo("[", h1r*cos(lh_p_a+h1ia) + lh_p_x,  h1r*sin(lh_p_a+h1ia) + lh_p_y); 
echo("", h2r*cos(lh_p_a+h2ia) + lh_p_x,  h2r*sin(lh_p_a+h2ia) + lh_p_y); 
echo("", h3r*cos(lh_p_a+h3ia) + lh_p_x,  h3r*sin(lh_p_a+h3ia) + lh_p_y); 
echo("", h4r*cos(lh_p_a+h4ia) + lh_p_x,  h4r*sin(lh_p_a+h4ia) + lh_p_y); 
echo("", h5r*cos(lh_p_a+h5ia) + lh_p_x,  h5r*sin(lh_p_a+h5ia) + lh_p_y); 
echo("", h6r*cos(lh_p_a+h6ia) + lh_p_x,  h6r*sin(lh_p_a+h6ia) + lh_p_y); 
echo("", h7r*cos(lh_p_a+h7ia) + lh_p_x,  h7r*sin(lh_p_a+h7ia) + lh_p_y); 
echo("", h8r*cos(lh_p_a+h8ia) + lh_p_x,  h8r*sin(lh_p_a+h8ia) + lh_p_y); 
echo("", h9r*cos(lh_p_a+h9ia) + lh_p_x,  h9r*sin(lh_p_a+h9ia) + lh_p_y); 
echo("", hAr*cos(lh_p_a+hAia) + lh_p_x,  hAr*sin(lh_p_a+hAia) + lh_p_y); 
echo("", hBr*cos(lh_p_a+hBia) + lh_p_x,  hBr*sin(lh_p_a+hBia) + lh_p_y); 
echo("", hCr*cos(lh_p_a+hCia) + lh_p_x,  hCr*sin(lh_p_a+hCia) + lh_p_y); 
echo("", hDr*cos(lh_p_a+hDia) + lh_p_x,  hDr*sin(lh_p_a+hDia) + lh_p_y); 
echo("", hEr*cos(lh_p_a+hEia) + lh_p_x,  hEr*sin(lh_p_a+hEia) + lh_p_y); 
echo("", hFr*cos(lh_p_a+hFia) + lh_p_x,  hFr*sin(lh_p_a+hFia) + lh_p_y); 
echo("", hGr*cos(lh_p_a+hGia) + lh_p_x,  hGr*sin(lh_p_a+hGia) + lh_p_y); 
echo("", hHr*cos(lh_p_a+hHia) + lh_p_x,  hHr*sin(lh_p_a+hHia) + lh_p_y); 
echo("", hIr*cos(lh_p_a+hIia) + lh_p_x,  hIr*sin(lh_p_a+hIia) + lh_p_y); 
echo("", hJr*cos(lh_p_a+hJia) + lh_p_x,  hJr*sin(lh_p_a+hJia) + lh_p_y); 
echo("", hKr*cos(lh_p_a+hKia) + lh_p_x,  hKr*sin(lh_p_a+hKia) + lh_p_y, "]");

module show_pins_fa(xya) {
color("red") {

translate([xya[0], xya[1], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[2], xya[3], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[4], xya[5], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[6], xya[7], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[8], xya[9], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[10], xya[11], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[12], xya[13], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[14], xya[15], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[16], xya[17], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[18], xya[19], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[20], xya[21], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[22], xya[23], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[24], xya[25], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[26], xya[27], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[28], xya[29], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[30], xya[31], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[32], xya[33], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[34], xya[35], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[36], xya[37], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
translate([xya[38], xya[39], -5]) cylinder(center=1, r=0.5, h=30, $fn=15);
}
}
/*
show_pins_fa([
7.95149, 8.19952
, 7.18347, 5.77842
, -1.77105, 11.2837
, -2.53907, 8.86259
, 11.2837, 1.77105
, 8.86259, 2.53907
, 8.19952, -7.95149
, 5.77842, -7.18347
, 2.53907, -8.86259
, 1.77105, -11.2837
, -7.18347, -5.77842
, -7.95149, -8.19952
, -8.86259, -2.53907
, -11.2837, -1.77105
, -5.77842, 7.18347
, -8.19952, 7.95149
, 4.14163, -3.81068
, 3.37361, -6.23178
, -5.58091, -0.726507
, -6.34893, -3.14761]);

show_pins_fa([
-21.9953, 15.5442
, -22.177, 13.0107
, -32.1692, 16.2735
, -32.3508, 13.74
, -17.2545, 10.0712
, -19.788, 10.2528
, -17.9838, -0.102652
, -20.5173, 0.0789516
, -23.2752, -2.30998
, -23.4568, -4.84348
, -33.449, -1.58071
, -33.6307, -4.11421
, -35.838, 1.17715
, -38.3715, 1.35876
, -35.1087, 11.351
, -37.6422, 11.5327
, -22.8962, 2.97645
, -23.0778, 0.442954
, -33.0701, 3.70573
, -33.2517, 1.17223]);

show_pins_fa([
-53.2263, 9.18637
, -52.3119, 6.81667
, -62.7424, 5.5144
, -61.828, 3.1447
, -46.6064, 6.25283
, -48.9761, 5.33844
, -42.9344, -3.2633
, -45.3041, -4.17769
, -46.7824, -7.5135
, -45.868, -9.8832
, -56.2985, -11.1855
, -55.3841, -13.5552
, -59.6343, -9.70724
, -62.004, -10.6216
, -63.3063, -0.191112
, -65.676, -1.1055
, -48.6903, -2.56885
, -47.776, -4.93855
, -58.2065, -6.24081
, -57.2921, -8.61052 ]);

show_pins_fa([
-77.743, -7.95513
, -76.3596, -10.0854
, -86.2974, -13.5104
, -84.914, -15.6407
, -70.6604, -9.46057
, -72.7907, -10.844
, -65.1051, -18.015
, -67.2354, -19.3984
, -67.994, -22.9673
, -66.6106, -25.0976
, -76.5484, -28.5226
, -75.165, -30.6529
, -80.1173, -27.764
, -82.2476, -29.1474
, -85.6726, -19.2096
, -87.8029, -20.593
, -70.8805, -18.5224
, -69.4972, -20.6526
, -79.435, -24.0777
, -78.0516, -26.2079]);


*/


difference() {
union() {
  translate([lh_i_x, lh_i_y, 0]) cylinder(h=ks_wall_t, r=ks_fla_r, $fn=gfn);
  translate([lh_m_x, lh_m_y, 0]) cylinder(h=ks_wall_t, r=ks_fla_r, $fn=gfn);
  translate([lh_r_x, lh_r_y, 0]) cylinder(h=ks_wall_t, r=ks_fla_r, $fn=gfn);
  translate([lh_p_x, lh_p_y, 0]) cylinder(h=ks_wall_t, r=ks_fla_r, $fn=gfn);

  translate([lh_i_x, lh_i_y, 0]) cylinder(h=ks_norm_h, r=ks_out_r, $fn=gfn);
  translate([lh_m_x, lh_m_y, 0]) cylinder(h=ks_norm_h, r=ks_out_r, $fn=gfn);
  translate([lh_r_x, lh_r_y, 0]) cylinder(h=ks_norm_h, r=ks_out_r, $fn=gfn);
  translate([lh_p_x, lh_p_y, 0]) cylinder(h=ks_pink_h, r=ks_out_r, $fn=gfn);
} // end union

  translate([lh_i_x, lh_i_y, -csg_tol/2]) cylinder(h=ks_pink_h+csg_tol, r=ks_inn_r, $fn=gfn);
  translate([lh_m_x, lh_m_y, -csg_tol/2]) cylinder(h=ks_pink_h+csg_tol, r=ks_inn_r, $fn=gfn);
  translate([lh_r_x, lh_r_y, -csg_tol/2]) cylinder(h=ks_pink_h+csg_tol, r=ks_inn_r, $fn=gfn);
  translate([lh_p_x, lh_p_y, -csg_tol/2]) cylinder(h=ks_pink_h+csg_tol, r=ks_inn_r, $fn=gfn);

// dont want infinitely small points.  Minkowski seems to die trying this...
// try to just subtract off the points.

  ks_point_remover(lh_i_x, lh_i_y, lh_m_x, lh_m_y);
  ks_point_remover(lh_m_x, lh_m_y, lh_r_x, lh_r_y);
  ks_point_remover(lh_r_x, lh_r_y, lh_p_x, lh_p_y);

  // subtract cylinders for fastener holes

  translate([lh_i_x, lh_i_sty, -csg_tol/2]) cylinder(h=ks_wall_t+csg_tol, r=ks_screw_od/2, $fn=gfn);
  translate([lh_i_x, lh_i_sby, -csg_tol/2]) cylinder(h=ks_wall_t+csg_tol, r=ks_screw_od/2, $fn=gfn);
  translate([lh_m_x, lh_m_sty, -csg_tol/2]) cylinder(h=ks_wall_t+csg_tol, r=ks_screw_od/2, $fn=gfn);  
  translate([lh_m_x, lh_m_sby, -csg_tol/2]) cylinder(h=ks_wall_t+csg_tol, r=ks_screw_od/2, $fn=gfn); 
  translate([lh_r_x, lh_r_sty, -csg_tol/2]) cylinder(h=ks_wall_t+csg_tol, r=ks_screw_od/2, $fn=gfn);  
  translate([lh_r_x, lh_r_sby, -csg_tol/2]) cylinder(h=ks_wall_t+csg_tol, r=ks_screw_od/2, $fn=gfn);
  translate([lh_p_x, lh_p_sty, -csg_tol/2]) cylinder(h=ks_wall_t+csg_tol, r=ks_screw_od/2, $fn=gfn);  
  translate([lh_p_x, lh_p_sby, -csg_tol/2]) cylinder(h=ks_wall_t+csg_tol, r=ks_screw_od/2, $fn=gfn);

}

echo("oaw: ", carrier_oaw);
clip_len = clip_A + clip_B + clip_C + clip_D + clip_E;
echo("clip_len (mm, in): ", clip_len, clip_len / 25.4);
echo("clip_w: ", clip_w, clip_w/25.4);

lclip_len = clip2_A + 2*clip2_B + 2*clip2_C;
echo("clip2_len: ", lclip_len, lclip_len/25.4);

echo("clip2_B: ", clip2_B, clip2_B/25.4);

echo("flange radius: ", ks_fla_r);

echo("lh_i_sty: ", lh_i_sty);
echo("lh_i_sby: ", lh_i_sby);
echo("lh_m_sty: ", lh_m_sty);
echo("lh_m_sby: ", lh_m_sby);
echo("lh_r_sty: ", lh_r_sty);
echo("lh_r_sby: ", lh_r_sby);
echo("lh_p_sty: ", lh_p_sty);
echo("lh_p_sby: ", lh_p_sby);
echo("ks_screw_id: ", ks_screw_id);