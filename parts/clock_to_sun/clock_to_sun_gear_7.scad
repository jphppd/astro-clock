include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_7_n;
m = clock_to_sun_6b_7_mod;

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m);
    hex_hole(circumradius = sun_shaft_radius);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 5 / 8 * n * m / 2, theta = theta, radius = 1 / 10 * n * m);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 7 / 9 * n * m / 2, theta = theta, radius = 1 / 18 * n * m);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 4 / 11 * n * m / 2, theta = theta, radius = 1 / 23 * n * m);
  }
