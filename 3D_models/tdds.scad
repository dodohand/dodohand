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

use <carrier.scad>;
use <util.scad>;
use <LiteOn_P_100_E302.scad>;
use <lever.scad>;

include <dimensions.scad>;

module tdds_clip() {
  translate([0, tdds_clip_c_y, tdds_mat_t + clip_D + ( 2.0 * clip_mat_t ) ])
    translate([clip_w/2.0, 0, clip_mat_t]) 
      rotate(a=180, v=[0,0,1]) rotate(a=-90, v=[1,0,0])
        clip(0, 0, 0);
}

module tdds_clip_support() {
        pos_c_cube(0, clip_A/2.0 + tdds_clip_c_y, 
                   clip_mat_t/2 + tdds_bar_h - csg_utol, 
                   clip_m_w-csg_utol, clip_A-csg_utol, clip_mat_t);
}

module tdds_bar_c(x, y, z, sc) {
  translate([x,y,z]) {
    difference() {
      union() {
        pos_c_cube(0, 0, tdds_bar_h/2.0, tdds_bar_w, tdds_bar_l, tdds_bar_h);

        tdds_clip_support();
        mirror([0,1,0]) tdds_clip_support();
      } // end union

      pos_c_cube(0, 0, tdds_cbv_h/2.0 + tdds_mat_t, tdds_cbv_w, tdds_cbv_l, tdds_cbv_h);
      
      pos_c_cube(0, -( tdds_bar_l / 2.0 ) + ( tdds_sub_l / 2.0 ) - csg_tol, 
                 tdds_bar_h/2.0, tdds_sub_w, tdds_sub_l, tdds_sub_h);
      pos_c_cube(0, ( tdds_bar_l / 2.0 ) - ( tdds_sub_l / 2.0 ) + csg_tol, 
                 tdds_bar_h/2.0, tdds_sub_w, tdds_sub_l, tdds_sub_h);
/*
ERROR *!*!*! This must be re-enabled. It is expensive (computation) for why??? 

      scale([clip_m_w/clip_w, 1, 1]) tdds_clip();
      mirror([0,1,0]) scale([clip_m_w/clip_w, 1, 1]) tdds_clip();
*/
    } //end difference

    if ( 1 == sc ) {
      tdds_clip();
      mirror([0,1,0]) tdds_clip();
    } // show clip

  } // end translate
} // end module tdds_bar_c

module tdds_mag(x, y, z) {
  color("silver") pos_c_cube(x, y, z, smag_w, smag_h, smag_d);
}

module tdds_irl() {
  Max_LiteOn_P_100_E302( -( tdds_bh_w / 2.0 ) - proc_tol - irle_m_r, 
                         -( tdds_box_l / 2.0 ) + tdds_mat_t, 
                         tdds_irl_z, 
                         tdds_bar_h + tdds_mat_t - tdds_box_h - csg_utol);
}

module tdds_mrb() {
  pos_c_cube(0, tdds_mrb_c_y, tdds_mrb_z,
             tdds_mrb_w, tdds_mrb_l, tdds_mrb_h);
}

module tdds_mrbb() {
  translate([0, tdds_mrb_c_y, tdds_msp_z + tdds_msp_h - tdds_msp_h / 2.0]) 
    sphere(r=tdds_mrbb_r, center=true, $fn=gfn);
  
}

module tdds_fin() {
  // add in the fins which contain the IR beam passage
  pos_c_cube(0, - ( tdds_bh_l / 2.0 ) + ( tdds_fin_l / 2.0 ) - csg_utol, tdds_box_c_z,
           min_wall, tdds_fin_l, tdds_box_h);
}

module tdds_magholes() {
      pos_c_cube(tdds_msp_x, tdds_msp_y, tdds_msp_z, 
                 tdds_msp_w, tdds_msp_l, tdds_msp_h);

      pos_c_cube(tdds_cms_x, tdds_cms_y, tdds_cms_z,
                 tdds_cms_w, tdds_cms_l, tdds_cms_h);
}

module tdds_irbeam() {
 translate([0, -( tdds_box_l / 2.0 ) + tdds_mat_t + irle_m_x,
            irle_m_z + tdds_irl_z]) 
   rotate(a=-90,v=[0,1,0]) 
     cylinder(r=irle_m_r, h=tdds_box_w + ( 2.0 * csg_tol ), 
              center=true, $fn=gfn);
}

module tdds_irlhc() {
  pos_c_cube( -( min_wall + 2*csg_tol ) / 2.0 + tdds_irlh_x - tdds_irlh_w / 2.0 + min_wall + csg_tol, 
               tdds_irlh_y + ( tdds_irlh_l / 2.0 ) - min_wall - min_sep/2.0,
               tdds_irlh_z + min_wall,
               min_wall + 2*csg_tol,
               min_sep,
               tdds_irlh_h);

  pos_c_cube( -( min_wall + 2*csg_tol ) / 2.0 + tdds_irlh_x - tdds_irlh_w / 2.0 + min_wall + 1.75*csg_tol, 
               tdds_irlh_y + ( tdds_irlh_l / 2.0 ) - min_wall + min_sep/2.0 - irlb_m_w,
               tdds_irlh_z + min_wall,
               min_wall + 2*csg_tol,
               min_sep,
               tdds_irlh_h);
}

module tdds_irlrb() {
  // add in retaining bump to ensure that a nominal IR device is held firm
  translate([-( tdds_bh_w / 2.0 ) - proc_tol - irle_m_r - irlb_m_d,
             -tdds_box_l/2.0 + tdds_mat_t + irle_x, 
             irle_z + tdds_irl_z]) 
    sphere(r=irltol*1.5, $fn=gfn, center=true);
}

module tdds_box_c(x, y, z, sm) {
  translate([x,y,z]) {
    difference() {
      union() {
        difference() {
          union() {
            pos_c_cube(0, 0, tdds_box_c_z,
                       tdds_box_w, tdds_box_l, tdds_box_h);

            pos_c_cube(tdds_irlh_x, tdds_irlh_y, tdds_irlh_z,
                       tdds_irlh_w, tdds_irlh_l, tdds_irlh_h);
            
            mirror([1,0,0]) pos_c_cube(tdds_irlh_x, tdds_irlh_y, tdds_irlh_z,
                       tdds_irlh_w, tdds_irlh_l, tdds_irlh_h);

            mirror([0,1,0]) pos_c_cube(tdds_irlh_x, tdds_irlh_y, tdds_irlh_z,
                       tdds_irlh_w, tdds_irlh_l, tdds_irlh_h);

            mirror([0,1,0]) mirror([1,0,0]) 
              pos_c_cube(tdds_irlh_x, tdds_irlh_y, tdds_irlh_z,
                         tdds_irlh_w, tdds_irlh_l, tdds_irlh_h);

          } // innermost union
          pos_c_cube(0, 0, -tdds_bh_h/2.0 + tdds_bar_h,
                     tdds_bh_w, tdds_bh_l, tdds_bh_h + csg_tol);

          // cutouts for making the IRLED holder cuts to make flap
          tdds_irlhc();
          mirror([1,0,0]) tdds_irlhc();
          mirror([0,1,0]) tdds_irlhc();
          mirror([0,1,0]) mirror([1,0,0]) tdds_irlhc();

          // spaces for the IR LED components
          tdds_irl();
          mirror([1,0,0]) tdds_irl();
          mirror([0,1,0]) tdds_irl();
          mirror([0,1,0]) mirror([1,0,0]) tdds_irl();

          pos_c_cube(0, tdds_ah_y, tdds_ah_z, 
                     tdds_ah_w, tdds_ah_l, tdds_ah_h);

        } // difference

        // add in the fins which contain the IR beam passage
        tdds_fin();
        mirror([0,1,0]) tdds_fin();

        // add in magnet retension bar
        tdds_mrb();
        mirror([0,1,0]) tdds_mrb();

       // add in retaining bump to ensure that a nominal IR device is held firm
       tdds_irlrb();
       mirror([1,0,0]) tdds_irlrb();
       mirror([0,1,0]) tdds_irlrb();
       mirror([0,1,0]) mirror([1,0,0]) tdds_irlrb();


      } // union

      tdds_magholes();
      mirror([0,1,0]) tdds_magholes();

      tdds_irbeam();
      mirror([0,1,0]) tdds_irbeam();

    } // difference

    if ( 1 == sm ) {
      tdds_mag(0, tdds_clip_c_y + ( smag_h / 2.0 ), tdds_mag_c_z);
      mirror([0,1,0]) tdds_mag(0, tdds_clip_c_y + ( smag_h / 2.0 ), tdds_mag_c_z);

    }

    tdds_mrbb();
    mirror([0,1,0]) tdds_mrbb();

  } // end translate
}

module tdds_centered(x, y, z, sc, sm) {

  tdds_bar_c(x, y, z, sc);
  tdds_box_c(x, y, z, sm);

} // end module tdds_centered
