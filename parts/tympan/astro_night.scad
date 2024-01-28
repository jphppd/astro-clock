include <../../utils/machining.scad>
include <../../utils/tympan.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/structure.scad>
include <../../utils/constants/sun_to_lunar_nodes/env.scad>
include <../../utils/constants/sun_to_lunar_phases/structure.scad>

scale([global_scale, global_scale, 1])
  difference() {
    linear_extrude(height = layer_thickness)
      offset(delta = -half_allowance)
        difference() {
          almucantar_half_sector(obs_latitude, -90, -18, 0, tympan_scale_factor);
          south_pole_to_capricorn(tympan_scale_factor);
        }
    circular_hole(r = sun_to_lunar_phases_3_r, theta = -90, radius = lunar_phases_shaft_radius);
  }
