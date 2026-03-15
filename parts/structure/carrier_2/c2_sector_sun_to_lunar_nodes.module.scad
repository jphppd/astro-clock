include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/sun_to_lunar_nodes/structure.scad>

module sun_to_lunar_nodes() {
  spoke();
  circular_shaft(r=sun_to_lunar_nodes_2_r, theta=0, length=4, radius=gears_shaft_radius + spacer_sleeve);
}

module sun_to_lunar_nodes_drill() {
  circular_hole(r=carrier_outer_radius, theta=0);
  translate([0, 0, layer_thickness - half_allowance]) circular_hole(r=sun_to_lunar_nodes_2_r, theta=0, length=carrier_3_offset - carrier_2_offset);
}

difference() {
  union() {
    base_structure();
    sun_to_lunar_nodes();
  }
  sun_to_lunar_nodes_drill();
}
