// units are all millimeters

bolt_radius = 4;

// Couette
couette_inner_cylinder_radius = 15.05;
couette_outer_cylinder_inner_radius = 18.75;
couette_outer_cylinder_outer_radius = 22.25;
couette_inner_cylinder_height = 93.25;
couette_outer_cylinder_height = 98.3;
couette_outer_cylinder_thickness = couette_outer_cylinder_outer_radius - couette_outer_cylinder_inner_radius;
couette_gap = couette_outer_cylinder_inner_radius - couette_inner_cylinder_radius;

couette_base_mount_height = 20;
couette_base_mount_thickness = 5;

// optenc general
optenc_bearings_radius = 2.5;

// optenc inner
// main slotted disc part, complete with section connecting to TSTS (upper) and
// inner cylinder (lower)
optenc_inner_radius = 30;
optenc_inner_height = 5;
optenc_inner_bulk_height = 30;
optenc_inner_bulk_radius = 16;
optenc_inner_bulk_zoffset = 10;

// optenc outer + handle
// important for steadying rheometer to clamp stand
optenc_outer_radius = 40;
optenc_outer_height = 6;
optenc_outer_bulk_height = 20;
optenc_handle_extent_y = 68;
optenc_handle_tsts_plug_extent_y = optenc_handle_extent_y - 26;
optenc_handle_radius = 6.45;

backbone_width = 40;
handle_width = 20.0; // width of wee bit above cylinder port
handle_conn_w = 7.0; // sidelength of cube notch
handle_conn_ww = backbone_width - handle_conn_w - handle_conn_w - 2 -2; // dist between notches
handle_l = 70.0;

$fn = 200;

module optenc_handle() {
  translate([0, optenc_outer_radius, -((optenc_outer_bulk_height/2))])
    rotate([270, 0, 0])
      cylinder(h=30, r=optenc_handle_radius);
}

module optenc_outer_handle_section () {
  difference() {
    translate([0, 0, -((optenc_outer_height - optenc_inner_height)/2) - optenc_outer_bulk_height])
      linear_extrude(height=optenc_outer_bulk_height+optenc_outer_height)
        // pointes here are tangents to circle, taken from FreeCAD.
        polygon(points=[
          [-10, 68], 
          [-35.5691, 18.2987], 
          [0, optenc_outer_radius],
          [35.5691, 18.2987],
          [10, 68]]);
    optenc_handle();
  }
}

module disc_with_handle () {

  difference() {
    union() {
      hull() {
        cylinder(r=optenc_outer_radius, h=optenc_outer_height);
        translate([-handle_width/2, -70, 0]) cube([handle_width, 1, optenc_outer_height]);
      }
      translate([0, -optenc_outer_radius+5, -optenc_handle_radius+optenc_outer_height/2]) rotate([90,0,0]) cylinder(r=optenc_outer_height/2+optenc_handle_radius,h=handle_l-optenc_outer_radius+5);
      translate([0,0,-optenc_outer_height]) cylinder(r=optenc_outer_radius, h=optenc_outer_height*2);
    }
    translate([handle_conn_ww/2, -handle_l+handle_width, -1]) cube([handle_conn_w,handle_conn_w,10]);
    translate([-handle_conn_w-handle_conn_ww/2, -handle_l+handle_width, -1]) cube([handle_conn_w,handle_conn_w,10]);
    translate([0, -optenc_outer_radius, -optenc_handle_radius+optenc_outer_height/2]) rotate([90,0,0]) cylinder(r=optenc_handle_radius,h=handle_l-optenc_outer_radius+5);

    rotate([0,0,120]) translate([0,0,-100]) rotate_extrude(angle=30) square([500,500]);
    rotate([0,0,90]) translate([0,0,-1-optenc_outer_height]) rotate_extrude(angle=90) square([500,optenc_outer_height+1]);

  }

}

module inner_dummy() {
  translate([0,0,-((optenc_outer_height - optenc_inner_height)/2)]) cylinder (r=optenc_inner_radius,h=optenc_inner_height);
}

module inner_main() {
  translate([0,0,-500]) cylinder (r=optenc_inner_radius,h=1000);
}

module bearing_loop () {
      translate([0, 0, optenc_inner_height/2+((optenc_outer_height - optenc_inner_height)/2)])
        rotate_extrude()
          translate([optenc_inner_radius, 0, 0])
            circle(r=optenc_bearings_radius);
}

module zip_tie_trough_half(h, d, t, l, w) {
  translate([l, 0, 0]) cube([t, w, h]);
  translate([l+d, w, 0]) rotate([0,0,90]) intersection() {
    difference() {
      cylinder(r=d, h=100);
      cylinder(r=d-t, h=100);
    }
    cube([10, 5, h]);
  }
}

module zip_tie_trough(h=4, d=4, t=2, l=70, w=4) {
  zip_tie_trough_half(h, d, t, l, w/2);
  mirror([0,1,0]) {
    zip_tie_trough_half(h, d, t, l, w/2);
  }
}

module optenc_outer() {
  difference() {
    disc_with_handle();
    inner_main();
    bearing_loop();
    translate([0, 0, ((optenc_outer_height - optenc_inner_height)/2)])
    rotate([0, 0, 135]) zip_tie_trough(d=4.5, l=optenc_outer_radius-6, w=20);
  }
}

module sensor_mount() {
  bh = 5.0;
  th = 9.0;
  cr = 22;
  ledr = 2.5;
  ptr = 1.47;
  difference() {
    union() {
      rotate([0, 0,120]) translate([0, 0, 0]) rotate_extrude(angle=30) translate([optenc_inner_radius, 0]) square([optenc_outer_radius - optenc_inner_radius,optenc_outer_height]);
      rotate([0, 0, 90]) translate([0, 0, optenc_outer_height]) rotate_extrude(angle=90) translate([optenc_outer_radius-cr, 0]) square([cr,th]);
      rotate([0, 0, 90]) translate([0, 0, -bh]) rotate_extrude(angle=90) translate([optenc_outer_radius-cr, 0]) square([cr,bh]);
    }
    for (angle=[-30,0,30])
      translate([0, 0, 2]) rotate([0, 0, 135+angle]) translate([optenc_outer_radius-cr+4, 0, 0]) cylinder(r=ledr, h=100);
    for (angle=[-30,0,30])
      translate([0, 0, -50]) rotate([0, 0, 135+angle]) translate([optenc_outer_radius-cr+4, 0, 0]) cylinder(r=ptr, h=100);
    translate([0, 0, ((optenc_outer_height - optenc_inner_height)/2)])
    rotate([0, 0, 135]) zip_tie_trough(d=4.5, l=optenc_outer_radius-6, w=20);
    bearing_loop();
  }
}

optenc_outer();
//translate([-5, 5, 0]) sensor_mount();
