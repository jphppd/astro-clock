include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module arc(demi_angle, r1, r2)polygon([
  for (theta = [-demi_angle:0.1:demi_angle])
    [r1 * cos(theta), r1 * sin(theta)], 
  for (theta = [demi_angle:-0.1:-demi_angle])
    [r2 * cos(theta), r2 * sin(theta)], 
]);

clamp_height = carrier_3_offset + 1 + half_allowance / layer_thickness;
clamp_width = 2;
inner_radius = carrier_outer_radius - outer_annulus_sagitta / 2 - 3 * half_allowance;
outer_radius = carrier_outer_radius + outer_annulus_sagitta / 2;
arc_half_angle_claw = 3;
arc_half_angle_centering_claw = 2.6;

module claw()difference() {
  union() {
    linear_extrude(clamp_width)
      arc(arc_half_angle_claw, inner_radius - clamp_width, inner_radius);
    translate([0, 0, -clamp_width])
      linear_extrude(clamp_width)
        arc(arc_half_angle_claw, inner_radius - clamp_width, outer_radius + clamp_width);
  }
  translate([0, 0, -layer_thickness / 2])
    scale([1, 1.02, 1])
      spoke();
}

module centering_claw(z, thickness)translate([0, 0, z * layer_thickness])
  linear_extrude(thickness * layer_thickness)
    difference() {
      arc(arc_half_angle_centering_claw, carrier_outer_radius - outer_annulus_sagitta / 5, outer_radius + eps);
      translate([carrier_outer_radius, 0, 0])
        circle(r = outer_annulus_sagitta / 2);
    }

scale([global_scale, global_scale, 1])
  translate([-carrier_outer_radius, 0, 0]) {
    linear_extrude(clamp_height * layer_thickness)
      arc(arc_half_angle_claw, outer_radius, outer_radius + clamp_width);
    claw();
    translate([0, 0, clamp_height * layer_thickness])
      rotate([180, 0, 0])
        claw();

    centering_claw((carrier_1_offset + carrier_2_offset) / 2 - 1 / 2, 2);
    centering_claw((carrier_2_offset + carrier_3_offset) / 2, 1);
  }
