include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_1_n;
m = clock_to_sun_1_2a_mod;

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m);
    hex_hole(circumradius = clock_shaft_radius);
  }
