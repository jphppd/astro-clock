include <../../utils/constants/structure.scad>
include <../../utils/constants/sun_to_lunar_phases/structure.scad>
include <../../parts/sun_to_lunar_phases/sun_to_lunar_phases_gear.module.scad>

n = sun_to_lunar_phases_6_n;
m = sun_to_lunar_phases_5b_6_mod;

middle_shaft_length = carrier_outer_radius + outer_annulus_sagitta / 2 - sun_to_lunar_phases_6_r - bevel_gear_center(n, m) + top_platform_height + 5 + moon_radius;

scale([global_scale, global_scale, global_scale]) {
  circular_shaft(radius=lunar_phases_shaft_radius, length=middle_shaft_length / layer_thickness);
  translate([0, 0, -layer_thickness])
    hex_shaft(circumradius=lunar_phases_shaft_radius, length=layer_thickness);
  translate([0, 0, -3 * layer_thickness])
    circular_shaft(radius=lunar_phases_shaft_radius * 2 / 3, length=2);
}
