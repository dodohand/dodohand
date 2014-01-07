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

module smaglev(x, y, z) {
 translate([x, y, z]) {
  union() {
    difference() {
      // lever
      union() {
        cube([lev_w, lev_d, lev_h]);
        translate([0, lev_d-smag_d/2-lev_d, stop_pos_z - slev_h - 3*proc_tol]) {
          cube([lev_w, slev_d, slev_h + 3*proc_tol + min_wire]);
        } // end translate
      } // end union

      translate([levhole_pos_x, -lev_d-(csg_tol/2), slevhole_pos_z]) {
        cube([levhole_w, lev_d + slev_d + csg_tol, slevhole_h]);
      } // end translate

      translate([lev_w/2 - smag_w/2 - proc_tol/2, lev_d-smag_d/2, mag_pos_z]) {
        cube([smag_w + proc_tol, smag_d, mag_h + proc_tol]);
      }

    } // end difference

    // first make cavity for mag
    // make outer lip
    translate([lip_pox_x, lip_pos_y, slip_pos_z]) {
      cube([lip_w, min_wall, smag_h]);  
    }
    translate([lev_w - lip_pox_x - lip_w, lip_pos_y, slip_pos_z]) {
      cube([lip_w, min_wall, smag_h]);  
    }
   
    // make side walls
    translate([sidewall_pos_x, lev_d, smag_pos_z]) {
      cube([min_wall, min_wall + mag_d, smag_h]);
    }
    translate([lev_w - sidewall_pos_x - min_wall, lev_d, smag_pos_z]) {
      cube([min_wall, min_wall + mag_d, smag_h]);
    }
  
    // make clip
    translate([clip_pos_x, lev_d-smag_d/2-lev_d, sclip_pos_z]) {
      cube([mag_clip_w, lev_d, sclip_h]);
    }
    // add stop
    translate([clip_pos_x, lev_d, stop_pos_z]) {
      cube([mag_clip_w, lip_w, min_wire]);
    }
    // add keeper
    translate([clip_pos_x, lev_d-smag_d/2, skeeper_pos_z]) {
      cube([mag_clip_w, lip_w, min_wire]);
    }

   // add pivot
   translate([pivot_x_pos, pivot_y_pos, pivot_z_pos]) {
    rotate(a=90, v=[0,1,0]){
      cylinder(r=pivot_r, h=pivot_oal, $fn=gfn);
    }
   }

   // add anti-friction bumps
   translate([bump_pos_x, bump_pos_y, sbump_pos_z]) {
    rotate(a=-90, v=[1,0,0]) {
     cylinder(r=bump_r, h=bump_h, $fn=gfn);
    }
   }

   translate([bump_pos_x - lev_w, bump_pos_y, sbump_pos_z]) {
    rotate(a=-90, v=[1,0,0]) {
     cylinder(r=bump_r, h=bump_h, $fn=gfn);
    }
   }

   // add lock bumps - prevent key pull-out.
   translate([lock_p_x, lock_p_y, lock_p_z]) {
    cube([lock_w, lock_d, lock_h]);
   }

   translate([lock_p_x - lev_w - lock_w, lock_p_y, lock_p_z]) {
    cube([lock_w, lock_d, lock_h]);
   }


    //smag(lev_w/2 - smag_w/2, lev_d-smag_d/2, smag_pos_z);

  } // end union
 } // end translate
}

module lever(x,y,z) {

   difference() {

    // lever
    cube([lev_w, lev_d, lev_h]);

    translate([levhole_pos_x, 0-(csg_tol/2), levhole_pos_z]) {
     cube([levhole_w, lev_d+csg_tol, levhole_h]);
    }
   } 
// end of difference to sub levhole.

   // first make cavity for mag
   // make outer lip
   translate([lip_pox_x, lip_pos_y, lip_pos_z]) {
    cube([lip_w, min_wall, mag_h]);  
   }
   translate([lev_w - lip_pox_x - lip_w, lip_pos_y, lip_pos_z]) {
    cube([lip_w, min_wall, mag_h]);  
   }
  
   // make side walls
   translate([sidewall_pos_x, lev_d, mag_pos_z]) {
    cube([min_wall, min_wall + mag_d, mag_h]);
   }
   translate([lev_w - sidewall_pos_x - min_wall, lev_d, mag_pos_z]) {
    cube([min_wall, min_wall + mag_d, mag_h]);
   }
 
   // make clip
   translate([clip_pos_x, 0, clip_pos_z]) {
    cube([mag_clip_w, lev_d, clip_h]);
   }
   // add stop
   translate([clip_pos_x, lev_d, stop_pos_z]) {
    cube([mag_clip_w, lip_w, min_wire]);
   }
   // add keeper
   translate([clip_pos_x, lev_d, keeper_pos_z]) {
    cube([mag_clip_w, lip_w, min_wire]);
   }
  
   // add pivot
   translate([pivot_x_pos, pivot_y_pos, pivot_z_pos]) {
    rotate(a=90, v=[0,1,0]){
      cylinder(r=pivot_r, h=pivot_oal, $fn=gfn);
    }
   }

   // add anti-friction bumps
   translate([bump_pos_x, bump_pos_y, bump_pos_z]) {
    rotate(a=-90, v=[1,0,0]) {
     cylinder(r=bump_r, h=bump_h, $fn=gfn);
    }
   }

   translate([bump_pos_x - lev_w, bump_pos_y, bump_pos_z]) {
    rotate(a=-90, v=[1,0,0]) {
     cylinder(r=bump_r, h=bump_h, $fn=gfn);
    }
   }

   // add lock bumps - prevent key pull-out.
   translate([lock_p_x, lock_p_y, lock_p_z]) {
    cube([lock_w, lock_d, lock_h]);
   }

   translate([lock_p_x - lev_w - lock_w, lock_p_y, lock_p_z]) {
    cube([lock_w, lock_d, lock_h]);
   }
} // end of lever




module lowlev(x,y,z, sm) {
  // sm = show magnet
  translate([x, y, z]) {
   rotate(a=show_lr_angle, v=[1,0,0]) {
    union() {
      difference() {
   
       // lever
       cube([lev_w, lev_d, llev_h]);
   
       translate([levhole_pos_x, 0-(csg_tol/2), llevhole_pos_z]) {
        cube([levhole_w, lev_d+csg_tol, llevhole_h]);
       }
      } // end of difference to sub levhole.
   
      // first make cavity for magnet
      // make outer lip
      difference() {
        union() {
          translate([llip_pos_x, lip_pos_y, llip_pos_z]) {
           cube([lip_w, min_wall, mag_h + min_wire]);
          }
          translate([lev_w - llip_pos_x - lip_w, lip_pos_y, llip_pos_z]) {
           cube([lip_w, min_wall, mag_h + min_wire]);
          }

          // add the anvil for center button to push against
          translate([llanv_x, lip_pos_y, llip_pos_z-llanv_oh]) {
            cube([lev_w, min_wall, llanv_h]);
          }
   
          // make side walls
          translate([llsw_x, lev_d, lmag_pos_z]) {
           cube([min_wall, min_wall + mag_d, mag_h + min_wire]);
          }
          translate([lev_w - llsw_x - min_wall, lev_d, lmag_pos_z]) {
           cube([min_wall, min_wall + mag_d, mag_h + min_wire]);
          }

        } // end union
        
        // subtract clearance for ferrous target
        translate([sidewall_pos_x - csg_tol, 
                   lip_pos_y,
                   cbsw2_y - lbs_y - min_wall]) {
          cube([lev_w + 2*csg_tol, min_wall + csg_tol, clip2_w + 2*proc_tol]);
        } // translate

        // subtract clearance for ptp clearance between clip keeper and anvil
        translate([clip_pos_x-min_sep/2, lip_pos_y-csg_tol, lkeeper_pos_z-min_sep/2]) {
          cube([min_wire + min_sep, min_wall+2*csg_tol, min_wire + min_sep]);
        }
   
      } // end difference
   
      // make clip
      translate([clip_pos_x, 0, lclip_pos_z]) {
       cube([mag_clip_w, lev_d, lclip_h]);
      }
      // add stop
      translate([clip_pos_x, lev_d, lstop_pos_z]) {
       cube([mag_clip_w, lip_w, min_wire]);
      }
      // add keeper
      translate([clip_pos_x, lev_d, lkeeper_pos_z]) {
       cube([mag_clip_w, lip_w, min_wire]);
      }
     
      // add pivot
      translate([pivot_x_pos, pivot_y_pos, pivot_z_pos]) {
       rotate(a=90, v=[0,1,0]){
         cylinder(r=pivot_r, h=pivot_oal, $fn=gfn);
       }
      }
   
      // add anti-friction bumps
      translate([bump_pos_x, bump_pos_y, lbump_pos_z]) {
       rotate(a=-90, v=[1,0,0]) {
        cylinder(r=bump_r, h=bump_h, $fn=gfn);
       }
      }
   
      translate([bump_pos_x - lev_w, bump_pos_y, lbump_pos_z]) {
       rotate(a=-90, v=[1,0,0]) {
        cylinder(r=bump_r, h=bump_h, $fn=gfn);
       }
      }
   
      // add lock bumps - prevent key pull-out.
      translate([lock_p_x, lock_p_y, lock_p_z]) {
       cube([lock_w, lock_d, lock_h]);
      }
   
      translate([lock_p_x - lev_w - lock_w, lock_p_y, lock_p_z]) {
       cube([lock_w, lock_d, lock_h]);
      }
    } // union

    if( 1 == sm ) magnet(mag_pos_x, mag_pos_y, lmag_pos_z);
   } // end of rotate
  } // end of translate
} // end of lowlev


module big_key(x,y,z, sm) {
  // sm = show magnet
  translate([x,y,z]) {
   rotate(a=show_lr_angle, v=[1,0,0]) {
    union() {

/*
      translate([0, key_fp_y, 0]) {

      // make the key shape

      intersection() {
        difference() {
          translate([key_p_x, key_p_y, key_p_z]) {
            scale(v=[1,1,8/5]) { cube([sm_key_w, sm_key_d, sm_key_h]); }
          }
          // subtract inner radius
          translate([lev_w/2, keyring_r, key_p_z-(csg_tol/2)]) {
            scale(v=[1,1,8/5]) { cylinder(r=key_inner_r, h=sm_key_h+csg_tol, $fn=gfn); }
          }
        }

        // outer radius
        translate([lev_w/2, keyring_r, key_p_z]) {
          scale(v=[1,1,8/5]) { cylinder(r=key_outer_r, h=sm_key_h, $fn=gfn); }
        }

        translate([lev_w/2, 
                   lev_d/2 - sm_key_d/2 + sm_key_d, 
                   lev_h + sm_key_h - proc_min_wire - key_upper_r]) {
          
          scale(v=[1,1,8/5]) rotate(a=90, v=[1,0,0]) {
            cylinder(r=key_upper_r, h=lg_key_d, $fn=gfn);
          }
        }
      } // intersection
    } // translate key_fp_y
*/
  
      translate([0, key_fp_y, 0]) {
    
        // make the key shape
    
        intersection() {
          difference() {
            translate([key_p_x, key_p_y, key_p_z]) {
              cube([lg_key_w, lg_key_d, lg_key_h]);
            }
            // subtract inner radius
            translate([lev_w/2, keyring_r, key_p_z-(csg_tol/2)]) {
              cylinder(r=key_inner_r, h=lg_key_h+csg_tol, $fn=gfn);
            }
          }
      
          // outer radius
          translate([lev_w/2, keyring_r, key_p_z-2]) {
            rotate(a=lgkey_back_ang, v=[1,0,0]) 
	      cylinder(r=key_outer_r, h=lg_key_h+2, $fn=gfn);
          }
      
          translate([lev_w/2, 
                     lev_d/2 - lg_key_d/2 + lg_key_d, 
                     lev_h + lg_key_h - proc_min_wire*0.75 - key_upper_r]) {
           union() {
            rotate(a=90, v=[1,0,0]) {
              cylinder(r=key_upper_r, h=lg_key_d, $fn=gfn);
            }
            translate([-key_upper_r, -lg_key_d, -key_upper_r]) 
              cube([2*key_upper_r, lg_key_d, key_upper_r]);

           }
          }
        }
      } // translate key_fp_y
   
      smaglev(0, 0, 0);
  
    } // union

    if( 1 == sm ) smag(smag_pos_x, smag_pos_y, smag_pos_z);
   } // rotate
  } // translate x,y,z
} // big_key
 
module small_key(x,y,z,sm) {
  // sm == show magnet
  translate([x,y,z]) {
   rotate(a=show_lr_angle, v=[1,0,0]) {
    union() {
      translate([0, key_fp_y, 0]) {

      // make the key shape

      intersection() {
        difference() {
          translate([key_p_x, key_p_y, key_p_z]) {
            cube([sm_key_w, sm_key_d, sm_key_h]);
          }
          // subtract inner radius
          translate([lev_w/2, keyring_r, key_p_z-(csg_tol/2)]) {
            cylinder(r=key_inner_r, h=sm_key_h+csg_tol, $fn=gfn);
          }
        }

        // outer radius
        translate([lev_w/2, keyring_r, key_p_z-2]) {
          rotate(a=key_back_ang, v=[1,0,0]) 
	    cylinder(r=key_outer_r, h=sm_key_h+2, $fn=gfn);
        }
	// upper radius
        translate([lev_w/2, 
                   lev_d/2 - sm_key_d/2 + sm_key_d, 
                   lev_h + sm_key_h - proc_min_wire*0.75 - key_upper_r]) {
         union() {
          rotate(a=90, v=[1,0,0]) {
            cylinder(r=key_upper_r, h=lg_key_d, $fn=gfn);
          }
          translate([-key_upper_r, -lg_key_d, -key_upper_r]) 
	    cube([2*key_upper_r, lg_key_d, key_upper_r]);
         }
        } // translate
      } // intersection
    } // translate key_fp_y

    smaglev(0, 0, 0);

    } // union

    if( 1 == sm ) smag(smag_pos_x, smag_pos_y, smag_pos_z);
   } // rotate
  } // translate x, y, z
} // small_key


module magnet(x, y, z) {
  // add magnet
  translate([x, y, z]) {
    color("silver") {
      cube([mag_w, mag_d, mag_h]);
    }
  }
} // end magnet

module smag(x, y, z) {
  // add side-lever magnet
  translate([x, y, z]) {
    color("silver") {
      cube([smag_w, smag_d, smag_h]);
    }
  }
} // end smag
