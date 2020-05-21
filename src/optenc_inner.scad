optenc_bearings_radius = 2.5;
bolt_radius = 4;
optenc_inner_radius = 30;
optenc_inner_height = 5;
optenc_inner_bulk_height = 30;
optenc_inner_bulk_radius = 16;
optenc_inner_bulk_zoffset = 10;
nw = 15;


$fn = 200;

module optenc_inner() {
  difference() {
    union() {
      translate([-nw/2, -nw/2, optenc_inner_bulk_height-optenc_inner_bulk_zoffset]) cube([nw, nw, 5]);
      difference() {
        difference() {
          cylinder(h=optenc_inner_height, r=optenc_inner_radius);
          rotate_extrude() 
            translate([optenc_inner_radius, optenc_inner_height/2, 0]) 
              circle(r=optenc_bearings_radius);
        }
        
        difference(){
          // slots
          translate([0,0,-1]) intersection() {
            cylinder(r=26, h=optenc_inner_height+2);
            for (i = [45:45:360]) {
              rotate([0, 0, i])
                rotate_extrude(angle=22.5)
                  square([optenc_inner_radius, optenc_inner_height+2]);
            }
          }
          cylinder(r=18,h=optenc_inner_height);
        }
      }
      translate([0, 0, -(optenc_inner_bulk_zoffset)]) 
        cylinder(r=optenc_inner_bulk_radius,h=optenc_inner_bulk_height);
    }
    translate([0, 0, -15]) cylinder(r=bolt_radius, h=optenc_inner_bulk_height+20);
  }
}

optenc_inner();
