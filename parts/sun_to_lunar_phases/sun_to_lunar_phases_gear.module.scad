include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/sun_to_lunar_phases/env.scad>

function bevel_gear_center(n, m) =
  (n / 2 + 1) * m;

module bevel_gear(n, m)let(h = (fn_r_addendum(n) - fn_r_pitch(n)) * m) {
  cylinder(r = gears_shaft_radius + spacer_sleeve, h = layer_thickness);
  linear_extrude(h)
    projection()
      default_gear(n, m, bevel_cone_angle = 45);
  translate([0, 0, h])
    default_gear(n, m, layer_thickness, bevel_cone_angle = 45);
}
