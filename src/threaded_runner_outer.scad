threaded_runner_outer_height = 6;
threaded_runner_inner_radius = 30;
threaded_runner_outer_radius = threaded_runner_inner_radius + 10;
bearings_radius = 2.5;

$fn = 200;

module bearing_loop () {
      translate([0, 0, threaded_runner_outer_height/2])
        rotate_extrude()
          translate([threaded_runner_inner_radius, 0, 0])
            circle(r=bearings_radius);
}

module threaded_runner_outer() {
  difference() {
    cylinder(r=threaded_runner_outer_radius, h=threaded_runner_outer_height);
    translate([0, 0, -1]) cylinder(r=threaded_runner_inner_radius, h=threaded_runner_outer_height+2);
    bearing_loop();
    rotate([0,0,0]) translate([0,0,-100]) rotate_extrude(angle=30) square([200,200]);
  }
}

threaded_runner_outer();
