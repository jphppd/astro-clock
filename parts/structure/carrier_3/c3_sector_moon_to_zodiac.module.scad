include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module moon_to_zodiac() {
}

module moon_to_zodiac_drill() {
  circular_hole(r = carrier_outer_radius, theta = 0);
}

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      base_structure();
      moon_to_zodiac();
    }
    moon_to_zodiac_drill();
  }
