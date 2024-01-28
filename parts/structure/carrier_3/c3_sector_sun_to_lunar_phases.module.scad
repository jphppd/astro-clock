include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/sun_to_lunar_phases/structure.scad>

module sun_to_lunar_phases() {
  for(angle = [0, sun_to_lunar_phases_2_theta]) {
    rotate(angle)
      spoke();
  }

  mirror([0, 0, 1]) {
    circular_shaft(r = sun_to_lunar_phases_2_r, theta = sun_to_lunar_phases_2_theta, length = 2, radius = gears_shaft_radius + spacer_sleeve);
  }
}

module sun_to_lunar_phases_drill() {
  translate([sun_to_lunar_phases_3_r, 0, 0])
    circular_hole(radius = lunar_phases_shaft_radius);
  translate([0, 0, layer_thickness])
    mirror([0, 0, 1])
      circular_hole(r = sun_to_lunar_phases_2_r, theta = sun_to_lunar_phases_2_theta, length = 3);
  circular_hole(r = sun_to_lunar_phases_3_r, theta = 0);
  circular_hole(r = carrier_outer_radius, theta = 0);
}

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      base_structure();
      sun_to_lunar_phases();
    }
    sun_to_lunar_phases_drill();
  }
