include <../../../utils/constants/clock_to_sun/structure.scad>
include <clamp.module.scad>

clamp_angle = 360 / 10 + clock_to_sun_2_theta;

module arc_support()let(r1 = carrier_outer_radius + outer_annulus_sagitta / 2, r2 = carrier_outer_radius + outer_annulus_sagitta / 2 + 6, theta1 = -clamp_angle - arc_half_angle_claw, theta2 = clamp_angle + arc_half_angle_claw)
  rotate(-90)
    linear_extrude(layer_thickness)
      polygon(concat([
        for (theta = [theta1:(theta2 - theta1) / 32:theta2])
          [r1 * cos(theta), r1 * sin(theta)], 
      ], [
        for (theta = [theta2, theta1])
          [r2, r2 * tan(theta)], 
      ]));

scale([global_scale, global_scale, global_scale])
  difference() {
    union() {
      for(theta = [-90 - clamp_angle, -90 + clamp_angle])
        rotate(theta)
          translate([carrier_outer_radius, 0, 0])
            clamp();

      for(tz = [0, carrier_2_offset - carrier_1_offset, carrier_3_offset - carrier_1_offset])
        translate([0, 0, tz * layer_thickness])
          arc_support();
    }

    translate([0, -(carrier_outer_radius + outer_annulus_sagitta / 2), 0])
      cube([3.5 / global_scale, 3.4 / global_scale, 3 * layer_thickness], center = true);
  }
