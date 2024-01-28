module translate_polar(r, theta, z = 0)translate(v = [r * cos(theta), r * sin(theta), z])
  children();

module circular_shaft(radius = gears_shaft_radius, length = 1, r = 0, theta = 0, $fn = 128) //
translate_polar(r, theta, 0)
  cylinder(h = length * layer_thickness, r = radius - half_allowance, $fn = $fn);

module circular_hole(radius = gears_shaft_radius, length = 1, r = 0, theta = 0, $fn = 128) //
translate_polar(r, theta, -eps)
  cylinder(h = length * layer_thickness + 2 * eps, r = radius + half_allowance, $fn = $fn);

module hex_shaft(apothem = 0, circumradius = 0, length = 1, r = 0, theta = 0)circular_shaft(
//
radius = max(apothem / cos(180 / $fn), circumradius), //
length = length, r = r, theta = theta, $fn = 6);

module hex_hole(apothem = 0, circumradius = 0, length = 1, r = 0, theta = 0)circular_hole(
//
radius = max(apothem / cos(180 / $fn), circumradius), //
length = length, r = r, theta = theta, $fn = 6);

module dovetail()translate([0, 1 / 8, 0])
  polygon([
    [1 / 8, 0], 
    [3 / 16, -1 / 2], 
    [-3 / 16, -1 / 2], 
    [-1 / 8, 0], 
  ]);

module fillet(inner_radius, outer_radius)let(fillet_radius = outer_radius - inner_radius)
  rotate_extrude()
    union() {
      square([inner_radius + eps, fillet_radius]);
      translate([outer_radius, fillet_radius, 0])
        rotate(180)
          difference() {
            square(fillet_radius);
            circle(fillet_radius);
          }
    }
