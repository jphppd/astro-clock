include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_1_n;
m = clock_to_sun_1_2a_mod;

module transversal_coupling_with_motos_shaft()translate([0, 0, 7 - layer_thickness])
  rotate([0, 90, 0])
    cylinder(r = motor_shaft_diameter / 2 + half_allowance, h = 60, center = true);

module motor_shaft()translate([0, 0, -layer_thickness - eps])
  cylinder(r = clock_shaft_radius + half_allowance, h = 16);

module shaft_to_gear_coupling_base(tolerance)scale([global_scale, global_scale, 1])
  translate([0, 0, -layer_thickness])
    hex_shaft( //
    circumradius = 0.8 * fn_r_dedendum(n) * m + tolerance, //
    length = 14 / layer_thickness + tolerance //
    );

module gear() {
  difference() {
    scale([global_scale, global_scale, 1]) {
      // Main gear
      translate([0, 0, -2 * half_allowance])
        default_gear(n, m, thickness = gear_thickness + 4 * half_allowance);

      // Lower support
      translate([0, 0, -(layer_thickness - half_allowance)])
        cylinder(r = fn_r_addendum(n) * m, h = layer_thickness - half_allowance);
    }
    shaft_to_gear_coupling_base(half_allowance);
  }
}

module shaft_to_gear_coupling()difference() {
  shaft_to_gear_coupling_base(-half_allowance);
  motor_shaft();
  transversal_coupling_with_motos_shaft();
}

module cap()difference() {
  // External cone
  translate([0, 0, layer_thickness])
    scale([global_scale, global_scale, 1])
      cylinder( //
      r1 = fn_r_addendum(n) * m, //
      r2 = gears_shaft_radius + spacer_sleeve, //
      h = 4 * layer_thickness - 2 * half_allowance //
      );

  shaft_to_gear_coupling_base(half_allowance);

  // Structure shaft
  circular_hole(radius = gears_shaft_radius, length = 5);
}
