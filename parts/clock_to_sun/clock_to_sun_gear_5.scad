include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

na = clock_to_sun_5a_n;
nb = clock_to_sun_5b_n;
ma = clock_to_sun_4b_5a_mod;
mb = clock_to_sun_5b_6a_mod;

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      default_gear(na, ma, invert=true);
      translate(v=[0, 0, gear_thickness - eps])
        default_gear(nb, mb, invert=true);
    }
    circular_hole(radius=gears_shaft_radius, length=2);

    for (theta = [0:360 / 10:360])
      circular_hole(r=2 / 3 * na * ma / 2, theta=theta, radius=1 / 15 * na * ma);

    for (theta = [360 / 20:360 / 10:360])
      circular_hole(r=4 / 9 * na * ma / 2, theta=theta, radius=1 / 30 * na * ma);

    for (theta = [360 / 20:360 / 10:360])
      circular_hole(r=15 / 18 * na * ma / 2, theta=theta, radius=1 / 30 * na * ma);

    for (theta = [0:360 / 10:360])
      circular_hole(r=2 / 3 * nb * mb / 2, theta=theta, radius=1 / 20 * nb * mb, length=2);
  }
