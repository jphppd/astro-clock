include <clamp.module.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/sun_to_lunar_phases/env.scad>
include <../../../parts/sun_to_lunar_phases/sun_to_lunar_phases_gear.module.scad>

r_platform = carrier_outer_radius + outer_annulus_sagitta / 2 + top_platform_height;
r_half_moon = r_platform + 5 + moon_radius;

n = sun_to_lunar_phases_6_n;
m = sun_to_lunar_phases_5b_6_mod;
z_half_moon = (2 - carrier_2_offset) * layer_thickness + bevel_gear_center(n, m);

module half_moon() difference() {
    sphere(r=moon_radius);
    rotate([90, 0, 0])
      cylinder(r=lunar_phases_shaft_radius, h=moon_radius);
    translate([0, 0, -moon_radius])
      cube(2 * moon_radius, center=true);
  }
