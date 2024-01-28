include <../../utils/machining.scad>
include <../../utils/tympan.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/structure.scad>

scale([global_scale, global_scale, 1])
  difference() {
    linear_extrude(height = layer_thickness)
      offset(delta = -half_allowance)
        south_pole_to_capricorn(tympan_scale_factor);
    circular_hole(radius = lunar_nodes_shaft_radius);
  }
