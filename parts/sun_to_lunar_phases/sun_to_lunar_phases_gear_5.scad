include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>
include <sun_to_lunar_phases_gear.module.scad>

na = sun_to_lunar_phases_5a_n;
nb = sun_to_lunar_phases_5b_n;
ma = sun_to_lunar_phases_4b_5a_mod;
mb = sun_to_lunar_phases_5b_6_mod;

scale([global_scale, global_scale, global_scale])
  difference() {
    union() {
      default_gear(na, ma);
      translate([0, 0, gear_thickness])
        bevel_gear(nb, mb);
    }

    circular_hole(length=2);

    rotate(360 / 12)for (theta = [0:360 / 6:360])
      circular_hole(r=4 / 9 * na * ma / 2, theta=theta, radius=1 / 12 * na * ma);

    for (theta = [0:360 / 6:360])
      circular_hole(r=3 / 4 * na * ma / 2, theta=theta, radius=1 / 16 * na * ma);

    rotate(360 / 12)for (theta = [0:360 / 6:360])
      circular_hole(r=5 / 6 * na * ma / 2, theta=theta, radius=1 / 24 * na * ma);
  }
