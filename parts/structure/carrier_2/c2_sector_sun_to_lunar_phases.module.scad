include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/sun_to_lunar_phases/structure.scad>

module sun_to_lunar_phases() {
  for(angle = [0, sun_to_lunar_phases_2_theta, sun_to_lunar_phases_3_theta, sun_to_lunar_phases_4_theta, sun_to_lunar_phases_5_theta]) {
    rotate(angle)
      spoke();
  }

  circular_shaft(r = sun_to_lunar_phases_2_r, theta = sun_to_lunar_phases_2_theta, length = carrier_3_offset - carrier_2_offset + 1);
  circular_shaft(r = sun_to_lunar_phases_2_r, theta = sun_to_lunar_phases_2_theta, length = 2, radius = gears_shaft_radius + spacer_sleeve);

  circular_shaft(r = sun_to_lunar_phases_3_r, theta = sun_to_lunar_phases_3_theta, length = carrier_3_offset - carrier_2_offset + 1);
  circular_shaft(r = sun_to_lunar_phases_3_r, theta = sun_to_lunar_phases_3_theta, length = 3, radius = gears_shaft_radius + spacer_sleeve);

  circular_shaft(r = sun_to_lunar_phases_4_r, theta = sun_to_lunar_phases_4_theta, length = carrier_3_offset - carrier_2_offset + 1);
}

module sun_to_lunar_phases_drill() {
  circular_hole(r = sun_to_lunar_phases_5_r, theta = sun_to_lunar_phases_5_theta);
}

difference() {
  union() {
    base_structure();
    sun_to_lunar_phases();
  }
  sun_to_lunar_phases_drill();
}
