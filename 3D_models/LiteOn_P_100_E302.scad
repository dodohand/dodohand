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

module soldercone(a, b, c) {
  // cone for relief of material where solder may wick, and heat highest
  // echo("soldercone x,y,z:", a, ", ", b, ", ", c);
  translate([a, b, c]) {
    cylinder(r1 = sc_l_r, r2 = sc_u_r, h = sc_h, $fn=gfn);
  }
}

module Nom_Everlight_PT908_7B_F(x, y, z) {
  translate([x, y, z]) {
    rotate(a=90, v=[0,0,1]) {
      union() {
        color([0.15,0.15,0.15,1]) {
          cube([irlb_w, irlb_d, irlb_h]);
          translate([irle_x, irle_y, irle_z]) sphere(irle_r, $fn=gfn);
        }
        color("LightSteelBlue") {
          translate([irlcath_x, irll_y, -irptlead_h]) 
            cube([irll_w, irll_d, irptlead_h+csg_tol]);
          translate([irlanod_x, irll_y, -irptlead_h]) 
            cube([irll_w, irll_d, irptlead_h+csg_tol]);
        }
      }
    }
  }
}  


module Nom_LiteOn_P_100_E302(x, y, z) {
  translate([x, y, z]) {
    rotate(a=90, v=[0,0,1]) {
      union() {
        color("Salmon") {
          cube([irlb_w, irlb_d, irlb_h]);
          translate([irle_x, irle_y, irle_z]) sphere(irle_r, $fn=gfn);
        }
        color("LightSteelBlue") {
          translate([irlcath_x, irll_y, -irlcath_h]) 
            cube([irll_w, irll_d, irlcath_h+csg_tol]);
          translate([irlanod_x, irll_y, -irlanod_h]) 
            cube([irll_w, irll_d, irlanod_h+csg_tol]);
        }
      }
    }
  }
}  

// this is the shape of the part at it's maximum-tolerance size.
module Max_LiteOn_P_100_E302(x, y, z, scz) {
  translate([x, y, z]) {
    rotate(a=90, v=[0,0,1]) {
      union() {
        color("Salmon") {
          cube([irlb_m_w, irlb_m_d, irlb_m_h]);
          translate([irle_m_x, irle_m_y, irle_m_z]) 
            sphere(irle_m_r, $fn=gfn);
        }
        color("LightSteelBlue") {
          // make the leads thicker on the max part so that it can be used
          // for subtracting out of the volume of the carrier.
          translate([irlcath_m_x, irll_m_y, -irlcath_h]) 
            cube([irll_m_w, irll_m_d, irlcath_h+csg_tol]);
          translate([irlanod_m_x, irll_m_y, -irlanod_h]) 
            cube([irll_m_w, irll_m_d, irlanod_h+csg_tol]);
          soldercone(irlanod_m_x + irll_m_w/2, 
                      irll_m_y + irll_m_d/2, 
                      scz-z); 
          soldercone(irlcath_m_x + irll_m_w/2, 
                      irll_m_y + irll_m_d/2, 
                      scz-z);
        }
      }
    }
  }
}
