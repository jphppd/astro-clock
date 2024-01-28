include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/clock_to_sun/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module clock_to_sun() {
  for(angle = [0, clock_to_sun_4_theta, clock_to_sun_3_theta, clock_to_sun_2_theta]) {
    rotate(angle)
      spoke();
  }
  circular_shaft(r = clock_to_sun_4_r, theta = clock_to_sun_4_theta, length = carrier_3_offset - carrier_2_offset + 1);
  circular_shaft(r = clock_to_sun_3_r, theta = clock_to_sun_3_theta, length = carrier_3_offset - carrier_2_offset + 1);
  circular_shaft(r = clock_to_sun_2_r, theta = clock_to_sun_2_theta, length = carrier_3_offset - carrier_2_offset + 1);
}

module clock_to_sun_drill() {
  circular_hole(r = carrier_outer_radius, theta = 0);
}

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      base_structure();
      clock_to_sun();
    }
    clock_to_sun_drill();
  }
