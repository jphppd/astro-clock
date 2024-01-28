include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_moon/env.scad>

n = sun_to_moon_2_n;
m = sun_to_moon_1_2_mod;

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m, invert = true);
    hex_hole(apothem = gears_shaft_radius + spacer_sleeve);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 1 / 2 * n * m / 2, theta = theta, radius = 1 / 10 * n * m);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 8 / 11 * n * m / 2, theta = theta, radius = 1 / 18 * n * m);
  }
