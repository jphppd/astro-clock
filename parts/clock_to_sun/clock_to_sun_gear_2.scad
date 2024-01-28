include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

na = clock_to_sun_2a_n;
nb = clock_to_sun_2b_n;
ma = clock_to_sun_1_2a_mod;
mb = clock_to_sun_2b_3a_mod;

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      default_gear(na, ma, invert = true);
      translate(v = [0, 0, gear_thickness - eps])
        default_gear(nb, mb, invert = true);
    }
    circular_hole(radius = gears_shaft_radius, length = 2);

    for(theta = [0:360 / 16:360])
      circular_hole(r = 4 / 5 * na * ma / 2, theta = theta, radius = 1 / 22 * na * ma);

    for(theta = [0:360 / 8:360])
      circular_hole(r = 1 / 3 * na * ma / 2, theta = theta, radius = 1 / 22 * na * ma, length = 2);
  }
