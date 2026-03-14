include <../../../utils/constants/constants.scad>
use <c2_carrier.module.scad>

scale([global_scale, global_scale, global_scale])
  rotate([180, 0, 0])
    difference() {
      carrier();
      translate([0, 0, 500])
        cube(1000, center=true);
    }
