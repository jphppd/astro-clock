include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_moon/env.scad>

shaft_length = (carrier_3_offset - carrier_1_offset + 1 + 5 + 3);

scale([global_scale, global_scale, 1]) {
  circular_shaft(radius = moon_shaft_radius, length = shaft_length);
  translate([0, 0, 3 * layer_thickness])
    circular_shaft(radius = moon_shaft_radius_zodiac + 2 * spacer_sleeve, length = 2);
  translate([0, 0, layer_thickness])
    hex_shaft(apothem = moon_shaft_radius, length = 2);
}
