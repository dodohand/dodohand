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

module pos_half_cube(x, y, z, w, l, h)
{
  translate([x, y, z]) half_cube(w, l, h);
}

module half_cube(x, y, z) {

  polyhedron(points = [[0,0,0], [0, 0, z], [x, 0, 0], 
              [0,y,0], [0, y, z], [x, y, 0]], 
             faces = [[0,1,2], 
                      [0,3,4], [0,4,1], 
                      [1,4,5], [1,5,2], 
                      [2,5,3], [2,3,0],
                      [3,5,4]],
             convexity = 1);
}

module pos_cube(x, y, z, w, l, h) {
  translate([x, y, z]) cube([w, l, h]);
}

module pos_c_cube(x, y, z, w, l, h) {
  translate([x, y, z]) cube([w, l, h], center=true);
}

module pos_c_half_sphere(x, y, z, sr, f) {
  translate([x, y, z]) {
    difference() {
      sphere(r=sr, $fn=f, center=true);
      translate([-2.*sr, 0, -2*sr]) cube([4*sr, 4*sr, 4*sr]);
    } // difference
  } // translate
}
