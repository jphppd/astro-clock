include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_moon/env.scad>

n = sun_to_moon_4_n;
m = sun_to_moon_3_4_mod;
r_dedendum = fn_r_dedendum(n, m);

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m);
    hex_hole(apothem = moon_shaft_radius);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 1 / 2 * n * m / 2, theta = theta, radius = 1 / 10 * n * m);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 8 / 11 * n * m / 2, theta = theta, radius = 1 / 18 * n * m);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 5 / 6 * n * m / 2, theta = theta, radius = 1 / 28 * n * m);
  }
