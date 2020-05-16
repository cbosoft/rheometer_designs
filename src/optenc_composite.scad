include <geometry.scad>;

use <optenc_inner.scad>;
use <optenc_outer.scad>;

module optenc_composite() {
  translate ([0, 0, optenc_inner_bulk_zoffset]) group () {
    optenc_inner();
    optenc_outer();
  }
}
