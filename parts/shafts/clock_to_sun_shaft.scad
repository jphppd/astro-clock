include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>

scale([global_scale, global_scale, global_scale]) {

  translate([0, 0, -5 * layer_thickness])
    circular_shaft(length=3);

  translate([0, 0, -2 * layer_thickness])
    hex_shaft(circumradius=gears_shaft_radius + spacer_sleeve / 3, stellation_radius=gears_shaft_radius);

  translate([0, 0, -layer_thickness])
    circular_shaft(radius=gears_shaft_radius + spacer_sleeve / 3);

  hex_shaft(circumradius=gears_shaft_radius + spacer_sleeve / 3, stellation_radius=gears_shaft_radius);

  translate([0, 0, layer_thickness])
    circular_shaft(length=3);
}
