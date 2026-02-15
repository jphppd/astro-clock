include <../../utils/gear.scad>
include <../../utils/machining.scad>
include <../../utils/constants/clock_to_sun/env.scad>
include <../../utils/constants/constants.scad>

n = clock_to_sun_1_n;
m = clock_to_sun_1_2a_mod;


translate([0, 0, layer_thickness - 2 * half_allowance])
  difference() {
    scale([global_scale, global_scale, 1])
      difference() {
        // External cone
        cylinder(r1 = fn_r_addendum(n) * m, r2 = gears_shaft_radius + spacer_sleeve, h = 4 * layer_thickness - 5 * half_allowance);

        // Internal cone
        translate([0, 0, -eps])
          cylinder(r1 = fn_r_dedendum(n) * m * 0.85 + 2 * half_allowance, r2 = clock_shaft_radius + 2 * half_allowance, h = 5 * layer_thickness / 2);

        // Structure shaft
        circular_hole(radius = gears_shaft_radius, length = 4);
      }

    // Clock motor shaft radius
    translate([0, 0, -layer_thickness / 2])
      cylinder(r = clock_shaft_radius + half_allowance, h = 16);
  }
