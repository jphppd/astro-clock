include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_6a_n;
m = clock_to_sun_mod;

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m);
    hex_hole(circumradius = gears_shaft_radius + spacer_sleeve);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 4 / 7 * n * m / 2, theta = theta, radius = 1 / 9 * n * m, length = 2);
  }
