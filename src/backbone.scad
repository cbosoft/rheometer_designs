radius_clamp = 6.45;
radius_clamp_outer = 10;
width_loadcell = 12.7;
height_loadcell = 12.7;
length_loadcell = 80;
height_bearing = 32.5;
width_stand = 40;
length_stand_front_base = 26;
length_stand_front_main = 15;
overhang_loadcell = 5;
length_stand_rear = length_stand_front_main  - length_loadcell + overhang_loadcell;
height_stand = 100;
height_arm = 18;
length_arm = 65;
gap_loadcell = 9;
fit_loadcell = 5;

motor_radius = 18.305;

$fn = 100;

difference() {
  union() {
    cube([26, 40, height_stand]);
    translate([0, width_stand, 0]) rotate([90,0,0]) linear_extrude(width_stand) polygon(points=[ [0,0], [length_stand_rear,0], [length_stand_rear,40], [0, 45] ]);
    translate([length_stand_front_base-7, 2, -7]) cube([7, 7, 7]);
    translate([length_stand_front_base-7, width_stand - 7 - 2, -7]) cube([7, 7, 7]);
    
    // motor holder
    difference() {
      translate([0, 0, height_stand-height_arm]) cube([length_arm, width_stand, height_arm]);
      translate([length_arm, 20, height_stand-(height_arm-3)]) cylinder(r=motor_radius, h=height_arm);

      // motor shaft hole
      translate([length_arm, 20, height_stand-(height_arm-3)-10]) cylinder(r=13, h=height_arm);

      // jubilee clip passage
      difference() {
        translate([length_arm, 20, height_stand-(height_arm-3)]) cylinder(r=26, h=height_arm-6);
        translate([length_arm, 20, height_stand-(height_arm-3)]) cylinder(r=22, h=height_arm-6);
      }
    }

    // clamp bar mount point
    difference() {
      union() {
        translate([length_stand_rear, (width_stand/2), -radius_clamp_outer-0.5]) rotate([0, 90, 0]) cylinder(h=-length_stand_rear, r=radius_clamp_outer);
        translate([length_stand_rear, (width_stand/2) - radius_clamp_outer, -10]) cube([-length_stand_rear, radius_clamp_outer*2, radius_clamp_outer+2]);
      }
      translate([length_stand_rear-1, (width_stand/2), -radius_clamp_outer-0.5]) rotate([0, 90, 0]) cylinder(h=2-length_stand_rear, r=radius_clamp);
    }
  }

  // cut out the front section
  translate([15, -1, 15.95]) cube([15+1, width_stand+2, 84-height_arm]);
  translate([0, width_stand+1, 0]) rotate([90,0,0]) linear_extrude(width_stand+2) polygon(points=[[15,16], [26.1,5], [26.1,16]]);
  // front jubilee passage
  translate([0, width_stand+1, 0]) rotate([90,0,0]) linear_extrude(width_stand+2) polygon(points=[ [5, 5], [5,7], [15,7], [15,5] ]);

  // gap for loadcell, plus space to move
  translate([length_stand_rear+20, (width_stand - (width_loadcell + gap_loadcell))/2, height_bearing - 5]) cube([200, width_loadcell+gap_loadcell, height_loadcell+gap_loadcell]);
  translate([length_stand_rear+20, (width_stand - (width_loadcell + gap_loadcell))/2, height_bearing]) cube([200, width_loadcell+gap_loadcell, height_loadcell+gap_loadcell]);
  translate([length_stand_rear+fit_loadcell, (width_stand - width_loadcell)/2, height_bearing]) cube([200, width_loadcell+gap_loadcell/2, height_loadcell+gap_loadcell]);

  // fit for load cell
  translate([length_stand_rear-1, (width_stand - width_loadcell)/2, height_bearing]) cube([200, width_loadcell, height_loadcell]);
  // loadcell jubilee passage
  translate([length_stand_rear, width_stand+1, height_bearing - 8]) rotate([90,0,0]) linear_extrude(width_stand+2) polygon(points=[ [5, 5], [5,7], [15,7], [15,5] ]);

  // Bite a chunk out to reduce printing time
  translate([length_stand_rear + 10, -1, -25]) cube([-length_stand_rear - 20, width_stand+2, 40]);

  // Take out a chunk so the pcb mount can join
  translate([length_stand_rear-1, (width_stand-5)/2, 10]) cube([11, 5, 10]);
}

new_loadcell_height = 6;
new_loadcell_radius = 2;

module small_lc_bracket() {
  difference() {
    cube([length_loadcell-47+6.5, width_loadcell, height_loadcell]);
    translate([length_loadcell-47, -1, (height_loadcell-new_loadcell_height)/2]) cube([10, width_loadcell+2, new_loadcell_height]);
    translate([length_loadcell-47+3.25, 3, -1]) cylinder(r=2, h=15);
    translate([length_loadcell-47+3.25, width_loadcell-3, -1]) cylinder(r=2, h=15);
  }
}

translate([length_stand_rear-1, (width_stand - width_loadcell)/2, height_bearing]) small_lc_bracket();




//translate([length_stand_rear, (width_stand - width_loadcell)/2, height_bearing]) cube([length_loadcell, width_loadcell, height_loadcell]);

