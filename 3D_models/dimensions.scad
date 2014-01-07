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


show_mag = 0;
// angle to show lever rotation
show_lr_angle = 0;

// global face number set here
gfn=87; // 87 is the max that fit in the shapeways 64MB size limit.
//gfn=25;

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

