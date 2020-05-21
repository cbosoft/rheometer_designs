driver_radius = 30;
driver_height = 15;

rod_off_radius = 25;
rod_radius = 1.01;
rod_extra_height = 0.5;
rod_extra_radius = 1;

motor_shaft_radius = 3;
motor_small_radius = 2.45;
motor_shaft_len = 15;

bearing_radius = 4.05;
bearing_height = 7;

$fn = 200;

module motor_shaft(h) {
  difference() {
    cylinder(r=motor_shaft_radius, h=h);
    translate([-10,motor_small_radius,-1]) cube([20, 20, 20]);
  }
}


module driver() {
  difference() {
    union() {
      cylinder(r=driver_radius, h=driver_height);
      translate([0, 0, driver_height]) cylinder(r=bearing_radius+1, h=1);
      translate([0, 0, driver_height+1]) cylinder(r=bearing_radius, h=bearing_height);
      for (m=[0,1,2,3])
      rotate([0,0,m*90]) translate([0, rod_off_radius, driver_height]) cylinder(r=rod_radius+rod_extra_radius, h=rod_extra_height);
    }
    translate([0, 0, -1]) motor_shaft(motor_shaft_len+1);
    for (m=[0,1,2,3])
    rotate([0,0,m*90]) translate([0, rod_off_radius, -1]) cylinder(r=rod_radius, h=100);
  }
}

driver();
