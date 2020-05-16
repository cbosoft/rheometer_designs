lc_s = 12.7;
c_w = 40.0;
c_l = 10.0;
d_h = lc_s - 1;
fn = 50;

translate ([0, 0, -d_h])
difference() {
  translate([0, c_l, 0])rotate([90, 0, 0]) cylinder(r=c_w/2.0, h=c_l, $fn=fn);
  translate([-30, 0, d_h-60]) cube([60, 60, 60]);
  translate([-lc_s/2.0, 0, 0]) cube([lc_s, 80, lc_s]);
}
