include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/moon_to_zodiac/env.scad>

na = moon_to_zodiac_4a_n;
nb = moon_to_zodiac_4b_n;
m = moon_to_zodiac_mod;

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      default_gear(na, m, invert = true);
      translate(v = [0, 0, gear_thickness - eps])
        default_gear(nb, m, invert = true);
    }
    circular_hole(radius = gears_shaft_radius, length = 2);

    for(theta = [0:360 / 8:360])
      circular_hole(r = 5 / 8 * nb * m / 2, theta = theta, radius = 1 / 14 * nb * m, length = 2);

    for(theta = [0:360 / 20:360])
      circular_hole(r = 5 / 6 * na * m / 2, theta = theta, radius = 1 / 25 * na * m);
  }
