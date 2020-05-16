rc_dia = 2;
rc_short = 14.6 - rc_dia;
rc_long = 23.1 - rc_dia;
rc_border = 5;
pin_height = 8;

$fn = 100;
module rpicam() {
  difference() {
  union() {
  translate([-10, 0, 0]) cube([rc_short+rc_border+rc_border, rc_long+rc_border+rc_border, rc_border/2]);
  cube([rc_short+rc_border+rc_border, rc_long+rc_border+rc_border, rc_border/2]);
    translate([rc_border, rc_border, 0]) cylinder(d=rc_dia+rc_dia, h=pin_height);
    translate([rc_border+rc_short, rc_border, 0]) cylinder(d=rc_dia+rc_dia, h=pin_height);
    translate([rc_border, rc_border+rc_long, 0]) cylinder(d=rc_dia+rc_dia, h=pin_height);
    translate([rc_border+rc_short, rc_border+rc_long, 0]) cylinder(d=rc_dia+rc_dia, h=pin_height);
  }

    translate([rc_border, rc_border, -1]) cylinder(d=rc_dia, h=pin_height+2);
    translate([rc_border+rc_short, rc_border, -1]) cylinder(d=rc_dia, h=pin_height+2);
    translate([rc_border, rc_border+rc_long, -1]) cylinder(d=rc_dia, h=pin_height+2);
    translate([rc_border+rc_short, rc_border+rc_long, -1]) cylinder(d=rc_dia, h=pin_height+2);
}
}


rpicam();
