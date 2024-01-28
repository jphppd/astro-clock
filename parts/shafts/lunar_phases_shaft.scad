include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>

shaft_length = (3 + 5);

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      translate([0, 0, shaft_length * layer_thickness])
        hex_shaft(circumradius = lunar_phases_shaft_radius);
      circular_shaft(radius = lunar_phases_shaft_radius, length = shaft_length);
      hex_shaft(apothem = lunar_phases_shaft_radius);
    }
    circular_hole(length = 2 + 2 * half_allowance / layer_thickness);
  }
