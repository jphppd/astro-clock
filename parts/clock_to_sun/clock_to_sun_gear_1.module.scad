include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_1_n;
m = clock_to_sun_1_2a_mod;

module transversal_coupling_with_motor_shaft() translate([0, 0, 7 - layer_thickness])
    rotate([0, 90, 0])
      cylinder(r=motor_shaft_diameter / 2 + half_allowance, h=60, center=true);

module motor_shaft() translate([0, 0, -layer_thickness - eps])
    cylinder(r=clock_shaft_radius + half_allowance, h=16);

module shaft_to_gear_coupling_base(tolerance) hex_shaft(
    //
    circumradius=0.8 * fn_r_dedendum(n) * m + tolerance, //
    length=14 / layer_thickness + tolerance //
  );

module gear() {
  difference() {
    union() {
      default_gear(n, m);
      translate([0, 0, layer_thickness])
        cylinder(r=fn_r_addendum(n) * m, h=2 * layer_thickness);
      circular_shaft(length=4, radius=gears_shaft_radius + spacer_sleeve);
    }
    shaft_to_gear_coupling_base(half_allowance);
    translate([0, 0, 3 * layer_thickness])
      circular_hole(radius=gears_shaft_radius, length=4);
  }
}

module shaft_to_gear_coupling() difference() {
    shaft_to_gear_coupling_base(-half_allowance);
    translate([0, 0, layer_thickness])
      motor_shaft();
    translate([0, 0, layer_thickness])
      transversal_coupling_with_motor_shaft();
  }
