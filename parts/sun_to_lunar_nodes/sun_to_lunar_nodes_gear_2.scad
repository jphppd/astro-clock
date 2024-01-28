include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_nodes/env.scad>

na = sun_to_lunar_nodes_2a_n;
nb = sun_to_lunar_nodes_2b_n;
ma = sun_to_lunar_nodes_1_2a_mod;
mb = sun_to_lunar_nodes_2b_3_mod;

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      default_gear(na, ma, invert = true);
      translate(v = [0, 0, gear_thickness - eps])
        default_gear(nb, mb, invert = true);
    }
    circular_hole(radius = gears_shaft_radius, length = 2);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 1 / 2 * nb * mb / 2, theta = theta, radius = 1 / 12 * nb * mb, length = 2);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 4 / 5 * nb * mb / 2, theta = theta, radius = 1 / 32 * nb * mb, length = 2);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 3 / 4 * nb * mb / 2, theta = theta, radius = 1 / 16 * nb * mb, length = 2);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 1 / 4 * nb * mb / 2, theta = theta, radius = 1 / 32 * nb * mb, length = 2);
  }
