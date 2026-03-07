include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/sun_to_lunar_phases/env.scad>
include <../../../utils/constants/sun_to_lunar_phases/structure.scad>
include <../../../parts/sun_to_lunar_phases/sun_to_lunar_phases_gear.module.scad>

n = sun_to_lunar_phases_6_n;
m = sun_to_lunar_phases_5b_6_mod;

module sun_to_lunar_phases() {
  for(angle = [0, sun_to_lunar_phases_2_theta, sun_to_lunar_phases_3_theta, sun_to_lunar_phases_4_theta]) {
    rotate(angle)
      spoke();
  }

  mirror([0, 0, 1]) {
    circular_shaft(r = sun_to_lunar_phases_2_r, theta = sun_to_lunar_phases_2_theta, length = 3, radius = gears_shaft_radius + spacer_sleeve);

    circular_shaft(r = sun_to_lunar_phases_3_r, theta = sun_to_lunar_phases_3_theta, length = 2, radius = gears_shaft_radius + spacer_sleeve);

    circular_shaft(r = sun_to_lunar_phases_4_r, theta = sun_to_lunar_phases_4_theta, length = 2, radius = gears_shaft_radius + spacer_sleeve);

    circular_shaft(r = sun_to_lunar_phases_5_r, theta = sun_to_lunar_phases_5_theta, length = 4, radius = gears_shaft_radius + spacer_sleeve);

    circular_shaft(r = sun_to_lunar_phases_5_r, theta = sun_to_lunar_phases_5_theta, length = 7);

    translate([sun_to_lunar_phases_5_r, 0, 4 * layer_thickness]) {
      translate([0, 0, -(bevel_gear_center(n, m) - layer_thickness)])
        rotate([0, 90, 0])
          cylinder(r = (gears_shaft_radius + spacer_sleeve) - half_allowance, h = bevel_gear_center(n, m) - layer_thickness);
    }
  }
}

module sun_to_lunar_phases_drill() {
  translate([0, 0, layer_thickness])
    mirror([0, 0, 1]) {
      circular_hole(r = sun_to_lunar_phases_2_r, theta = sun_to_lunar_phases_2_theta, length = 6);
      circular_hole(r = sun_to_lunar_phases_3_r, theta = sun_to_lunar_phases_3_theta, length = 6);
      circular_hole(r = sun_to_lunar_phases_4_r, theta = sun_to_lunar_phases_4_theta, length = 6);

      translate([sun_to_lunar_phases_5_r, 0, 5 * layer_thickness])
        let(depth = 2 * layer_thickness + half_allowance) {
          translate([bevel_gear_center(n, m) - layer_thickness - depth, 0, -(bevel_gear_center(n, m) - layer_thickness)])
            rotate([0, 90, 0])
              cylinder(r = lunar_phases_shaft_radius * 2 / 3 + half_allowance / 2, h = depth + eps);
        }
    }

  for(theta = [-20, 20])
    rotate(theta)
      circular_hole(r = carrier_outer_radius, theta = 0);
}

difference() {
  union() {
    base_structure();
    sun_to_lunar_phases();
  }
  sun_to_lunar_phases_drill();
}
