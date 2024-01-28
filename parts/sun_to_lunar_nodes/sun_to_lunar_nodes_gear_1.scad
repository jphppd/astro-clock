include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_nodes/env.scad>

n = sun_to_lunar_nodes_1_n;
m = sun_to_lunar_nodes_1_2a_mod;

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m);
    hex_hole(circumradius = sun_shaft_radius - 2);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 5 / 8 * n * m / 2, theta = theta, radius = 1 / 8 * n * m);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 5 / 6 * n * m / 2, theta = theta, radius = 1 / 25 * n * m);
  }
