
bhr = 3.2; //  bolt hole radius
cr = bhr + 5; // corner radius
sh = 33; // short height
th = sh + 5.5; // tall height
bhs = 38; // bolt hole spacing
w = cr + cr + bhr + bhr + bhs;
l = 50; // length
bp = max([l-40, l/2]);
cls = l - cr - cr; // corner long spacing
mcr = 13/2; // mount cylinder radius


$fn = 100;

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60])
    rotate([0,0,r])
      cube([boxWidth, size, height], true);
}

module tmount() {
difference() {
  union() {
    hull() {
      translate([-bhs/2, cr, 0]) cylinder(r=cr, h=th);
      translate([ bhs/2, cr, 0]) cylinder(r=cr, h=th);
      translate([     0, cls+cr, 0]) cylinder(r=cr, h=th);
    }
    hull() {
      translate([     0, cr,     0]) cylinder(r=cr, h=th);
      translate([     0, cls+cr, 0]) cylinder(r=cr, h=th);
    }
  }
  translate([-bhs/2, cr, 0]) cylinder(r=bhr,h=th);
  translate([ bhs/2, cr, 0]) cylinder(r=bhr,h=th);
  translate([0, 0, th/2]) rotate([-90, 0, 0]) cylinder(r=mcr,h=l);
  translate([0, bp, 0]) cylinder(r=2.5,h=th);
  translate([0, bp, sh-5]) cylinder(r=7, h=6);
  translate([0, bp, 0]) hexagon(size=8, height=5);
  translate([-w, 0, sh]) cube([2*w, 105, th-sh]);
}
}

difference() {
tmount();
translate([-100, -100, (th/2)-0.5]) cube([200, 200, 200]);
}


translate([90, 0, 0]) difference() {
translate([0,0,th]) rotate([180,0,0]) tmount();
translate([-100, -100, (th/2)-0.5]) cube([200, 200, 200]);
}
