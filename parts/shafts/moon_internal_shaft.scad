include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_moon/env.scad>

shaft_length = (carrier_2_offset - carrier_1_offset - 1);

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      translate([0, 0, (shaft_length - 1) * layer_thickness])
        hex_shaft(apothem = gears_shaft_radius + spacer_sleeve);
      translate([0, 0, layer_thickness])
        circular_shaft(radius = gears_shaft_radius + 2 * spacer_sleeve, length = shaft_length - 2);
      hex_shaft(apothem = gears_shaft_radius + spacer_sleeve);
    }
    circular_hole(radius = gears_shaft_radius, length = shaft_length);
  }
