include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_2a_n;
m = clock_to_sun_1_2a_mod;

scale([global_scale, global_scale, global_scale])
  difference() {
    default_gear(n, m, invert=true);

    hex_hole(circumradius=gears_shaft_radius + spacer_sleeve / 3, stellation_radius=gears_shaft_radius);

    for (theta = [360 / 12:360 / 6:360])
      circular_hole(r=5 / 9 * n * m / 2, theta=theta, radius=1 / 9 * n * m);

    for (theta = [0:360 / 6:360])
      circular_hole(r=2 / 9 * n * m / 2, theta=theta, radius=1 / 32 * n * m);

    for (theta = [0:360 / 6:360])
      circular_hole(r=7 / 9 * n * m / 2, theta=theta, radius=1 / 24 * n * m);
  }
