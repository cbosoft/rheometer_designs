rout = 44.2/2;
t = 5; // thickness
ch = 40; //
bl = 15.9; // bolt length
br = 1.5; // bolt radius
bhr = 4; // bolt head radius
ss = 60; // sink spacing
td = 4; // table dip
cs = 50; // cylinder spacing

$fn = 100;

difference() {
  union() {
    translate([0, 0, td]) {
    hull() {
      cylinder(r=rout+t, h=ch-td);
      translate([cs,  ss/2, 0]) cylinder(r=br+t, h=bl);
    }
    hull() {
      cylinder(r=rout+t, h=ch-td);
      translate([cs, -ss/2, 0]) cylinder(r=br+t, h=bl);
    }
    }
    cylinder(r=rout+t, h=ch);
  }
  
  translate([cs,  ss/2, 0]) cylinder(r=br, h=bl);
  translate([cs,  ss/2, bl]) cylinder(r=bhr, h=bl);

  translate([cs, -ss/2, 0]) cylinder(r=br, h=bl);
  translate([cs, -ss/2, bl]) cylinder(r=bhr, h=bl);

  translate([0, 0, t]) cylinder(r=rout, h=ch);
}

