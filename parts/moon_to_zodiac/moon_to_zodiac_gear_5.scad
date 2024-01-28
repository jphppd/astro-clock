include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/moon_to_zodiac/env.scad>

n = moon_to_zodiac_5_n;
m = moon_to_zodiac_mod;

scale([global_scale, global_scale, 1])
  difference() {
    default_gear(n, m);
    hex_hole(apothem = zodiac_shaft_radius);

    rotate(360 / 12)
      for(theta = [0:360 / 6:360])
        circular_hole(r = 5 / 8 * n * m / 2, theta = theta, radius = 1 / 10 * n * m);

    for(theta = [0:360 / 6:360])
      circular_hole(r = 4 / 5 * n * m / 2, theta = theta, radius = 1 / 25 * n * m);
  }
