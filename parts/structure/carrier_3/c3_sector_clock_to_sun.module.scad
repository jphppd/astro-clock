include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/clock_to_sun/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module clock_to_sun() {
  for (angle = [clock_to_sun_2_theta, clock_to_sun_3_theta, clock_to_sun_4_theta, clock_to_sun_7_theta, clock_to_sun_8_theta, 2 * clock_to_sun_1_theta - clock_to_sun_2_theta])
    rotate(angle)
      spoke();

  mirror([0, 0, 1]) {
    circular_shaft(r=clock_to_sun_2_r, theta=clock_to_sun_2_theta, length=4, radius=gears_shaft_radius + spacer_sleeve);
    circular_shaft(r=clock_to_sun_3_r, theta=clock_to_sun_3_theta, length=1, radius=gears_shaft_radius + spacer_sleeve);
    circular_shaft(r=clock_to_sun_4_r, theta=clock_to_sun_4_theta, length=1, radius=gears_shaft_radius + spacer_sleeve);
    circular_shaft(r=clock_to_sun_7_r, theta=clock_to_sun_7_theta, length=4, radius=gears_shaft_radius + spacer_sleeve);
  }
}

module clock_to_sun_drill() {
  translate([0, 0, half_allowance])
    mirror([0, 0, 1]) {
      circular_hole(r=clock_to_sun_2_r, theta=clock_to_sun_2_theta, length=carrier_2_width);
      circular_hole(r=clock_to_sun_3_r, theta=clock_to_sun_3_theta, length=carrier_2_width);
      circular_hole(r=clock_to_sun_4_r, theta=clock_to_sun_4_theta, length=carrier_2_width);
      circular_hole(r=clock_to_sun_7_r, theta=clock_to_sun_7_theta, length=carrier_2_width);
    }
  circular_hole(r=carrier_outer_radius, theta=0);
}

translate([0, 0, layer_thickness])
  rotate(180, [1, 0, 0])
    difference() {
      union() {
        base_structure();
        clock_to_sun();
      }
      clock_to_sun_drill();
    }
