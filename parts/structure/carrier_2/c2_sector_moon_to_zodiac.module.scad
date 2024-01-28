include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/moon_to_zodiac/structure.scad>
include <../../../utils/constants/structure.scad>

module moon_to_zodiac() {
  for(angle = [moon_to_zodiac_2_theta, moon_to_zodiac_3_theta, moon_to_zodiac_4_theta]) {
    rotate(angle)
      spoke();
  }
  mirror([0, 0, 1]) {
    circular_shaft(r = moon_to_zodiac_2_r, theta = moon_to_zodiac_2_theta, length = 3, radius = gears_shaft_radius + spacer_sleeve);
    circular_shaft(r = moon_to_zodiac_3_r, theta = moon_to_zodiac_3_theta, length = 2, radius = gears_shaft_radius + spacer_sleeve);
    circular_shaft(r = moon_to_zodiac_4_r, theta = moon_to_zodiac_4_theta, length = 1, radius = gears_shaft_radius + spacer_sleeve);
  }
}

module moon_to_zodiac_drill() {
  translate([0, 0, layer_thickness])
    mirror([0, 0, 1]) {
      circular_hole(r = moon_to_zodiac_2_r, theta = moon_to_zodiac_2_theta, length = 4);
      circular_hole(r = moon_to_zodiac_3_r, theta = moon_to_zodiac_3_theta, length = 3);
      circular_hole(r = moon_to_zodiac_4_r, theta = moon_to_zodiac_4_theta, length = 2);
    }
  circular_hole(r = carrier_outer_radius, theta = 0);
}

scale([global_scale, global_scale, 1])
  translate([0, 0, layer_thickness])
    rotate(180, [1, 0, 0])
      difference() {
        union() {
          base_structure();
          moon_to_zodiac();
        }
        moon_to_zodiac_drill();
      }
