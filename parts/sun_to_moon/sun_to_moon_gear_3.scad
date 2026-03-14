include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_moon/env.scad>

n = sun_to_moon_3_n;
m = sun_to_moon_3_4_mod;
shaft_length = (carrier_2_offset - carrier_1_offset - 1);

scale([global_scale, global_scale, global_scale])
  difference() {
    union() {
      default_gear(n, m, invert=true);
      translate([0, 0, (shaft_length - 1) * layer_thickness])
        hex_shaft(apothem=gears_shaft_radius + spacer_sleeve);
      translate([0, 0, layer_thickness])
        circular_shaft(radius=gears_shaft_radius + 2 * spacer_sleeve, length=shaft_length - 2);
    }
    circular_hole(radius=gears_shaft_radius, length=shaft_length);

    rotate(360 / 12)for (theta = [0:360 / 6:360])
      circular_hole(r=1 / 2 * n * m / 2, theta=theta, radius=1 / 10 * n * m);

    for (theta = [0:360 / 6:360])
      circular_hole(r=8 / 11 * n * m / 2, theta=theta, radius=1 / 18 * n * m);
  }
