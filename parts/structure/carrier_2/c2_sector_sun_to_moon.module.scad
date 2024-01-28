include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/sun_to_moon/structure.scad>

module sun_to_moon() {
  spoke();
}

module sun_to_moon_drill() {
  circular_hole(r = sun_to_moon_2_r, theta = 0, length = layer_thickness);
  circular_hole(r = carrier_outer_radius, theta = 0);
}

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      base_structure();
      sun_to_moon();
    }
    sun_to_moon_drill();
  }
