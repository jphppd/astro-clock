include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/clock_to_sun/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module clock_to_sun() {
  for (angle = [clock_to_sun_2_theta, clock_to_sun_3_theta, clock_to_sun_4_theta, clock_to_sun_7_theta, clock_to_sun_8_theta])
    rotate(angle)
      spoke();
  circular_shaft(r=clock_to_sun_3_r, theta=clock_to_sun_3_theta, length=carrier_3_offset - carrier_2_offset);
  circular_shaft(r=clock_to_sun_4_r, theta=clock_to_sun_4_theta, length=carrier_3_offset - carrier_2_offset);
  circular_shaft(r=clock_to_sun_7_r, theta=clock_to_sun_7_theta, length=carrier_3_offset - carrier_2_offset);
}

module clock_to_sun_drill() {
  circular_hole(r=carrier_outer_radius, theta=0);
  circular_hole(r=clock_to_sun_2_r, theta=clock_to_sun_2_theta, radius=gears_shaft_radius + spacer_sleeve / 3);
}

difference() {
  union() {
    base_structure();
    clock_to_sun();
  }
  clock_to_sun_drill();
}
