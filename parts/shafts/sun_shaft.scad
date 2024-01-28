include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/clock_to_sun/env.scad>

shaft_length = (carrier_3_offset - carrier_2_offset + 2 + 5 + 1);

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      circular_shaft(radius = sun_shaft_radius_lunar_nodes, length = shaft_length);
      translate([0, 0, 7 * layer_thickness])
        hex_shaft(circumradius = sun_shaft_radius_c3_hub, length = 1);
      translate([0, 0, 4 * layer_thickness])
        circular_shaft(radius = sun_shaft_radius_lunar_phases, length = 3);
      translate([0, 0, 2 * layer_thickness])
        hex_shaft(apothem = sun_shaft_radius, length = 2);
      translate([0, 0, layer_thickness])
        circular_shaft(radius = sun_shaft_radius, length = 1);
      hex_shaft(circumradius = sun_shaft_radius);
    }
    circular_hole(radius = zodiac_shaft_radius, length = shaft_length);
  }
