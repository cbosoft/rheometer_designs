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
new_loadcell_height = 6;
new_loadcell_radius = 2;

module small_lc_bracket() {
  difference() {
    cube([length_loadcell-47+8, width_loadcell, height_loadcell]);
    translate([length_loadcell-47, -1, (height_loadcell-new_loadcell_height)/2]) cube([10, width_loadcell+2, new_loadcell_height]);
    translate([length_loadcell-47+4, 3, -1]) cylinder(r=2, h=15);
    translate([length_loadcell-47+4, width_loadcell-3, -1]) cylinder(r=2, h=15);
  }
}

small_lc_bracket();
