include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/clock_to_sun/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module clock_to_sun() {
  for (angle = [0, clock_to_sun_1_theta, clock_to_sun_2_theta, 2 * clock_to_sun_1_theta - clock_to_sun_2_theta]) {
    rotate(angle)
      spoke();
  }

  circular_shaft(r=clock_to_sun_1_r, theta=clock_to_sun_1_theta, length=carrier_2_offset - carrier_1_offset - motor_shaft_height_above_carrier / layer_thickness - half_allowance, radius=gears_shaft_radius);
  circular_shaft(r=clock_to_sun_2_r, theta=clock_to_sun_2_theta, length=4, radius=gears_shaft_radius + spacer_sleeve);

  circular_shaft(r=carrier_outer_radius, theta=0, length=carrier_3_offset + 1);
  translate([carrier_outer_radius, 0, layer_thickness])
    fillet(gears_shaft_radius - half_allowance, gears_shaft_radius + 3);
}

module clock_to_sun_drill() {
  translate([0, 0, layer_thickness - half_allowance])
    circular_hole(r=clock_to_sun_2_r, theta=clock_to_sun_2_theta, length=4, radius=gears_shaft_radius);
}

difference() {
  union() {
    base_structure();
    clock_to_sun();
  }
  clock_to_sun_drill();
}
