include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_1_n;
m = clock_to_sun_1_2a_mod;


difference() {
  scale([global_scale, global_scale, 1])
    union() {
      // Main gear
      translate([0, 0, -2 * half_allowance])
        default_gear(n, m, thickness = gear_thickness + 4 * half_allowance);

      // Lower support
      translate([0, 0, -(layer_thickness / 2 - half_allowance)])
        cylinder(r = fn_r_addendum(n) * m, h = layer_thickness / 2 - 3 * half_allowance);

      // Upper cone
      translate([0, 0, layer_thickness - 2 * half_allowance])
        cylinder(r1 = fn_r_dedendum(n) * m * 0.85, r2 = clock_shaft_radius, h = 5 * layer_thickness / 2);
    }

  // Motor shaft
  translate([0, 0, -layer_thickness / 2])
    cylinder(r = clock_shaft_radius + half_allowance, h = 16);

  // Transversal coupling with motor shaft
  translate([0, 0, layer_thickness + motor_shaft_diameter / 2 - 2 * half_allowance])
    rotate([0, 90, 0])
      cylinder(r = motor_shaft_diameter / 2 + half_allowance, h = 40, center = true);
}
