include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_moon/env.scad>

shaft_length = 4;

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      translate([0, 0, (shaft_length - 1) * layer_thickness])
        hex_shaft(apothem = gears_shaft_radius + spacer_sleeve + 1);
      translate([0, 0, layer_thickness])
        circular_shaft(radius = gears_shaft_radius + spacer_sleeve + 1, length = shaft_length - 2);
      hex_shaft(circumradius = gears_shaft_radius + spacer_sleeve + 1);
    }
    circular_hole(radius = gears_shaft_radius, length = shaft_length);
  }
