include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

na = clock_to_sun_3a_n;
nb = clock_to_sun_3b_n;
ma = clock_to_sun_2b_3a_mod;
mb = clock_to_sun_mod;

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      default_gear(na, ma, invert = true);
      translate(v = [0, 0, gear_thickness - eps])
        default_gear(nb, mb, invert = true);
    }
    circular_hole(radius = gears_shaft_radius, length = 2);

    for(theta = [0:360 / 10:360])
      circular_hole(r = 2 / 3 * na * ma / 2, theta = theta, radius = 1 / 15 * na * ma);
  }
