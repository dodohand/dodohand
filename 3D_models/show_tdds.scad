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
use <LiteOn_P_100_E302.scad>;

include <dimensions.scad>;

difference() {
  tdds_centered(0, 0, 0, 1, 1);

//  pos_c_cube(-50, 0, 0, 100, 100, 100);

} // end difference


% pos_c_cube( tdds_irll_x, tdds_irll_y1, 0,
              irll_m_w, irll_m_w, 100);

% pos_c_cube( tdds_irll_x, tdds_irll_y2, 0,
              irll_m_w, irll_m_w, 100);

% pos_c_cube( -tdds_irll_x, tdds_irll_y1, 0,
              irll_m_w, irll_m_w, 100);

% pos_c_cube( -tdds_irll_x, tdds_irll_y2, 0,
              irll_m_w, irll_m_w, 100);

% pos_c_cube( tdds_irll_x, -tdds_irll_y1, 0,
              irll_m_w, irll_m_w, 100);

% pos_c_cube( tdds_irll_x, -tdds_irll_y2, 0,
              irll_m_w, irll_m_w, 100);

% pos_c_cube( -tdds_irll_x, -tdds_irll_y1, 0,
              irll_m_w, irll_m_w, 100);

% pos_c_cube( -tdds_irll_x, -tdds_irll_y2, 0,
              irll_m_w, irll_m_w, 100);


echo("tdds_irll_x: (in) ", tdds_irll_x / in2mm );
echo("tdds_irll_y1: (in) ", tdds_irll_y1 / in2mm );
echo("tdds_irll_y2: (in) ", tdds_irll_y2 / in2mm );
echo("tdds_mat_t: (in) ", tdds_mat_t / in2mm );
echo("tdds_box_w: (in) ", tdds_box_w / in2mm );
echo("tdds_box_l: (in) ", tdds_box_l / in2mm );

