include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_6b_n;
m = clock_to_sun_6b_7_mod;
shaft_length = 4;

scale([global_scale, global_scale, global_scale])
  difference() {
    union() {
      default_gear(n, m);
      translate([0, 0, layer_thickness])
        circular_shaft(radius = gears_shaft_radius + spacer_sleeve + 1, length = shaft_length - 2);
      translate([0, 0, (shaft_length - 1) * layer_thickness])
        hex_shaft(circumradius = gears_shaft_radius + spacer_sleeve - 0.5);
    }
    circular_hole(radius = gears_shaft_radius, length = shaft_length);
  }
;
