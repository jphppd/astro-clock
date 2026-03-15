include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_1_n;
m = clock_to_sun_1_2a_mod;

module transversal_coupling_with_motor_shaft() hull()for (z = [-1, 1])
    translate([0, 0, z * 0.2 / global_scale])
      rotate([0, 90, 0])
        cylinder(r=motor_coupling_hole_diameter / 2 + half_allowance, h=60, center=true);

module motor_shaft() cylinder(r=motor_shaft_radius + half_allowance, h=motor_shaft_height_above_carrier + eps);

module shaft_to_gear_coupling_base(tolerance) hex_shaft(
    circumradius=0.8 * fn_r_dedendum(n) * m + tolerance,
    length=(motor_shaft_height_above_carrier + half_allowance) / layer_thickness + tolerance
  );

module gear() {
  difference() {
    union() {
      default_gear(n, m, thickness=layer_thickness);
      translate([0, 0, layer_thickness]) cylinder(r=fn_r_addendum(n) * m, h=3 * layer_thickness);
    }
    shaft_to_gear_coupling_base(half_allowance);
    circular_hole(radius=gears_shaft_radius, length=4);
  }
}

module shaft_to_gear_coupling() difference() {
    shaft_to_gear_coupling_base(-half_allowance);
    motor_shaft();
    translate([0, 0, motor_coupling_shaft_height_above_carrier])
      transversal_coupling_with_motor_shaft();
  }
