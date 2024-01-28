include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_moon/env.scad>

n = sun_to_moon_1_n;
m = sun_to_moon_1_2_mod;

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m);
    hex_hole(circumradius = sun_shaft_radius);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 2 / 3 * n * m / 2, theta = theta, radius = 1 / 10 * n * m);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 4 / 5 * n * m / 2, theta = theta, radius = 1 / 24 * n * m);
  }
