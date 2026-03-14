include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/moon_to_zodiac/env.scad>

shaft_length = (carrier_3_offset - carrier_2_offset + 10);

scale([global_scale, global_scale, global_scale])
  difference() {
    union() {
      circular_shaft(radius=zodiac_shaft_radius, length=shaft_length);
      hex_shaft(apothem=1.5 * zodiac_shaft_radius);
    }
    circular_hole(radius=moon_shaft_radius, length=shaft_length);
  }
