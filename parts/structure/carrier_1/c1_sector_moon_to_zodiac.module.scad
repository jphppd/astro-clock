include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/moon_to_zodiac/structure.scad>
include <../../../utils/constants/structure.scad>

module moon_to_zodiac() {
  circular_shaft(r = carrier_outer_radius, theta = 0, length = carrier_3_offset + 1);

  for(angle = [moon_to_zodiac_2_theta, moon_to_zodiac_3_theta, moon_to_zodiac_4_theta]) {
    rotate(angle)
      spoke();
  }
  circular_shaft(r = moon_to_zodiac_2_r, theta = moon_to_zodiac_2_theta, length = carrier_2_offset - carrier_1_offset + 1);
  circular_shaft(r = moon_to_zodiac_3_r, theta = moon_to_zodiac_3_theta, length = carrier_2_offset - carrier_1_offset + 1);
  circular_shaft(r = moon_to_zodiac_4_r, theta = moon_to_zodiac_4_theta, length = carrier_2_offset - carrier_1_offset + 1);
  translate([carrier_outer_radius, 0, layer_thickness])
    fillet(gears_shaft_radius - half_allowance, gears_shaft_radius + 3);

  circular_shaft(r = moon_to_zodiac_2_r, theta = moon_to_zodiac_2_theta, length = 2, radius = gears_shaft_radius + spacer_sleeve);
  circular_shaft(r = moon_to_zodiac_3_r, theta = moon_to_zodiac_3_theta, length = 3, radius = gears_shaft_radius + spacer_sleeve);
  circular_shaft(r = moon_to_zodiac_4_r, theta = moon_to_zodiac_4_theta, length = 4, radius = gears_shaft_radius + spacer_sleeve);
}

module moon_to_zodiac_drill() {
}

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      base_structure();
      moon_to_zodiac();
    }
    moon_to_zodiac_drill();
  }
