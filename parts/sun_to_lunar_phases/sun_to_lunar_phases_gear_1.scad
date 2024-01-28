include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>

n = sun_to_lunar_phases_1_n;
m = sun_to_lunar_phases_1_2a_mod;

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m);
    hex_hole(apothem = sun_shaft_radius);
  }
