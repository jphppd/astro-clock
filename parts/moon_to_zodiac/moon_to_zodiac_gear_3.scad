include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/moon_to_zodiac/env.scad>

na = moon_to_zodiac_3a_n;
nb = moon_to_zodiac_3b_n;
ma = moon_to_zodiac_2b_3a_mod;
mb = moon_to_zodiac_3b_4a_mod;

scale([global_scale, global_scale, global_scale])
  difference() {
    union() {
      default_gear(na, ma);
      translate(v=[0, 0, gear_thickness - eps])
        default_gear(nb, mb);
    }
    circular_hole(radius=gears_shaft_radius, length=2);

    for (theta = [0:360 / 8:360])
      circular_hole(r=5 / 8 * nb * mb / 2, theta=theta, radius=1 / 14 * nb * mb, length=2);
  }
