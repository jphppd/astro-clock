include <../../../utils/constants/constants.scad>
use <c2_carrier.module.scad>

scale([global_scale, global_scale, global_scale])
  difference() {
    carrier();
    translate([0, 0, -500])
      cube(1000, center=true);
  }
