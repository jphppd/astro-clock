include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>

na = sun_to_lunar_phases_2a_n;
nb = sun_to_lunar_phases_2b_n;
ma = sun_to_lunar_phases_1_2a_mod;
mb = sun_to_lunar_phases_2b_3a_mod;

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      default_gear(na, ma, invert = true);
      translate(v = [0, 0, gear_thickness - eps])
        default_gear(nb, mb, invert = true);
    }
    circular_hole(radius = gears_shaft_radius, length = 2);

    for(theta = [0:360 / 12:360])
      circular_hole(r = 2 / 3 * na * ma / 2, theta = theta, radius = 1 / 20 * na * ma);
  }
