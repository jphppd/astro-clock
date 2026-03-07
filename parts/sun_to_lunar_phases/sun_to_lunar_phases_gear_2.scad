include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>

na = sun_to_lunar_phases_2a_n;
nb = sun_to_lunar_phases_2b_n;
ma = sun_to_lunar_phases_1_2a_mod;
mb = sun_to_lunar_phases_2b_3a_mod;

scale([global_scale, global_scale, global_scale])
  difference() {
    union() {
      default_gear(na, ma, invert = true);
      translate(v = [0, 0, gear_thickness - eps])
        default_gear(nb, mb, invert = true);
    }
    circular_hole(radius = gears_shaft_radius, length = 2);

    for(theta = [0:360 / 12:360])
      circular_hole(r = 2 / 3 * na * ma / 2, theta = theta, radius = 1 / 20 * na * ma);

    for(theta = [360 / 24:360 / 12:360])
      circular_hole(r = 4 / 5 * na * ma / 2, theta = theta, radius = 1 / 32 * na * ma);

    for(theta = [360 / 24:360 / 8:360])
      circular_hole(r = 3 / 5 * nb * mb / 2, theta = theta, radius = 1 / 16 * nb * mb, length = 2);
  }
