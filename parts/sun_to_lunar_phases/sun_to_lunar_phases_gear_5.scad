include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>

n = sun_to_lunar_phases_5_n;
m = sun_to_lunar_phases_4b_5_mod;

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m);
    hex_hole(apothem = lunar_phases_shaft_radius);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 4 / 9 * n * m / 2, theta = theta, radius = 1 / 10 * n * m);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 3 / 4 * n * m / 2, theta = theta, radius = 1 / 16 * n * m);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 5 / 6 * n * m / 2, theta = theta, radius = 1 / 24 * n * m);
  }
