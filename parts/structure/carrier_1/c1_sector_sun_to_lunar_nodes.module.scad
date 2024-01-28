include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module sun_to_lunar_nodes() {
  circular_shaft(r = carrier_outer_radius, theta = 0, length = carrier_3_offset + 1);
  translate([carrier_outer_radius, 0, layer_thickness])
    fillet(gears_shaft_radius - half_allowance, gears_shaft_radius + 3);
}

module sun_to_lunar_nodes_drill() {
}

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      base_structure();
      sun_to_lunar_nodes();
    }
    sun_to_lunar_nodes_drill();
  }
