lc_s = 12.7; // loadcell_size
lch_s = 19; // loadcellholder_size
lch_l = 20; // loadcellholder_length
bb_r = 2.5; // ballbearing_radius
b_r = 30; // bearing_radius
c_h = 6; // chip_height
c_l = 10; // chip_length
cv_h = 24; // cover_height
cv_l = 20.1; // cover_length
fn = 100;

module bbring(){
  rotate_extrude(angle = 360, $fn = fn) translate([b_r, 0]) circle(r=bb_r, $fn=fn);
}

// chip = 3D arc
module chip(ang, off) {
  union() {
    rotate_extrude(angle = ang, $fn = fn) translate([b_r-off, -c_h/2.0]) square([c_l+off, c_h]);
    rotate_extrude(angle = -ang, $fn = fn) translate([b_r-off, -c_h/2.0]) square([c_l+off, c_h]);
  }
}

module jubilee(off) {
  rotate_extrude(angle=360, $fn = fn) translate([b_r+off, -5]) square([2, 10]);
}

module loadcell() {
  cube([80, lc_s, lc_s]);
}

module cover() {
  difference() {
    union() {
      difference() {
        union() {
          rotate_extrude(angle = 30, $fn = fn) translate([b_r, -cv_h/2.0]) square([cv_l, cv_h]);
          rotate_extrude(angle = -30, $fn = fn) translate([b_r, -cv_h/2.0]) square([cv_l, cv_h]);
        }
        chip(180, 2);
      }
      chip(15, 0);
    translate([b_r+15.32,-lch_s/2.0,-lch_s/2.0]) cube([lch_l, lch_s, lch_s]);
    }
    bbring();
    jubilee(c_l+2);
    translate([b_r+15.32,-lc_s/2.0,-lc_s/2.0]) loadcell();
  }
}

cover();
