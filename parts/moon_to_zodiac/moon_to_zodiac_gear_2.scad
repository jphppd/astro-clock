include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/moon_to_zodiac/env.scad>

na = moon_to_zodiac_2a_n;
nb = moon_to_zodiac_2b_n;
m = moon_to_zodiac_mod;

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      default_gear(nb, m);
      translate(v = [0, 0, gear_thickness - eps])
        default_gear(na, m);
    }
    circular_hole(radius = gears_shaft_radius, length = 2);

    for(theta = [0:360 / 8:360])
      circular_hole(r = 4 / 7 * na * m / 2, theta = theta, radius = 1 / 16 * na * m, length = 2);

    for(theta = [0:360 / 16:360])
      circular_hole(r = 4 / 5 * nb * m / 2, theta = theta, radius = 1 / 25 * nb * m);
  }
