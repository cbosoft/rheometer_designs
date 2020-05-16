hole_radius = 1.5;
spacer_radius = 2.5;
pcb_short_side = 40 - (2*hole_radius); // replace 40 with distance hole to hole (outside to outside)
pcb_long_side = 60 - (2*hole_radius); // replace 60 with distance hole to hole (outside to outside)
mount_margin = 5;

difference(){
  union() {
    cube([pcb_short_side + (mount_margin*2), pcb_long_side + (mount_margin*2), 5]);

    // spacers
    translate([mount_margin, mount_margin, 0]) cylinder(r=spacer_radius, h=10, $fn=20);
    translate([mount_margin+pcb_short_side, mount_margin, 0]) cylinder(r=spacer_radius, h=10, $fn=20);
    translate([mount_margin, mount_margin+pcb_long_side, 0]) cylinder(r=spacer_radius, h=10, $fn=20);
    translate([mount_margin+pcb_short_side, mount_margin+pcb_long_side, 0]) cylinder(r=spacer_radius, h=10, $fn=20);
  }

  // spacers
  translate([mount_margin, mount_margin, 0]) cylinder(r=hole_radius+0.1, h=10, $fn=20);
  translate([mount_margin+pcb_short_side, mount_margin, 0]) cylinder(r=hole_radius+0.1, h=10, $fn=20);
  translate([mount_margin, mount_margin+pcb_long_side, 0]) cylinder(r=hole_radius+0.1, h=10, $fn=20);
  translate([mount_margin+pcb_short_side, mount_margin+pcb_long_side, 0]) cylinder(r=hole_radius+0.1, h=10, $fn=20);

  // notch for joining to main pcb mount
  translate([(pcb_short_side - 5)/2 + mount_margin, 10, 0]) cube([5, 20, 10]);
}

