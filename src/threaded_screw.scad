module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60])
    rotate([0,0,r])
      cube([boxWidth, size, height], true);
}

module base_threaded_screw () {
  translate([0,0,63]) rotate([180,0,0]) import("../data/threaded_screw.stl", convexity=3);
}

$fn=50;

translate([0,0,63]) rotate([180,0,0])
union() {
  difference() {
    import("../data/threaded_screw.stl", convexity=3);
    hexagon(13.1, 60);
    cylinder(r=4.5, h=200);
  }
  translate([0, 0, 16]) difference() {
    cylinder(r=16, h=10);
    translate([0, 0, -1]) cylinder(r=11, h=20);
  }
}

translate([0,0,-1]) cube([7.5,7.5,5]);
