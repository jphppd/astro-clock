include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_nodes/env.scad>

shaft_length = (2 + 5);

scale([global_scale, global_scale, 1])
  difference() {
    union() {
      circular_shaft(radius = lunar_nodes_shaft_radius, length = shaft_length);
      hex_shaft(apothem = lunar_nodes_shaft_radius);
    }
    circular_hole(radius = sun_shaft_radius_lunar_nodes, length = shaft_length);
  }
