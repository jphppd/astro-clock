include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>

na = sun_to_lunar_phases_4a_n;
nb = sun_to_lunar_phases_4b_n;
ma = sun_to_lunar_phases_3b_4a_mod;
mb = sun_to_lunar_phases_4b_5a_mod;

scale([global_scale, global_scale, global_scale])
  difference() {
    union() {
      default_gear(na, ma, invert = true);
      translate(v = [0, 0, gear_thickness])
        cylinder(r = fn_r_addendum(nb) * mb, h = 2 * layer_thickness);
      translate(v = [0, 0, 2 * layer_thickness + gear_thickness - eps])
        default_gear(nb, mb, invert = true);
    }
    circular_hole(radius = gears_shaft_radius, length = 4);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 3 / 5 * na * ma / 2, theta = theta, radius = 1 / 10 * na * ma, length = 1);

    for(theta = [360 / 12:360 / 6:360])
      circular_hole(r = 4 / 5 * na * ma / 2, theta = theta, radius = 1 / 24 * na * ma, length = 1);
  }
