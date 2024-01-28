include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>

n = sun_to_lunar_phases_7_n;
m = sun_to_lunar_phases_6_7_mod;

scale([global_scale, global_scale, 1])
  difference() {
    translate([0, 0, sun_to_lunar_phases_bevel_offset])
      spur_gear(n, m, bevel_cone_angle = 45);
    translate([0, 0, -layer_thickness])
      hex_hole(circumradius = lunar_phases_shaft_radius, length = 2 * layer_thickness);
  }
