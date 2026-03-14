include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_2b_n;
m = clock_to_sun_2b_3a_mod;

scale([global_scale, global_scale, global_scale])
  difference() {
    default_gear(n, m, invert=true);

    hex_hole(circumradius=gears_shaft_radius + spacer_sleeve / 3, stellation_radius=gears_shaft_radius);

    for (theta = [0:360 / 6:360])
      circular_hole(r=3 / 5 * n * m / 2, theta=theta, radius=1 / 12 * n * m);
  }
