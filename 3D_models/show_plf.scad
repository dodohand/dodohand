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

// this file is to show the left-hand finger components in an arrangement
// suitable for submitting for 3D printing.

use <plf.scad>;

include <dimensions.scad>;


plf(0, 0, 0);

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
