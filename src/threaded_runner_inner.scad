use<threaded_screw.scad>;

threaded_runner_height = 9;
threaded_runner_radius = 30;
bearings_radius = 2.5;
rod_radius = 1.75;
rod_edge_dist = 3 + rod_radius;


$fn = 100;

module bearing_loop () {
      translate([0, 0, threaded_runner_height/2])
        rotate_extrude()
          translate([threaded_runner_radius, 0, 0])
            circle(r=bearings_radius);
}

module threaded_runner(s=1.01) {
  difference() {
    cylinder(r=threaded_runner_radius,h=threaded_runner_height);
    bearing_loop();
    scale([s,s,1.0]) translate([0,0,-15]) base_threaded_screw();
    translate([0, 0, -10]) cylinder(r=10, h=1000);

    for (a=[0,1,2,3])
    rotate([0,0,90*a+45]) translate([threaded_runner_radius-rod_edge_dist,0,-1]) cylinder(r=rod_radius,h=100);
  }
}

threaded_runner();
