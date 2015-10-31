/*
    This file is part of the DodoHand project. This project aims to create 
    an open implementation of the DataHand keyboard, capable of being created
    with commercial 3D printing services.

    Copyright (C) 2013, 2014 Scott Fohey

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

// This file defines dimensions for all aspects of all models.

show_mag = 0;
// angle to show lever rotation
show_lr_angle = 0;

// global face number set here
//gfn=87; // 87 is the max that fit in the shapeways 64MB size limit.
gfn=12;
//gfn=50;

// units are in mm

// used to convert inches to mm
in2mm = 25.4;

/* originally used - seems a bit tight.
 * // properties of shapeways sls nylon
 * min_wall = 0.7;
 * min_wire = 1.0;
 * min_sep  = 0.5;
 * proc_tol = 0.15; // plus 0.15% of overall length
 * min_detail = 0.2;
 * ptp_clearance = 0.2;
*/

// properties of shapeways sls nylon
// after first prototype - desire to back away from process limits
min_wall = 0.7;
proc_min_wire = 1.0;
min_wire = proc_min_wire + 0.2;
proc_min_sep = 0.5;
min_sep  = proc_min_sep + 0.2;
proc_tol = 0.2; // plus 0.15% of overall length
min_detail = 0.3;
ptp_clearance = 0.3;

csg_tol = 0.1; // fudge a volume larger than needed in case plane is left 
csg_utol = 0.01; // fudge a volume just a bit larger than needed......
// after a difference operation.

//*****************************************************************************
//*****************************************************************************
// start of dimensioning and positioning of lever components
//

// dimensions of the magnet to be used for the N/E/S/W (side) buttons
// K&J Magnetics B221 magnet
smag_w = in2mm * 1/8;
smag_h = in2mm * 1/8;
smag_d = in2mm * 1/16;
smag_hole_tol = 0.2;

// dimensions of the magnet to be used for the center pushbutton
// K&J Magnetics B4201 magnet
mag_w = in2mm * 1/8;
mag_h = in2mm * 1/4;
mag_d = in2mm * 1/32;
mag_hole_tol = 0.2;

lip_w = 0.5 + mag_hole_tol/2;     // lip size which retains magnet
lev_d = 1;       // depth of material in lever
slev_d = lev_d + mag_d;
lev_h = 12;      // height of lever (below key, not including pivot radius)
slev_h = 2 * smag_h;
pivot_w = min_detail; // width of extension of lower pivot beyond side of lever
bump_r = min_detail;  // width of anti-friction bumps on side of lever

keyring_r = 8.5;
key_inner_r = keyring_r - 1.5;
key_outer_r = key_inner_r + 3;
key_back_ang = -8.0;
lgkey_back_ang = -5.0;

// radius of lower lever pivot
pivot_r = lev_d/2;

// outer dimension width of the pocket which holds the magnet
// magnets barely fit so added mag_hole_tol to boost the pocket size.
pocket_w = mag_w + (min_wall * 2) + mag_hole_tol;

// dimensions of flexible clip which captures magnet
mag_clip_w = min_wire;
// dimensions of the hole in which the flexible clip sits.
levhole_w = 2*min_sep + mag_clip_w;

// min lever width is two side wires + center clip + 2 gaps
min_lev_w = 2*min_wire + levhole_w;

// lever width (excluding bumps, key, and locking bars)
lev_w = (pocket_w < min_lev_w) ? min_lev_w : pocket_w;

// finish position of magnet now that lever width is known
mag_pos_x = lev_w/2 - mag_w/2;
mag_pos_y = lev_d;
// put mag at top of lever, leaving room for bridge and keeper bump.
mag_pos_z = lev_h - min_wire - min_wire - mag_h;
smag_pos_z = mag_pos_z + (mag_h - smag_h);
smag_pos_x = mag_pos_x;
smag_pos_y = lev_d-smag_d/2;

// make volume to subtract from lever - clip will go in here
clip_h = (2 * min_wire) + mag_h;
sclip_h = (2 * min_wire) + smag_h;
levhole_h = min_sep + clip_h - 2*min_wire;
slevhole_h = min_sep + sclip_h - min_wire;
levhole_pos_z = lev_h - clip_h - min_wire - min_sep;
slevhole_pos_z = lev_h - sclip_h - min_wire - min_sep;
levhole_pos_x = lev_w/2 - levhole_w/2;

// locate the sidewalls which support the lips
sidewall_pos_x = lev_w/2 - pocket_w/2;

// locate the lips which retain the magnet
lip_pox_x = sidewall_pos_x + min_wall;
lip_pos_y = lev_d + mag_d;
lip_pos_z = mag_pos_z;
slip_pos_z = lip_pos_z + (mag_h - smag_h);

// locate the clip which retains the magnet
clip_pos_x = lev_w/2 - mag_clip_w/2;
clip_pos_z = lev_h - clip_h - min_wire;
sclip_pos_z = lev_h - sclip_h - min_wire;
stop_pos_z = lev_h - min_wire - min_wire + proc_tol;

// locate the keeper bump which hold magnet at bottom
keeper_pos_z = mag_pos_z - min_wire;
skeeper_pos_z = smag_pos_z - min_wire;

// locate the pivot on which the lever moves
pivot_r = lev_d/2;
pivot_oal = lev_w + 2*pivot_w;
pivot_x_pos = lev_w/2 - pivot_oal/2;
pivot_y_pos = pivot_r;
pivot_z_pos = 0;

// locate the bumps on the side of the lever which reduce friction with carrier
bump_h = min_wall;
bump_pos_x = lev_w;
bump_pos_y = lip_pos_y;
bump_pos_z = mag_pos_z + mag_h/2;
sbump_pos_z = mag_pos_z + mag_h/2 + bump_r;

// dimension the lock pins which prevent lever pull-up/pull-out
lock_ext_w = 1; // this is the extension of the locks beyond the bumps
lock_w = lock_ext_w + bump_r;
lock_d = lev_d;
lock_h = 1;
lock_diag = sqrt(lock_d*lock_d + lock_h*lock_h);

// locate the lock pins which prevent lever pull-up/pull-out
lock_p_x = lev_w;
lock_p_y = 0;
lock_p_z = 1.5 * lev_d;

//
// end of dimensioning and positioning of lever components
//*****************************************************************************
//*****************************************************************************


//*****************************************************************************
//*****************************************************************************
// start of dimensioning and positioning of IR LED components
//

// These are the size per datasheet
irltol = 0.2;
irlb_w = 4.4;
irlb_m_w = irlb_w + irltol;
irlb_d = 1.5;
irlb_m_d = irlb_d + irltol;
irlb_h = 5.72;
irlb_m_h_xtra = 0.1; // had to snap in some leds w/ pliers. add extra space.
irlb_m_h = irlb_h + irltol + irlb_m_h_xtra;
irle_r = 0.75;
irle_m_r = irle_r + irltol/2;
irle_x = irlb_w/2;
irle_m_x = irlb_m_w/2;
irle_y = 0;
irle_m_y = 0;
irle_z = 4.5; // nominal position
irle_m_z = irle_z + irltol/2;
irll_w = 0.5;
// make max-size leads for clearance in carrier on Max size part
irll_m_w = irll_w + 2*irltol;
irll_d = 0.5;
irll_m_d = irll_d + 2*irltol;
irlcath_h = 12.7;
irlanod_h = 13.7;
irptlead_h = 10.0;
irll_y = irlb_d/2 - irll_d/2;
irll_m_y = irlb_m_d/2 - irll_m_d/2;
irll_spacing_x = 2.54;
irlcath_x = irlb_w/2 - irll_spacing_x/2 - irll_w/2;
irlcath_m_x = irlb_m_w/2 - irll_spacing_x/2 - irll_m_w/2;
irlanod_x = irlcath_x + irll_spacing_x;
irlanod_m_x = irlcath_m_x + irll_spacing_x;

// make end-wall thick enough to function as a shield for eye
sw_eye_wall_w = 1.3;

// sidewall parameters
sw_w = min_wall + irlb_d + irltol + sw_eye_wall_w;

// position in sidewall of InfraRed LED calculated later

// position in sidewall of InfraRed LED
// X dimension needs moved back just far enough to achieve min_wall
irl_x = sw_w - sw_eye_wall_w;
// Z position needs lifted until eye is just below top of magnet
irl_z = pivot_r + mag_pos_z + mag_h*3/4 - irle_z;

//
// end of dimensioning and positioning of InfraRed components
//*****************************************************************************
//*****************************************************************************


//*****************************************************************************
//*****************************************************************************
// start of dimensioning and positioning of carrier components
//

// parameters of lower (thin) parts of receiving void for lever in carrier.
// this space is below the magnet and keeper bump.
low_void_d = 2;
low_void_h = mag_pos_z - ptp_clearance + pivot_r;

// carrier opening width for the lever
opening_w = lev_w + 2*bump_r + ptp_clearance;

// catch dimensions - the catch holds the bottom of the lever
catch_w = opening_w - 2*min_sep;
//catch_h = low_void_d + (0.2 * low_void_d);
catch_h = pivot_r + lock_p_z + lock_h/3;
catch_d = min_wall;

// lower backstop dimensioning and positioning part 1
lbs_d = min_wall;

// sidewall height, depth, width set after InfraRed LED parameters set.
sw_x = 0;
sw_y = 0;
sw_z = 0;

// floor dimensions - floor of the lever well
floor_d = catch_d + low_void_d + min_wall;
floor_w = opening_w + ( 2 * sw_w );
floor_h = min_wall;

// dimensions of starting block for large key
lg_key_d = 5;
lg_key_w = floor_w;
lg_key_h = 10 + proc_min_wire + min_wire/2;
key_upper_r = (lg_key_h-proc_min_wire - min_wire/2) * 2/3;

// dimensions of starting block for small key
sm_key_d = lg_key_d;
sm_key_w = lg_key_w;
sm_key_h = (lg_key_h-proc_min_wire-min_wire/2)*5/8 + proc_min_wire + + min_wire/2;

// position of the key precursor block
key_p_x = lev_w/2 - lg_key_w/2;
key_p_y = lev_d/2 - lg_key_d/2;
key_p_z = lev_h - proc_min_wire - min_wire/4;

// key final position not shifted slight inward.
key_fp_y = 0;

// catch position (relative to floor)
catch_x = floor_w/2 - catch_w/2;
catch_y = 0;
catch_z = 0;

// lower backstop dimensioning and positioning part 2
lbs_w = opening_w;
lbs_h = low_void_h + 1.5;
lbs_x = floor_w/2 - lbs_w/2;
lbs_y = low_void_d + catch_d;
lbs_z = 0;

// position in sidewall of InfraRed LED calculated here
irl_y = min_wall;

// sidewall height getting set here: at top of IR devices.
sw_d = irl_y + irlb_w + irltol + min_wall;
sw_h = irl_z + irlb_h ;

swcap_x = sw_x + min_wall + irlb_m_d/2;
swcap_y = sw_y;
swcap_z = sw_h + sw_z;

swcap_w = sw_w - min_wall - irlb_m_d/2;
swcap_d = sw_d;
swcap_h_c1 = min_wall;
swcap_h_c2 = irl_z + irlb_m_h + min_wall - ( sw_h + sw_z );
swcap_h = (swcap_h_c1 < swcap_h_c2) ? swcap_h_c2 : swcap_h_c1;

// void in sidewall for lock
swlv_d = low_void_d + catch_d;
swlv_w = lock_ext_w + ptp_clearance;
// allow rectangular lock to rotate within lock void to allow insertion
// by making void high enough to accomodate that.
swlv_h = lock_diag + proc_tol;
swlv_x = sw_x + sw_w - swlv_w;
swlv_y = 0;
swlv_z = lock_p_z + pivot_r + lock_h - swlv_h + proc_tol;

// extra relief of outside edge to allow insertion
swlvr_w = swlv_w;
swlvr_d = lock_d + ptp_clearance;
swlvr_h = 2*lock_h + ptp_clearance;
swlvr_a = 45;
swlvr_x = swlv_x;
swlvr_y = 0 + catch_y;
swlvr_z = swlv_z + swlv_h/3;

swlc_x = 0;
swlc_y = irl_y;
swlc_z = irl_z;

swlc_w = min_wall;
swlc_d = min_sep;
swlc_h = irlb_h + irltol;

wl_x = bump_r + sw_w + ptp_clearance/2;
wl_z = pivot_r + csg_utol;

// solder clearance specs
sc_l_r = 1.1;
sc_u_r = 0.35;
sc_h   = 2.5;

//
// end of dimensioning and positioning of carrier components
//*****************************************************************************
//*****************************************************************************
//
// Start of dimensioning of little clips which attract the magnets.
//
//
//

// clip metal source material thickness
clip_mat_t = in2mm * 0.020;
clip2_mat_t = in2mm * 0.020;
// clip inner radius of bend
clip_inn_r = clip_mat_t * 1.0;
// height of bend
clip_bend_h = clip_inn_r + clip_mat_t;
//
//       <-- A -->
//      ----------
//     D|<-B>
//      -----
//           |E
//         --
//         C

clip_oh = 1.6; // clip overhang (clip_A is now longer than magnet)
clip_A = smag_h - clip_mat_t + clip_oh;
clip_B = mag_h/3;
clip_C = 1.0;
clip_D_inner = 1.1;
clip_D = clip_D_inner+(2*clip_mat_t); // outer dimension
clip_E = 1.0+ (2*clip_mat_t); // outer dimension
clip_w = (mag_w - 2*lip_w) *2/3;
clip_m_w = clip_w + 0.25;

clip_irle_offs = 0.25; // offset from center of eye to edge of clip

clip_x = floor_w/2 - clip_w/2;
clip_y = irl_y + irle_m_x + clip_irle_offs;
clip_z = mag_h + mag_pos_z;

wl_y = clip_y - mag_d - lev_d;

// pivot_gap_depth
pg_d = lbs_y - wl_y - lev_d - csg_utol;
pg_h = pivot_r * 1.5;
pg_w = opening_w;

pg_y = lbs_y - pg_d + csg_utol;
pg_x = lbs_x;
pg_z = lbs_z;

//
// end of dimensioning of little clips which attract the magnets.
//
//*****************************************************************************
//*****************************************************************************
//
// Start of dimensioning of wall which holds clips.
//

// clip support wall bulge (supports clip)
cswb_d = clip_D_inner;
cswb_w = clip_w;
cswb_h = clip_A;

// clip support wall
csw_d = min_wall;
csw_w = opening_w;
csw_h = clip_A + clip_mat_t;
// special keeper function of csw for preventing lowlev getting out of place.
// extend csw down to bottom of 5-key.
csw_k_h = clip_z + clip_mat_t;

cswb_x = clip_x;
cswb_y = clip_y + clip_mat_t;
cswb_z = clip_z - cswb_h;

csw_x = sw_w;
csw_y = cswb_y + cswb_d - csw_d;
csw_z = clip_z - csw_h + clip_mat_t;

// clip support wall clearance
cswc_d = cswb_d + csg_tol;
cswc_w = clip_m_w;
cswc_h = clip_mat_t;

cswc_x = clip_x + clip_w/2 - clip_m_w/2;
cswc_y = clip_y + clip_mat_t;
cswc_z = clip_z;

// clip lock void wall
clvw_d = min_wall + clip_E; // only 1 min_wall, use back of csw.
clvw_w = clip_m_w + 2*min_wall;
// look for the definitions of the clvw_h and related parameters
// after the stem position is defined - needs to match up to the
// top of the stem support walls to support/stop the center button,
// so can't be defined until there.

clvw_x = floor_w/2 - clvw_w/2;
clvw_y = clip_y + clip_D - clip_mat_t;
//clvw_z = clip_z - clip_B - clip_mat_t + clip_C/2 - clvw_h/2;
clvw_z = clip_z - clip_B - 3.5*clip_mat_t - min_wall/2;

clv_d = clip_E;
clv_w = clip_m_w;

clv_x = floor_w/2 - clv_w/2;
clv_y = clvw_y;

//
// end of dimensioning of wall which holds clips.
//
//*****************************************************************************
//*****************************************************************************
//
// Start of dimensioning of lower lever for center pushbutton.
//

llev_h = floor_w - 2*min_wall + (sw_d - lbs_y - min_wall) + (sw_d - csw_y - min_wall) - pivot_r - ptp_clearance;
lclip_h = (min_wire) + mag_h + proc_tol;
llevhole_h = min_sep + lclip_h - 2*min_wire;
llevhole_pos_z = llev_h - llevhole_h - 3*min_wire;
// put mag at top of lever, leaving room for bridge and keeper bump.
lmag_pos_z = llev_h - min_wire - mag_h;
llip_pos_z = lmag_pos_z;
lclip_pos_z = llev_h - lclip_h - min_wire;
lstop_pos_z = llev_h - min_wire;
// locate the keeper bump which hold magnet at bottom
lkeeper_pos_z = lmag_pos_z - min_wire - proc_tol;
lbump_pos_z = lmag_pos_z + mag_h - bump_r + min_wire;
llanv_oh = 0.5; // overhang of lowlev anvil to ensure it does not jam
llanv_h = clvw_w + llanv_oh;
llanv_x = 0;
llsw_x = 0;
llip_pos_x = llsw_x + min_wall;

//
// end of dimensioning of lower lever for center pushbutton.
//
//*****************************************************************************
//*****************************************************************************
//
// Start of dimensioning of center pushbutton IRLED holders.
//

cpil_x = irl_x;
cpil_y = irl_y + floor_w - min_wall;
cpil_z = -min_wall;

cpilh_w = irlb_m_d + 2*min_wall;
cpilh_d = irlb_m_w + 2*min_wall;
cpilh_h = irlb_m_h + min_wall;

cpilh_x = 0;
cpilh_y = cpil_y - min_wall;
cpilh_z = cpil_z;

// dimensions for the cylinder which will cut the slot for the eye to slide up
cpilhs_x = min_wall + irlb_m_d;
cpilhs_y = irle_m_x + cpil_y;
cpilhs_z = cpil_z;

//
// end of dimensioning of center pushbutton IRLED holders.
//
//*****************************************************************************
//*****************************************************************************
//
// Start of dimensioning of center pushbutton lever.
//

// magnet height should be at top of opening in nylon housing for ir eye.
// the top of this opening is sqrt(irle_m_r^2 - minwall^2) above eye center.

// center pushbutton magnet top surface z value
cpmts_z = cpil_z + irle_m_z + sqrt(irle_m_r*irle_m_r - min_wall*min_wall);
cpm_z = cpmts_z - mag_d;
// center pushbutton lever z position
cpl_z = cpm_z - lev_d;

cpl_catch_z = cpl_z - (catch_h / (tan(acos(cpl_z/llev_h)))) - catch_d;

//
// End of dimensioning of center pushbutton lever.
//
//*****************************************************************************

// center button bottom surface height
// look for cb_z after stem travel has been established.
cb_x = floor_w/2;
cb_y = sw_d + floor_w/2 - min_wall;
// original center buttons are approximately 0.6 inches in diameter.
cb_r = 0.6/2.0 * in2mm;
// apparent thickness is about 0.15 inches.
cb_h = 0.15 * in2mm;
// center button spherical depression radius
cbsd_r = cb_r * 5 / 3;
cbsdr_z = cbsd_r + (cb_h * 2 / 3);


//*****************************************************************************
//
// Start of dimensioning for ferrous clip for center button
//

// Clip #2 (for center button)
//
//   C             C
// ------       ------
//     B|       |B
//      ---------
//          A
//

clip2_A = opening_w - clip_inn_r;
clip2_B = (cpilh_h + cpilh_z) - (cpl_z + lev_d + mag_d); 
clip2_oal = floor_w - 2*min_wall - 2*proc_tol;
clip2_C = (clip2_oal - clip2_A)/2 + clip_mat_t;

clip2_w = clip_w;

clip2_C1_x = proc_tol;
clip2_B1_x = clip2_C1_x + clip2_C - clip_mat_t;
clip2_A_x = clip2_B1_x + clip_bend_h;
clip2_B2_x = clip2_A_x + clip2_A - clip_mat_t - clip_bend_h;
clip2_C2_x = clip2_B2_x + clip_bend_h;

clip2_x = min_wall;
// look for clip2_y after center button side wall is located
clip2_z = cpl_z + lev_d + mag_d;

clip2_ret_d = proc_min_wire;
clip2_ret_h = proc_min_wire;
clip2_ret_w = floor_w/2 - min_wall - clvw_w/2 - proc_min_sep;

// look for clip2_ret_y after chock is located
// clip2_ret_y = clip2_y + clip2_w - proc_min_sep - clip2_ret_d;

// rotate the retaining clips such that the free tips are
// a full retainer width into the space of the chock, while
// they are located 1/2 of their width away from the edge
// of the chock 
clip2_ret_zrot = asin( (clip2_ret_d * 1.5) / clip2_ret_w );

// drop the tip to be it's full diameter below the root
clip2_ret_yrot = asin( clip2_ret_h / clip2_ret_w ); 

// since the retainer is rotated, the back end pulls out of
// the supporting wall and needs to be extended to rejoin it.
// the length of that extension is:
clip2_ret_w_ex = ( tan(clip2_ret_zrot) * clip2_ret_d ) + ( tan(clip2_ret_yrot) * clip2_ret_h ) + csg_tol;

// retaining bump height under retainer for clip
clip2_rbh = 0.4;
clip2_rb_r = ((clip2_rbh*clip2_rbh) + ((clip2_ret_d/2)*(clip2_ret_d/2)))/(2*clip2_rbh);
clip2_rb_len = min_wire;
clip2_rb_x = cpilh_x + min_wall + min_sep;

// look for clip2_ret_z after clvw_h is defined.

// clip2 relief hole - clearance under retaining bump to help fabrication and
// to improve clearance of unsintered material. Also allows for min_sep from
// center pushbutton IRLED holder.
clip2_rh_w = clip2_rb_len;
clip2_rh_d = clip2_ret_d;
clip2_rh_h = min_wall;

clip2_rh_x = clip2_rb_x;


//
// End of dimensioning for ferrous clip for center button
//
//*****************************************************************************
//*****************************************************************************
//
// Start of dimensioning for stem for center button hammer
//

stem_w = clvw_w;
// stem_d = clip_w + 0.8;
stem_d = stem_w;
// needed vertical travel of llev at eye to clear whole eye
ntll_v = min_wall + 2*irle_r;
// distance from pivot to lower IR eye
ntlll_y = cpil_y + irle_x - (lbs_y + lbs_d);
// angle of llev at needed travel -- assuming pivot in place
ntll_a = atan(ntll_v / ntlll_y);

anvil_ts_z = cpmts_z + min_wall;

stem_x = floor_w/2 - stem_w/2;
stem_y = sw_d + (floor_w - 2*min_wall)/2 - stem_d/2;
stem_z = anvil_ts_z;

// stem spine to reduce friction
// the width of the spine / rib is the y dimension for construction
ss_w = min_wall; // stop shapeways from complaining about too-small size.
ss_d = min_detail;

sbrb_w = stem_w + 2*min_sep + 2*csg_tol;
sbrc_w = sbrb_w + 2*csg_tol;

// distance from pivot to center of stem
ntll_d = stem_y + stem_d/2 - lbs_y - lbs_d;

// stem vertical travel -- less that ntll_v because it is at center of lever
stem_t = (tan(ntll_a) * ntll_d) + 2*proc_tol;
cb_z = sw_h + sw_z + swcap_h + stem_t;
stem_h = cb_z - stem_z;


//
// End of dimensioning for stem for center button hammer
//
//*****************************************************************************
//*****************************************************************************
//
// Start of dimensioning for support/guide for center pushbutton stem
//

cbsw_w = floor_w - 2*min_wall + 2*sw_d - 2*csw_y - 2*min_wall - 2*clvw_d;
cbsw_d = min_wall;
cbsw_h = stem_h - stem_t - proc_tol;

cbsw_x = floor_w/2 - cbsw_w/2;
cbsw_y = stem_y - cbsw_d;
cbsw_z = stem_z + proc_tol;
cbsw2_y = cbsw_y + cbsw_d + stem_d;

clip2_y = cbsw2_y + cbsw_d;

cbssw_w = min_wall;
cbssw_d = stem_d + proc_tol;
cbssw_h = cbsw_h - stem_d/2 - proc_tol;

cbssw_x = floor_w/2 - stem_w/2 - ss_d - cbssw_w;
cbssw_y = cbsw_y + cbsw_d;
cbssw_z = stem_z + stem_d/2 + 2*proc_tol;

// need to connect it to the outer perimiter now that stem is wider than clip.
cbsswc_w = min_wall;
cbsswc_d = cbssw_d - proc_tol + 2*cbsw_d;
cbsswc_h = cbsw_h;

cbsswc_x = cbsw_x-min_wall;
cbsswc_y = cbsw_y;
cbsswc_z = cbsw_z;

//
// End of dimensioning for support/guide for center pushbutton stem
//
//*****************************************************************************

// the 4*clip_mat_t is slop - allowing a stackup of things to be off and work.
clvw_h = cbsw_z + cbsw_h - clvw_z;

clv_h = clvw_h;
clv_z = clvw_z + clvw_h - clv_h;

clip2_ret_z = clvw_z + clvw_h - (clip2_ret_h * 1.5) ;

clip2_chock_d = cbsw_y - clvw_y - clvw_d;
clip2_chock_w = floor_w - 2 * min_wall - 2 * proc_tol;
clip2_chock_h = clvw_z + clvw_h - cpilh_h - cpilh_z - clip2_mat_t - 1.5*clip2_ret_h;

clip2_chock_x = min_wall + proc_tol;
clip2_chock_y = cbsw_y + stem_d + 2*min_wall;
clip2_chock_z = cpilh_h + cpilh_z + clip2_mat_t;
// separation during printing
chock_y_psep = clip2_chock_d + 2*min_sep;
chock_z_psep = clip2_chock_h + 2*min_sep;

clip2_ret_y = clip2_chock_y + clip2_chock_d;


carrier_oaw = 2*sw_d - 2*min_wall + floor_w;
ctc_d_irtx2rx = floor_w - 2*min_wall - irlb_m_d;
hole_pattern_oaw = carrier_oaw - 2*min_wall - 2*irlcath_m_x + irll_m_w;


// hole positions for irLEDs.
/*
   A  C
   9  B
7 8I  KD E 
   H  J
5 6    F G
   2  4
   1  3
*/
// all relative to imaginary corner of carrier
h01_x = sw_d + irll_m_y + irll_m_d/2;
h01_y = min_wall + irlb_m_w/2 - irll_spacing_x/2;
h02_x = h01_x;
h02_y = h01_y + irll_spacing_x;
h03_x = h01_x + ctc_d_irtx2rx;
h03_y = h01_y;
h04_x = h03_x;
h04_y = h02_y;

h05_x = h01_y;
h05_y = h01_x;
h06_x = h05_x + irll_spacing_x;
h06_y = h05_y;
h07_x = h05_x;
h07_y = h05_y + ctc_d_irtx2rx;
h08_x = h06_x;
h08_y = h07_y;

h09_x = h01_x;
h09_y = carrier_oaw - h02_y;
h0A_x = h09_x;
h0A_y = carrier_oaw - h01_y;
h0B_x = h03_x;
h0B_y = h09_y;
h0C_x = h0B_x;
h0C_y = h0A_y;

h0D_x = carrier_oaw - h08_x;
h0D_y = h08_y;
h0E_x = carrier_oaw - h07_x;
h0E_y = h0D_y;
h0F_x = h0D_x;
h0F_y = h05_y;
h0G_x = h0E_x;
h0G_y = h0F_y;

h0H_x = h01_x;
h0H_y = h09_y - sw_d + min_wall;
h0I_x = h0H_x;
h0I_y = h0A_y - sw_d + min_wall;
h0J_x = h03_x;
h0J_y = h0H_y;
h0K_x = h0J_x;
h0K_y = h0I_y;

pinkie_riser = 3;

// dimensioning of key-stop
ks_wall_t = 2.0;
ks_flange_w = 4.0;
ks_inn_gap = 1.0; // gap between corners of carrier and key stop.
ks_inn_r = sqrt(carrier_oaw * carrier_oaw + floor_w * floor_w)/2 + ks_inn_gap;
ks_out_r = ks_inn_r + ks_wall_t;
ks_fla_r = ks_out_r + ks_flange_w;
ks_norm_h = 15;
ks_pink_h = ks_norm_h + pinkie_riser; // pinkie finger lifted up a bit higher
// 0.25 inch long #2 screw
ks_screw_od = 0.086 * in2mm;
ks_screw_id = ks_screw_od * 0.75;
ks_screw_hd = 0.167 * in2mm;
ks_screw_ro = ks_screw_hd/2; // radial offset from ks_out_r for hole location

// locations and rotations of left hand carriers
// index finger
lh_i_a = (-17.6+180.0);
lh_i_x = 0;
lh_i_y = 0;
lh_i_sty = lh_i_y + ks_out_r + ks_screw_ro;
lh_i_sby = lh_i_y - ks_out_r - ks_screw_ro;

// middle finger
lh_m_a = (-4.1+180.0);
lh_m_x = in2mm*(-1.095);
lh_m_y = in2mm*(0.225);
lh_m_sty = lh_m_y + ks_out_r + ks_screw_ro;
lh_m_sby = lh_m_y - ks_out_r - ks_screw_ro;

// ring finger
lh_r_a = 21.1+180.0;
lh_r_x = in2mm*(-2.138);
lh_r_y = in2mm*(-0.086);
lh_r_sty = lh_r_y + ks_out_r + ks_screw_ro;
lh_r_sby = lh_r_y - ks_out_r - ks_screw_ro;

// pinkie finger
lh_p_a = 33.0+180.0;
lh_p_x = in2mm*(-3.010);
lh_p_y = in2mm*(-0.760);
lh_p_sty = lh_p_y + ks_out_r + ks_screw_ro;
lh_p_sby = lh_p_y - ks_out_r - ks_screw_ro;

// key stop m3 mounting screw diameter
ks_m3ms_d = 3;
ks_m3mt_d = 6.8;
// m3 mounting locations
ks_m3ms_i_t_a = 55;
ks_m3ms_i_t_x = lh_i_x + (ks_out_r + 4)*cos(ks_m3ms_i_t_a);
ks_m3ms_i_t_y = lh_i_y + (ks_out_r + 4)*sin(ks_m3ms_i_t_a);
ks_m3ms_i_b_a = -125;
ks_m3ms_i_b_x = lh_i_x + (ks_out_r + 4)*cos(ks_m3ms_i_b_a);
ks_m3ms_i_b_y = lh_i_y + (ks_out_r + 4)*sin(ks_m3ms_i_b_a);
ks_m3ms_m_t_a = 55;
ks_m3ms_m_t_x = lh_m_x + (ks_out_r + 4)*cos(ks_m3ms_m_t_a);
ks_m3ms_m_t_y = lh_m_y + (ks_out_r + 4)*sin(ks_m3ms_m_t_a);
ks_m3ms_m_b_a = -115;
ks_m3ms_m_b_x = lh_m_x + (ks_out_r + 4)*cos(ks_m3ms_m_b_a);
ks_m3ms_m_b_y = lh_m_y + (ks_out_r + 4)*sin(ks_m3ms_m_b_a);
ks_m3ms_r_t_a = 130;
ks_m3ms_r_t_x = lh_r_x + (ks_out_r + 4)*cos(ks_m3ms_r_t_a);
ks_m3ms_r_t_y = lh_r_y + (ks_out_r + 4)*sin(ks_m3ms_r_t_a);
ks_m3ms_r_b_a = -95;
ks_m3ms_r_b_x = lh_r_x + (ks_out_r + 4)*cos(ks_m3ms_r_b_a);
ks_m3ms_r_b_y = lh_r_y + (ks_out_r + 4)*sin(ks_m3ms_r_b_a);
ks_m3ms_p_t_a = 125;
ks_m3ms_p_t_x = lh_p_x + (ks_out_r + 4)*cos(ks_m3ms_p_t_a);
ks_m3ms_p_t_y = lh_p_y + (ks_out_r + 4)*sin(ks_m3ms_p_t_a);
ks_m3ms_p_b_a = -125;
ks_m3ms_p_b_x = lh_p_x + (ks_out_r + 4)*cos(ks_m3ms_p_b_a);
ks_m3ms_p_b_y = lh_p_y + (ks_out_r + 4)*sin(ks_m3ms_p_b_a);





/* This is the start of dimensioning for the thumb switches */

/* Begin with dimensions of the moving part of the thumb switch
   The prefix for dimensions of this part will be trp (thumb rotating part)

                             +++
          Attachment post -> +++
          for "key cap"      +++
          a.k.a. spline      |||___ These two '0' limit motion/friction 
                             |    0\ 
       The 'O' is the hole   |0     \  
       through which the --> | O     \
       IR beam can pass      ----|    \
                             ----|____0 <-- the pivot
       The metal clip gets ^          
       attached at this __/                    
       corner                         

   The pivot should be stepped - with the shoulder locating the blade within
   the switch frame and the ends locking the blade into position. 
              
   Dimensions of the thumb switch frame need to be defined at the same time
   as the dimensions of the trp, as they are interrelated.
   The prefix for dimensions of the fram will be tf (thumb frame)

   the "key cap" will be printed separately as it will allow a significant
   reduction in bounding box volume for 3D printing.

*/

// big enough to hold up to thumb forces, small enough to avoid rotational
//   friction adding up to meaningful torque 
// the diameter of the pivot
trp_pivot_dia = 2.5;
// the radius of the pivot cylinder
trp_pivot_r = trp_pivot_dia / 2.0;

trp_blade_x = 0.0;
trp_blade_y = 0.0;
// thickness of the material in the body of the blade of the Thumb Rotating Part
trp_blade_t = 2.0;

// thumb rotating part clip lock void
trp_clv_d = clv_w;
trp_clv_h = clv_d;
trp_clv_w = clip_B + ( 2.0 * clip_mat_t );

trp_clv_x = trp_blade_x + ( trp_clv_w / 2.0 );
trp_clv_y = trp_blade_y + clip_D_inner + ( trp_clv_h / 2.0 );
trp_clv_z = 0.0;

// thumb rotating part clip lock walls (a solid from which the void is removed)
trp_clw_d = trp_clv_d + ( 2.0 * min_wall );
trp_clw_h = trp_clv_h + ( 2.0 * min_wall );
trp_clw_w = trp_clv_w;

trp_clw_x = trp_clv_x;
trp_clw_y = trp_clv_y;
trp_clw_z = trp_clv_z;

// trp clip lock cleanout void - opens bottom of lock void
trp_clcv_w = 2.0 * min_sep;
trp_clcv_h = trp_clv_h;
trp_clcv_d = trp_blade_t + csg_tol;

trp_clcv_x = trp_blade_x + trp_clw_w + ( trp_clcv_w / 2.0 );
trp_clcv_y = trp_clw_y;
trp_clcv_z = 0.0;

// constructed in plan view, so material thickness is depth
trp_blade_d = trp_blade_t;
trp_blade_w = 16.0;
trp_blade_h = 12.0;
// blade gets centered vertically around 0 so all other centers match.
trp_blade_z = ( -trp_blade_t / 2.0 );

// 0,0,0 is at the lower-left corner of the view above, mid-thickness
// locate the pivot (center of pivot)
trp_pivot_x = trp_blade_w - trp_pivot_r; // start with 2 centimeters
trp_pivot_y = trp_pivot_r;

// the angle of rotation which can be achieved must be such that the IR eye
// is more than covered and then goes to completely visible to the sensor.
// make it over-closed by one eye radius, then open to centered on hole.
// So, at the distance of the eye from the trp pivot axis, we need to see
// 150% eye diameter displacement given the target angle across a 110% window.
// use the max dimensions radius of the eye: irle_m_r
// eye sits irle_z plus minwall above base of irled body, minimum

// trp_irleh is hole through which beam passes when switch pressed
trp_irleh_r = 1.1 * irle_m_r;

// position of the hole through which the IR beam passes when switch pressed
trp_irleh_x = trp_blade_x + min_wall + trp_irleh_r;
trp_irleh_y = trp_clw_y + ( trp_clw_h / 2.0 ) + trp_irleh_r;

// IR LED Eye Position relate radius (radius of rotation pivot to eye)
trp_irlep_r = sqrt( (trp_pivot_x - trp_irleh_x) * (trp_pivot_x - trp_irleh_x) +
                    (trp_pivot_y - trp_irleh_y) * (trp_pivot_y - trp_irleh_y) );

// separation between resting position of eye, and resting position of hole
trp_irlehe_sep = trp_irleh_r + ( 2 * irle_m_r );

// angle between hole and resting position - rotating on pivot
// aka required angle of rotation for correct travel wrt eye
trp_irler_a = 2.0 * asin( ( trp_irlehe_sep / 2.0 ) / trp_irlep_r );

// angle from horizontal up to eye hole center
trp_irleh_a = asin( ( trp_irleh_y - trp_pivot_y ) / trp_irlep_r );

// room to move at top of blade to achieve ang rotation:
// r * sin(ang)
trp_blade_rotate_gap = ( trp_blade_h - trp_pivot_r ) * sin( trp_irler_a );

trp_blade_top_w = trp_blade_w - trp_blade_rotate_gap;

// the travel stop is the tstop
trp_tstop_r = trp_pivot_r;

// gap between trp and switch frame
trp_air_gap = 0.8;

// material thickness in thumb frame walls
tf_mat_t = 2.0;

// calculate positions of ir eyes. Thumb Frame (tf) will be done with z as
// up rather than the way I did the blade. The way I did the blade is making
// me just a little nuts.
tf_irle_x = trp_pivot_x - trp_irlep_r * cos( trp_irleh_a + trp_irler_a );
tf_irle_z = trp_pivot_y + trp_irlep_r * sin( trp_irleh_a + trp_irler_a );
tf_irle_y = trp_blade_t/2.0 + trp_air_gap + sw_eye_wall_w + ( proc_tol / 2.0 );

// total pivot height accounts for the extensions through the air gap and frame
// thickness on both sides of the trp blade
trp_pivot_h = 2.0 * ( tf_mat_t + trp_air_gap ) + trp_blade_t; 

// z-position of the pivot cylinder - centered on blade
trp_pivot_z = 0;

// shoulder of pivot must be partial - just where it is within the plan of the
// blade. Should be able to do an intersection, then a linear extrusion to get
// correct shape. pivot shoulder prefix is trp_ps_
trp_ps_r = trp_pivot_r + 1.0;
// will be located at the same position as the pivot.
// shoulder will mostly fill the air gap:
trp_ps_h = trp_blade_t + ( 2.0 * trp_air_gap ) - proc_tol;
trp_ps_scale = trp_ps_h / trp_blade_t;
trp_ps_x = trp_pivot_x;
trp_ps_y = trp_pivot_y;
trp_ps_z = 0;

// blade shape will be triangular (sortof), with two corners removed. One 
// corner cut needs to match the funny angle between the two points where 
// the side and bottom edges meet the pivot. The other is square and on the
// top where the spline for "keycap" attachment will be.
//
// coordinates of the points below, clockwise around face, then back:
// calculating the point tangent for point [3]...

// point tanget to pivot cylinder calculations:
trp_tp_dx = trp_pivot_x - trp_blade_top_w;
trp_tp_dy = trp_pivot_y - trp_blade_h;
trp_tp_hyp = sqrt( ( trp_tp_dx * trp_tp_dx ) + ( trp_tp_dy * trp_tp_dy ) );
trp_tp_alpha = acos( trp_tp_dx / trp_tp_hyp );
trp_tp_beta = acos( trp_pivot_r / trp_tp_hyp );
trp_tp_ohmega = 180 - trp_tp_alpha - trp_tp_beta;
trp_blade_ph_p3_x = trp_pivot_x + trp_pivot_r * cos( trp_tp_ohmega );
trp_blade_ph_p3_y = trp_pivot_y + trp_pivot_r * sin( trp_tp_ohmega );

trp_spline_h = 8.0;
trp_spline_w = 6.0;
trp_spline_t = trp_blade_t;
trp_spline_x = trp_blade_x + ( trp_blade_w / 2.0 ) - ( trp_spline_w / 2.0 );
trp_spline_y = trp_blade_h;
trp_spline_z = trp_blade_z;

// void to allow keycap to snap onto spline
trp_sv_w = trp_spline_t;
trp_sv_h = trp_spline_t + csg_tol;
trp_sv_d = trp_spline_t;

// height of material between top of trp_sv and top of spline
// i.e. the bridge of material above the spline void
trp_svb_h = trp_spline_t;

// trp is constructed in plan view just to confuse. X==X, but z <-> y 
// this was a mistake that should be corrected eventually, but which I
// will presently just suffer through.
trp_sv_z = trp_spline_z - ( csg_tol / 2.0 );
trp_sv_y = trp_spline_y + trp_spline_h - trp_sv_d - trp_svb_h;
trp_sv_x = trp_spline_x + ( trp_spline_w / 2.0 ) - ( trp_sv_w / 2.0 );


// maximum lever length to pivot
trp_max_ll = sqrt( ( trp_spline_h + trp_blade_h ) 
                   * ( trp_spline_h + trp_blade_h )
                   + ( trp_blade_w - trp_pivot_r )
                   * ( trp_blade_w - trp_pivot_r ) );

trp_max_trv = 2 * trp_max_ll * sin ( trp_irler_a / 2.0 );

trp_blade_pointarr = [[0, 0, 0], 
		      [0, trp_blade_h, 0], 
		      [trp_blade_top_w, trp_blade_h, 0],
		      [trp_blade_ph_p3_x, trp_blade_ph_p3_y, 0],
		      [trp_blade_w-trp_pivot_r, 0, 0],
		      [0, 0, trp_blade_d], 
		      [0, trp_blade_h, trp_blade_d], 
		      [trp_blade_top_w, trp_blade_h, trp_blade_d],
		      [trp_blade_ph_p3_x, trp_blade_ph_p3_y, trp_blade_d],
		      [trp_blade_w-trp_pivot_r, 0, trp_blade_d]];

trp_blade_facetarr = [[0, 2, 1], // back 3 facets
		      [0, 3, 2],
		      [0, 4, 3],
		      [0, 5, 4], // bottom 2 facets
		      [5, 9, 4],
		      [0, 6, 5], // left facets
		      [0, 1, 6],
		      [1, 7, 6], // top faces
		      [1, 2, 7],
		      [2, 8, 7], // angle-right facets
		      [2, 3, 8],
		      [3, 9, 8], // right facets
		      [3, 4, 9],
		      [5, 8, 9], // front 3 facets
		      [5, 7, 8],
		      [5, 6, 7]];

// travel stop for the blade needs to be towards the top of the blade to 
// maximize the length of the lever, and thus minimize the forces upon it.

trp_tstop_y = 0.85 * trp_blade_h;
trp_angleface_angle = atan( ( trp_blade_h - trp_blade_ph_p3_y ) / 
                            ( trp_blade_ph_p3_x - trp_blade_top_w ) );

// now calculate horizontal location of the travel stop:
// line equation for angled side: y=mx+b, x = (y - b)/m
trp_angleside_m = ( trp_blade_ph_p3_y - trp_blade_h ) / 
                  ( trp_blade_ph_p3_x - trp_blade_top_w ) ;
trp_angleside_b = trp_blade_h - ( trp_angleside_m * trp_blade_top_w ) ;

// x position at trp_tstop_y height on edge line (intersection of horizontal):
trp_tstop_x_int = ( trp_tstop_y - trp_angleside_b ) / trp_angleside_m;

// position of tstop, x component
// this would be tangent with right edge:
// trp_tstop_x = trp_tstop_x_int - ( trp_tstop_r / sin( trp_angleface_angle ) );
// back away from that to avoid catching on slot for pivot insertion
trp_tstop_x = trp_tstop_x_int - 
            ( trp_tstop_r / sin( trp_angleface_angle ) ) - trp_tstop_r;

trp_tstop_h = trp_blade_t + ( 2 * trp_air_gap ) - proc_tol;

trp_tstop_z = 0;

// travel stop #2 (also, not actually a travel stop, just a stabilizer)
trp_ts2_r = trp_tstop_r;
trp_ts2_x = 2.0 * trp_tstop_r;
trp_ts2_y = trp_tstop_y;
trp_ts2_z = 0.0;
trp_ts2_h = trp_tstop_h;

// all about the frame for the 4-per-side thumb switch

// thumb frame irled holder box
tf_irlhb_d = min_wall + irlb_m_d + sw_eye_wall_w;
tf_irlhb_w = irlb_m_w + ( 2.0 * min_wall );
tf_irlhb_h = irlb_m_h + min_wall;

// make the thing line up with the eye at the origin
tf_irlhb_x = ( -tf_irlhb_w / 2.0 );
//tf_irlhb_y = ( -tf_irlhb_d / 2.0 ) + ( irlb_m_d / 2.0 ) - sw_eye_wall_w;
tf_irlhb_y = -sw_eye_wall_w;
tf_irlhb_z = -irle_m_z - min_wall;

// the half-cap for on top of the holder box - shield front of device from light
tf_irlhbc_w = tf_irlhb_w;
tf_irlhbc_d = sw_eye_wall_w + ( irlb_m_d / 2.0 );
tf_irlhbc_h = min_wall;

tf_irlhbc_x = tf_irlhb_x;
tf_irlhbc_y = tf_irlhb_y;
tf_irlhbc_z = tf_irlhb_z + tf_irlhb_h;

tf_irlhb_outer_edge_x = tf_irle_x - ( tf_irlhb_w / 2.0 );

// the lever cutout - applies to each side of back of holder to make lever
tf_lc_w = min_sep;
tf_lc_d = min_wall;
tf_lc_h = irlb_m_h + csg_tol;

tf_lc_x = tf_irlhb_x + min_wall;
tf_lc_y = tf_irlhb_y + tf_irlhb_d - min_wall;
tf_lc_z = tf_irlhb_z + min_wall;
// position of the second lever cutout
tf_lc2_x = tf_irlhb_x + tf_irlhb_w - min_wall - tf_lc_w;
tf_lc2_y = tf_lc_y;
tf_lc2_z = tf_lc_z;

// bump on inside of lever for retaining irled:
tf_irlrb_r = irltol*1.5;
tf_irlrb_x = 0;
tf_irlrb_y = irlb_m_d;
tf_irlrb_z = 0;

// thumb frame backstop
tf_bs_w = tf_mat_t;
tf_bs_d = trp_blade_t + ( 2.0 * ( trp_air_gap + tf_mat_t )) + proc_tol;
tf_bs_h = trp_blade_h;

tf_bs_x = trp_blade_w + proc_tol;
tf_bs_y = -tf_bs_d / 2.0;
tf_bs_z = 0;

// thumb frame upper wall
tf_uw_x = tf_irlhb_outer_edge_x;
tf_uw_y = ( trp_blade_t / 2.0 ) + trp_air_gap + ( proc_tol / 2.0 );
tf_uw_z = tf_irle_z + ( irlb_m_h - irle_m_z ) + ( tf_irlhbc_h / 2.0 );

tf_uw_w = tf_bs_x - ( 2.0 * trp_pivot_r ) - proc_tol - tf_irlhb_outer_edge_x;
tf_uw_d = tf_mat_t;
tf_uw_h = tf_bs_h - tf_uw_z;

// thumb frame lower wall
tf_lw_x = tf_irlhb_outer_edge_x + tf_irlhb_w - ( min_wall / 2.0 );
tf_lw_y = tf_uw_y;
tf_lw_z = 0;

tf_lw_w = tf_irlhb_outer_edge_x + tf_uw_w - tf_lw_x;
tf_lw_d = tf_mat_t;
tf_lw_h = tf_uw_z + csg_tol;

// thumb frame attachment screw dimensions
// head
tf_ash_d = 0.167 * in2mm;
tf_ash_r = tf_ash_d / 2.0;
tf_ash_h = 0.062 * in2mm;
// shaft
tf_ass_od = 0.086 * in2mm;
tf_ass_h = 0.25 * in2mm;

// thumb frame screw positions - three screws. one central at back, two
// at either side of front
tf_sp1_x = tf_bs_x + tf_bs_w + ( tf_ash_r * 1.1 );
tf_sp1_y = 0;
tf_sp1_z = 0;

tf_sp2_x = tf_ash_r * 1.1 + tf_uw_x;
tf_sp2_y = tf_ash_r * 1.1 + tf_uw_y + tf_irlhb_d;
tf_sp2_z = 0;

tf_sp3_x = tf_sp2_x;
tf_sp3_y = -tf_sp2_y;
tf_sp3_z = tf_sp2_z;

// dimensions of magnet to use for thumb frame
tf_mag_d = smag_d;
tf_mag_w = smag_w;
tf_mag_h = smag_h;

// dimensions of tf bottom plate
tf_bp_w = tf_sp1_x + ( tf_ash_r * 1.1 ) - tf_uw_x;
tf_bp_d = tf_sp2_y - tf_sp3_y + ( tf_ash_d * 1.1 );
tf_bp_h = clip_mat_t + tf_mag_d + proc_tol ;
tf_bp_x = tf_uw_x;
tf_bp_y = -tf_bp_d / 2.0;
tf_bp_z = -tf_bp_h;

// position of solder relief cones:
tf_irle_scz = tf_irle_z - irle_z + tf_bp_h;

// side support dimensions
tf_ss_h = tf_bs_h;
tf_ss_t = tf_mat_t;
tf_ss_w = (tf_bp_d / 2.0 ) - ( tf_uw_y + tf_uw_d );

tf_ss_x = tf_uw_x + tf_irlhb_w + tf_ss_t - min_wall / 2.0;
tf_ss_y = tf_uw_y + tf_uw_d;
tf_ss_z = 0;

// tf lower low wall dimensions
tf_llw_x = tf_uw_x;
tf_llw_y = tf_uw_y;
tf_llw_z = 0;

tf_llw_w = tf_irlhb_w;
tf_llw_d = tf_mat_t;
tf_llw_h = tf_irle_z - irle_z - ( min_wall / 2.0 );

tf_bpc_w = tf_bp_w - ( tf_irlhb_w - ( min_wall / 2.0 ) + tf_ss_t ) + csg_tol;
tf_bpc_h = tf_bp_h + ( 2.0 * csg_tol );
tf_bpc_d = ( tf_bp_d / 2.0 ) - ( tf_ash_r * 1.1 ) + csg_tol;

tf_bpc_x = tf_bp_x + tf_bp_w + csg_tol;
tf_bpc_y = ( tf_bp_d / 2.0 ) + csg_tol;
tf_bpc_z = -tf_bpc_h + csg_tol;

// thumb frame outer upper wall
tf_ouw_x = tf_uw_x + tf_uw_w - tf_mat_t;
tf_ouw_y = tf_uw_y + tf_mat_t - csg_tol;
tf_ouw_z = tf_uw_z;

tf_ouw_w = tf_bs_x + tf_bs_w - tf_uw_x - tf_uw_w + tf_mat_t;
tf_ouw_d = tf_uw_d;
tf_ouw_h = tf_uw_h;

// dimensions of the catch which captures the trp in the tf
tf_catch_w = trp_pivot_dia + proc_tol - ( 2.0 * min_sep );
tf_catch_h = tf_ouw_z - trp_pivot_dia - proc_tol;
tf_catch_d = tf_mat_t;

tf_catch_x = tf_ouw_x + tf_mat_t + min_sep;
tf_catch_y = tf_ouw_y;
tf_catch_z = tf_ouw_z;

tf_catch_a = atan( tf_catch_d / tf_catch_h );
tf_catch_a2 = atan( ( 0.5 * tf_catch_d ) / tf_catch_h );

// thumb frame lead positions relative to wide edge of baseplate
// these are the positions of the centers of the leads:
tf_lead1_x = tf_irle_x - tf_bp_x - irle_m_x + irlb_m_w/2 - irll_spacing_x/2;
tf_lead2_x = tf_lead1_x + irll_spacing_x;
tf_lead3_x = tf_lead1_x;
tf_lead4_x = tf_lead2_x;

tf_lead_y = tf_irle_y + irll_m_y + ( irll_m_d / 2.0) - irle_m_y;

// dimensions for the base of a keycap which engages the spline
// KeyCapBase == kcb prefix
// constructed in normal orientation to avoid stupid trp confusion.

// the void in the kcb which the spline fills
kcb_v_w = trp_spline_w + proc_tol;
kcb_v_d = trp_spline_t + proc_tol;
kcb_v_h = trp_spline_h - ( 2.0 * proc_tol );

kcb_v_x = 0;
kcb_v_y = 0;
kcb_v_z = ( kcb_v_h / 2.0 );

// the outer block/body of the kcb
kcb_mat_t = tf_mat_t;
kcb_w = kcb_v_w + ( 2.0 * kcb_mat_t );
kcb_d = kcb_v_d + ( 2.0 * kcb_mat_t );
kcb_h = kcb_v_h + kcb_mat_t;

kcb_x = 0;
kcb_y = 0;
kcb_z = ( kcb_h / 2.0 );

// the lock clip that will hold the cap onto the spline
kcb_lc_w = trp_sv_w - proc_tol;
kcb_lc_d = kcb_mat_t;
kcb_lc_h = kcb_v_h - min_wire - trp_svb_h - proc_tol;

kcb_lc_x = 0;
kcb_lc_y = ( kcb_lc_d / 2.0 ) - ( kcb_v_d / 2.0 ) - kcb_mat_t;
kcb_lc_z = ( kcb_lc_h / 2.0 ) + min_wire;

// the hole that the lock clip will go into:
kcb_lch_w = kcb_lc_w + ( 2.0 * min_sep );
kcb_lch_d = kcb_mat_t + ( 3.0 * csg_tol );
kcb_lch_h = kcb_lc_h + min_sep;

kcb_lch_x = 0;
kcb_lch_y = kcb_lc_y - csg_tol ;
kcb_lch_z = ( kcb_lch_h / 2.0 ) + min_wire;

// the locking bump
kcb_lb_w = kcb_lc_w;
kcb_lb_d = trp_blade_t / 2.0;
kcb_lb_h = (trp_sv_d - proc_tol) / 2.0;

kcb_lb_x = kcb_lc_x;
kcb_lb_y = ( kcb_lb_d / 2.0 ) + kcb_lc_y + ( kcb_lc_d / 2.0 ) - csg_tol;
kcb_lb_z = ( kcb_lb_h / 2.0 ) + min_wire + kcb_lc_h - kcb_lb_h;
//kcb_lb_z = -2;

// the ramp up to the locking bump
kcb_lbr_w = kcb_lb_w;
kcb_lbr_d = kcb_lb_d;
kcb_lbr_h = kcb_lb_h;

kcb_lbr_x = kcb_lb_x;
kcb_lbr_y = - ( kcb_v_d / 2.0 ) - csg_tol ;
kcb_lbr_z = min_wire + kcb_lc_h - kcb_lb_h + csg_utol;

//
//
//  Dimensions for the thumb, down, double-switch assembly
//  ( module prefix == tdds )
//

tdds_mat_t = 2;

// the bar which moves inside the tdds

tdds_bar_w = clip_m_w + ( 2 * tdds_mat_t );
tdds_bar_l = 30;
tdds_bar_h = clip_E + min_wall + tdds_mat_t;
tdds_bar_x = 0;
tdds_bar_y = 0;
tdds_bar_z = 0;

// the central void in the bar which captures the clips

tdds_cbv_w = clip_m_w;
tdds_cbv_l = 30 + ( 2.0 * csg_tol );
tdds_cbv_h = clip_E;
tdds_cbv_x = tdds_mat_t;
tdds_cbv_y = -csg_tol;
tdds_cbv_z = tdds_mat_t;

// the subtractor which leaves the upper end of the tube open to allow overlap
// for the optical gate.

tdds_sub_w = tdds_cbv_w;
tdds_sub_l = irlb_m_w + csg_tol;
tdds_sub_h = tdds_bar_h + ( 2.0 * csg_tol );
tdds_sub_x = tdds_mat_t;
tdds_sub_y = -csg_tol;
tdds_sub_z = -csg_tol;

tdds_sub2_x = tdds_sub_x;
tdds_sub2_y = tdds_bar_l - tdds_sub_l + csg_tol;
tdds_sub2_z = tdds_sub_z;

// position of the clips if they should be shown
tdds_clip_x = clip_w + tdds_mat_t + (( clip_m_w - clip_w ) / 2.0 );
tdds_clip_y = tdds_sub_l - csg_tol;
tdds_clip_z = tdds_bar_h;

tdds_clip_c_y = -tdds_bar_l/2.0 + irlb_m_w;

// the bar needs to be able to rotate far enough to clear the eye.
// the center of the eye will be located 2 eye radius from the top of the bar
// at its resting position.  The bar will need to be able to rotate down 3
// eye radii at the position of the eye.
// The rotation will be off of the end of the bar, therefore the radius of
// rotation is:

tdds_rot_r = tdds_bar_l - irle_x;
tdds_rot_z = 3.0 * irle_m_r;
tdds_rot_a = asin( tdds_rot_z / tdds_rot_r );
tdds_rot_l = sqrt(( tdds_bar_l * tdds_bar_l ) + ( tdds_bar_h * tdds_bar_h ));
tdds_rot_h = tdds_rot_l * sin( tdds_rot_a );

// the hole in which the bar moves
tdds_bh_w = tdds_bar_w + ( 2.0 * proc_tol );
tdds_bh_l = tdds_rot_l + ( 2.0 * proc_tol );
tdds_bh_h = tdds_bar_h + tdds_rot_h;

// the walls within which the bar moves
tdds_box_w = tdds_bh_w + ( 2.0 * tdds_mat_t );
tdds_box_l = tdds_bh_l + ( 2.0 * tdds_mat_t );
tdds_box_h = tdds_bh_h + tdds_mat_t; // no need for a bottom. The PCB will do.

tdds_box_x = -tdds_mat_t - proc_tol;
tdds_box_y = -tdds_mat_t - proc_tol;
tdds_box_z = -tdds_rot_h;

tdds_box_c_z = -tdds_box_h/2.0 + tdds_bar_h + tdds_mat_t;

tdds_bh_x = -proc_tol;
tdds_bh_y = -proc_tol;
tdds_bh_z = tdds_box_z - csg_tol;

tdds_irle_z = tdds_bar_h - ( 2.0 * irle_m_r );
tdds_irl_z = tdds_irle_z - irle_m_z;

// location and size of the window through which the bar is pressed by the key
tdds_ah_w = tdds_bar_w;
tdds_ah_l = tdds_bar_w;
tdds_ah_h = 2 * tdds_mat_t;

tdds_ah_x = 0;
tdds_ah_y = ( tdds_ah_l / 2.0 ) - ( tdds_bar_l / 2.0 ) + tdds_sub_l + clip_A;
tdds_ah_z = tdds_bar_h + ( tdds_mat_t / 2.0 ) ;

// magnet slide path
tdds_msp_w = smag_w + proc_tol;
tdds_msp_l = ( smag_h * 2.0 ) + proc_tol;
tdds_msp_h = smag_d + proc_tol;

tdds_msp_x = 0;
tdds_msp_y = tdds_clip_c_y;
tdds_msp_z = tdds_bar_h + min_wall + ( tdds_msp_h / 2.0 );

// magnet position
tdds_mag_x = -( smag_w / 2.0 ) + tdds_bar_w / 2.0;
tdds_mag_y = tdds_clip_y;
tdds_mag_c_z = tdds_msp_z - tdds_msp_h / 2.0 + smag_d / 2.0;

// clip to magnet slit
tdds_cms_w = clip_m_w + proc_tol;
tdds_cms_l = clip_A + clip_mat_t + proc_tol + csg_tol;
tdds_cms_h = min_wall + ( 2.0 * csg_tol );

tdds_cms_x = 0;
tdds_cms_y = tdds_clip_c_y - clip_mat_t - proc_tol + ( tdds_cms_l / 2.0 );
tdds_cms_z = tdds_bar_h - csg_tol + ( tdds_cms_h / 2.0 );

// magnet retention bar
tdds_mrb_w = tdds_msp_w + ( 2.0 * min_wall );
tdds_mrb_l = min_wire;
tdds_mrb_h = tdds_msp_h + min_wire;

tdds_mrb_x = -( tdds_mrb_w / 2.0 ) + ( tdds_bar_w / 2.0 );
tdds_mrb_y = -( tdds_mrb_l / 2.0 ) + tdds_mag_y + ( smag_h / 2.0 );
tdds_mrb_z = tdds_msp_z - ( tdds_msp_h / 2.0 ) + tdds_mrb_h / 2.0;
tdds_mrb_c_y = tdds_clip_c_y + ( smag_h / 2.0 );

// magnet retension bar bump
tdds_mrbb_r = 2.0 * proc_tol;

tdds_fin_l = irlb_w - proc_tol;
// try to stop shapeways from complaining by slightly exceeding min_wall
tdds_fin_w = min_wall + 0.1; 

tdds_irlh_w = irlb_m_d + ( 2.0 * min_wall );
tdds_irlh_l = irlb_m_w + ( 2.0 * min_wall );
tdds_irlh_h = irlb_m_h + min_wall - csg_utol;
tdds_irlh_x = -( tdds_bh_w / 2.0 ) - proc_tol - irle_m_r - irlb_m_d - min_wall + ( tdds_irlh_w / 2.0 );
tdds_irlh_y = -( tdds_box_l / 2.0 ) + tdds_mat_t + ( tdds_irlh_l / 2.0 ) - min_wall;
tdds_irlh_z = ( tdds_irlh_h / 2.0 ) + tdds_irl_z - min_wall;

tdds_irll_x = -( tdds_bh_w / 2.0 ) - proc_tol - irle_m_r - ( irlb_m_d / 2.0 );
tdds_irll_y1 = -( tdds_box_l / 2.0 ) + tdds_mat_t + irlcath_m_x + (irll_m_w / 2); 
tdds_irll_y2 = tdds_irll_y1 + irll_spacing_x;

// the key cap pivot radius
tdds_kcp_r = trp_pivot_r;
tdds_kcp_d = 2.0 * tdds_kcp_r;

tdds_kcp_x = 0;
tdds_kcp_y = ( tdds_box_l / 2.0 ) + tdds_kcp_r;
tdds_kcp_z = tdds_bar_h + tdds_mat_t - tdds_kcp_r;

tdds_kcp_w = tdds_box_w - proc_tol - ( 2.0 * min_wall );

// the slot into which the pivots slide
tdds_kcps_l = tdds_kcp_d + proc_tol;
tdds_kcps_w = ( tdds_box_w - ( 2.0 * min_wall )) / 3.0;
// the height of the bottom of the slot
tdds_kcps_h = tdds_kcp_d + proc_tol + tdds_kcp_d;
tdds_kcps_z = ( tdds_kcps_h / 2.0 ) + tdds_kcp_z - tdds_kcp_r;
tdds_kcps_x = ( tdds_kcps_w / 2.0 ) - ( tdds_box_w / 2.0 ) + min_wall;
tdds_kcps_y = ( tdds_kcps_l / 2.0 ) + ( tdds_box_l / 2.0 );

// upper starting mass to form tall back wall
tdds_kcpsm_w = tdds_kcps_w + min_wall;
tdds_kcpsm_l = tdds_kcps_l + min_wall - csg_tol;
tdds_kcpsm_h = tdds_kcps_h + ( 2.0 * min_wall ); // double min_wall --> stronger
tdds_kcpsm_x = ( tdds_kcpsm_w / 2.0 ) - ( tdds_box_w / 2.0 );
tdds_kcpsm_y = ( tdds_kcpsm_l / 2.0 ) + ( tdds_box_l / 2.0 ) + csg_tol;
tdds_kcpsm_z = ( tdds_kcpsm_h / 2.0 ) + tdds_kcp_z - tdds_kcp_r - ( 2.0 * min_wall );
// lower starting mass to join with box
tdds_kcpsm2_w = tdds_kcps_w + min_wall;
tdds_kcpsm2_l = tdds_kcps_l + ( 2.0 * min_wall );
tdds_kcpsm2_h = tdds_kcps_h + ( 2.0 * min_wall ) - tdds_kcp_d - proc_tol; // double min_wall --> stronger
tdds_kcpsm2_x = ( tdds_kcpsm_w / 2.0 ) - ( tdds_box_w / 2.0 );
tdds_kcpsm2_y = ( tdds_kcpsm_l / 2.0 ) + ( tdds_box_l / 2.0 ) - min_wall;
tdds_kcpsm2_z = ( tdds_kcpsm2_h / 2.0 ) + tdds_kcp_z - tdds_kcp_r - ( 2.0 * min_wall );

// Thumb Down Double Switch KeyCap parameters
tdds_kc_t = 3.0;

// Thumb Down Double Switch keycap Lifting Travel Stop
// this prevents the tdds keycap from swinging away from tdds box
// if, for example, the keyboard is inverted, or someone pulls the keycap.
// it can only go up to the center of the pivot so that there is 
// no intereference with the box.

// gap between lts and PCB
tdds_lts_gap = 2.0;
tdds_lts_h = tdds_box_h - tdds_lts_gap - tdds_kcp_r;
tdds_lts_l = tdds_kcpsm_l - proc_tol;
tdds_lts_w = tdds_box_w - ( 2.0 * tdds_kcpsm_w ) - proc_tol; 
tdds_lts_x = tdds_kcp_x;
tdds_lts_y = tdds_kcp_y - tdds_kcp_r + (( tdds_lts_l + proc_tol ) / 2.0 );
tdds_lts_z = tdds_kcp_z - ( tdds_lts_h / 2.0 );

// the keycap pivot connector
tdds_kcpc_h = tdds_kcp_r + proc_tol + tdds_kc_t + csg_tol;
tdds_kcpc_l = tdds_lts_l - tdds_kcp_r + proc_tol;
tdds_kcpc_w = tdds_lts_w;
tdds_kcpc_x = tdds_lts_x;
tdds_kcpc_y = tdds_lts_y + ( tdds_kcp_r / 2.0 );
tdds_kcpc_z = tdds_lts_z + ( tdds_lts_h / 2.0 ) + ( tdds_kcpc_h / 2.0 ) - csg_tol;

tdds_kcpc2_h = tdds_kcp_r + proc_tol + csg_tol;
tdds_kcpc2_w = tdds_kcp_w;
tdds_kcpc2_l = tdds_kcp_r - proc_tol + csg_tol;
tdds_kcpc2_x = tdds_kcp_x;
tdds_kcpc2_y = tdds_kcp_y - tdds_kcp_r + proc_tol + ( (tdds_kcpc2_l -csg_tol) / 2.0 );
tdds_kcpc2_z = tdds_kcp_z + ( tdds_kcpc2_h / 2.0 );

// the starting mass of the keycap
tdds_kcsm_h = tdds_kc_t;
tdds_kcsm_w = 15;
tdds_kcsm_l = tdds_box_l + 10 + tdds_kcp_r + csg_tol;
tdds_kcsm_x = tdds_kcpc_x;
tdds_kcsm_y = tdds_kcpc_y - ( tdds_kcpc_l / 2.0 )- ( tdds_kcsm_l / 2.0 ) + ( csg_tol / 2.0 );
tdds_kcsm_z = tdds_kcp_z + tdds_kcp_r + proc_tol + ( tdds_kcsm_h / 2.0 );

// the vertical travel of the tdds bar is max: tdds_rot_h
// the end of the keycap will travel slightly farther as it
// extends past the actuation hole to the end of the tdds box
// the angle of rotation of the keycap is
//
//  hole--------pivot
//   |tdds_rot_h
//
//  aor = asin(tdds_rot_h/dist_hole_pivot)
//
tdds_kc_aorl = tdds_kcp_y - tdds_ah_y; // length for aor calc
tdds_kc_aor = asin( tdds_rot_h / tdds_kc_aorl );
tdds_kc_rrl = tdds_box_l + tdds_kcp_r; // overall rotation relevent length
// the vertical travel of the keycap at the box end is:
tdds_kc_rvdbe = tdds_kc_rrl * sin( tdds_kc_aor ); // rotational vert disp at end

tdds_kc_w = 20;
tdds_kc_r = 32; // radius which extends and trims fingerprint side of keycap
tdds_kcr1_x = tdds_kcsm_x - ( tdds_kc_w / 2.0 ) + tdds_kc_r;
tdds_kcr1_y = tdds_ah_y;
tdds_kcr1_z = tdds_kcsm_z;

tdds_kc_r2 = 55; // radius of arc which trims thumb nail side of keycap
tdds_kcr2_x = tdds_kcsm_x + ( tdds_kcsm_w / 2.0 ) - tdds_kc_r2;
tdds_kcr2_y = tdds_kcr1_y;
tdds_kcr2_z = tdds_kcr1_z;

tdds_stem_r = tdds_kcp_r;
tdds_stem_l = tdds_kcp_r * 2.0;
tdds_stem_w = tdds_ah_w - (2.0 * proc_tol);
tdds_stem_h = tdds_rot_h + tdds_mat_t - tdds_stem_r + tdds_kc_t / 2.0;

tdds_stem_x = tdds_ah_x;
tdds_stem_y = tdds_ah_y;
tdds_stem_z = tdds_bar_h + tdds_stem_r + (tdds_stem_h / 2.0 );
tdds_stem_rz = tdds_bar_h + tdds_stem_r;

thumb_cap_gap = 3.0;
thumb_cap_angle = 8; // angle of face which thumb contacts
thumb_cap_h = 15.0;
thumb_cap_min_w = 1.5;

// Main Inboard Thumb KeyCap (inboard = fingerprint side)
mitkc_r = thumb_cap_gap + tdds_kc_r;
mitkc_l = 35.0;
mitkc_w = 6.0;
mitkc_h = thumb_cap_h;
mitkc_x = -mitkc_w/2.0 - kcb_w/2.0;

// the cylinder which bites into the the mitkc = mitkcc
mitkcc_bite = mitkc_w - thumb_cap_min_w; // how much bite
mitkcc_x = mitkc_x - ( mitkc_w / 2.0 ) - mitkc_r + mitkcc_bite;

// Distal Outer Thumb KeyCap
dotkc_r = tdds_kc_r2 + thumb_cap_gap;
dotkc_l = 30.0;
dotkc_w = 6.0;
dotkc_h = thumb_cap_h;
dotkc_x = - ( dotkc_w / 2.0 ) - ( kcb_w / 2.0 );

dotkcc_bite = dotkc_w - thumb_cap_min_w;
dotkcc_x = dotkc_x - ( dotkc_w / 2.0 ) - dotkc_r + dotkcc_bite;

// Proximal Outer Thumb KeyCap
potkc_l = 20.0;
potkc_w = 6.0;
potkc_h = thumb_cap_h;
potkc_x = - (potkc_w / 2.0 ) - ( kcb_w / 2.0 );

// Proximal Outer Thumb KeyCap Subtractor bite
potkcs_bite = potkc_w - thumb_cap_min_w;
potkcs_x = potkc_x - potkc_w + potkcs_bite;

// Proximal Inner/Upper Thumb KeyCap

pitkc_u1_r = 5;
pitkc_u1_a1 = -25; // angle from square to keycap base
pitkc_u1_a2 = 35; // angle from horizontal

pitkc_w = tf_mat_t;
pitkc_l = ( 2.0 * pitkc_u1_r ) / cos( pitkc_u1_a1 );
pitkc_h = mitkc_h + 4 + tf_mat_t;
pitkc_x = - ( pitkc_w / 2.0 ) - ( kcb_w / 2.0 );

pitkc_u1_l = 14;

pitkc_u1_tx = pitkc_u1_l;
pitkc_u1_ty = pitkc_u1_l * abs( tan( pitkc_u1_a1 )) ;//+ pitkc_u1_r/cos(pitkc_u1_a1);
