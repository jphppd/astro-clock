include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>
include <sun_to_lunar_phases_gear.module.scad>

n = sun_to_lunar_phases_6_n;
m = sun_to_lunar_phases_5b_6_mod;

scale([global_scale, global_scale, global_scale])
  difference() {
    bevel_gear(n, m);
    translate([0, 0, -layer_thickness])
      hex_hole(circumradius=lunar_phases_shaft_radius, length=2 * layer_thickness);
  }
