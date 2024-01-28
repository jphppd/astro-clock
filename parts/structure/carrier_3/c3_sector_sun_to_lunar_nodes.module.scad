include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/sun_to_lunar_nodes/structure.scad>

module sun_to_lunar_nodes() {
  spoke();
}

module sun_to_lunar_nodes_drill() {
  circular_hole(r = carrier_outer_radius, theta = 0);
  circular_hole(r = sun_to_lunar_nodes_2_r, theta = 0, length = carrier_3_offset - carrier_3_offset + 1);
}

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      base_structure();
      sun_to_lunar_nodes();
    }
    sun_to_lunar_nodes_drill();
  }
