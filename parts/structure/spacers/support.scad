include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <clamp.module.scad>

module arc_support()let(r1 = carrier_outer_radius + outer_annulus_sagitta / 2, r2 = carrier_outer_radius + outer_annulus_sagitta / 2 + 6, theta1 = -13 - arc_half_angle_claw, theta2 = 13 + arc_half_angle_claw)
  rotate(-90)
    linear_extrude(layer_thickness)
      polygon(concat([
        for (theta = [theta1:1:theta2])
          [r1 * cos(theta), r1 * sin(theta)]
      ], [
        for (theta = [theta2:-1:theta1])
          [r2, r2 * tan(theta)]
      ]));

difference() {
  union() {
    for(theta = [-90 - 13, -90 + 13])
      rotate(theta)
        translate([carrier_outer_radius * global_scale, 0, 0])
          clamp();


    for(tz = [0, carrier_2_offset - carrier_1_offset, carrier_3_offset - carrier_1_offset])
      translate([0, 0, tz * layer_thickness])
        scale([global_scale, global_scale, 1])
          arc_support();
  }

  translate([0, -(carrier_outer_radius + outer_annulus_sagitta / 2) * global_scale, 0])
    cube([3.5, 3.4, 3 * layer_thickness], center = true);
}
