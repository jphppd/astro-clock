include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/moon_to_zodiac/env.scad>

n = moon_to_zodiac_1_n;
m = moon_to_zodiac_1_2a_mod;

scale([global_scale, global_scale, global_scale])
  difference() {
    default_gear(n, m);
    hex_hole(apothem=1.5 * moon_shaft_radius);

    for (theta = [0:360 / 6:360])
      circular_hole(r=5 / 8 * n * m / 2, theta=theta, radius=1 / 8 * n * m);

    for (theta = [360 / 12:360 / 6:360])
      circular_hole(r=5 / 6 * n * m / 2, theta=theta, radius=1 / 25 * n * m);

    for (theta = [360 / 12:360 / 6:360])
      circular_hole(r=3 / 10 * n * m / 2, theta=theta, radius=1 / 25 * n * m);
  }
