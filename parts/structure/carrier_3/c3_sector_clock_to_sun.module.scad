include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/clock_to_sun/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module clock_to_sun() {
  for(angle = [clock_to_sun_2_theta, clock_to_sun_3_theta, clock_to_sun_4_theta]) {
    rotate(angle)
      spoke();
  }

  mirror([0, 0, 1]) {
    circular_shaft(r = clock_to_sun_2_r, theta = clock_to_sun_2_theta, length = 5, radius = gears_shaft_radius + spacer_sleeve);
    circular_shaft(r = clock_to_sun_3_r, theta = clock_to_sun_3_theta, length = 3, radius = gears_shaft_radius + spacer_sleeve);
    circular_shaft(r = clock_to_sun_4_r, theta = clock_to_sun_4_theta, length = 3, radius = gears_shaft_radius + spacer_sleeve);
  }
}

module clock_to_sun_drill() {
  translate([0, 0, layer_thickness])
    mirror([0, 0, 1]) {
      circular_hole(r = clock_to_sun_4_r, theta = clock_to_sun_4_theta, length = 7);
      circular_hole(r = clock_to_sun_3_r, theta = clock_to_sun_3_theta, length = 7);
      circular_hole(r = clock_to_sun_2_r, theta = clock_to_sun_2_theta, length = 7);
    }
  circular_hole(r = carrier_outer_radius, theta = 0);
}

scale([global_scale, global_scale, 1])
  translate([0, 0, layer_thickness])
    rotate(180, [1, 0, 0])
      difference() {
        union() {
          base_structure();
          clock_to_sun();
        }
        clock_to_sun_drill();
      }
