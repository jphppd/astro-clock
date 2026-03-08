include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module sun_to_lunar_phases() {
  for (theta = [-13, 13])
    rotate(theta) {
      circular_shaft(r = carrier_outer_radius, theta = 0, length = carrier_3_offset + 1);
      translate([carrier_outer_radius, 0, layer_thickness])
        fillet(gears_shaft_radius - half_allowance, gears_shaft_radius + 3);
    }
}

module sun_to_lunar_phases_drill() {
}

difference() {
  union() {
    base_structure();
    sun_to_lunar_phases();
  }
  sun_to_lunar_phases_drill();
}
