include <clamp.module.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/sun_to_lunar_phases/env.scad>
include <../../../parts/sun_to_lunar_phases/sun_to_lunar_phases_gear.module.scad>

n = sun_to_lunar_phases_6_n;
m = sun_to_lunar_phases_5b_6_mod;

r_platform = carrier_outer_radius + outer_annulus_sagitta / 2 + top_platform_height;
w_platform = r_platform * tan(clamp_angle + arc_half_angle_claw);


module platform()difference() {
  translate([-w_platform, -top_platform_height / 2, 0])
    cube([2 * w_platform, top_platform_height / 2, (carrier_3_offset - carrier_2_offset + 1) * layer_thickness]);

  translate([0, 0, 2 * layer_thickness + bevel_gear_center(n, m)])
    rotate([90, 0, 0])
      circular_hole(radius = lunar_phases_shaft_radius, length = 3);
}

scale([global_scale, global_scale, global_scale]) {
  rotate([0, 0, 180]) {
    for(theta = [-90 - clamp_angle, -90 + clamp_angle])
      rotate(theta)
        translate([carrier_outer_radius, 0, 0])
          clamp();
    for(tz = [carrier_2_offset - carrier_1_offset, carrier_3_offset - carrier_1_offset])
      translate([0, 0, tz * layer_thickness])
        arc_support(top_platform_height);
  }
  translate([0, r_platform, (carrier_2_offset - carrier_1_offset) * layer_thickness])
    platform();
}
