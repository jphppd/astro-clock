include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/moon_to_zodiac/structure.scad>
include <../../../utils/constants/clock_to_sun/structure.scad>
include <../../../utils/constants/sun_to_moon/structure.scad>
include <../../../utils/constants/sun_to_lunar_nodes/structure.scad>
include <../../../utils/constants/sun_to_lunar_phases/structure.scad>
use <c1_sector_moon_to_zodiac.module.scad>
use <c1_sector_sun_to_moon.module.scad>
use <c1_sector_clock_to_sun.module.scad>
use <c1_sector_sun_to_lunar_nodes.module.scad>
use <c1_sector_sun_to_lunar_phases.module.scad>
include <../../motor/motor.module.scad>

module carrier_without_motor()difference() {
  union() {
    base_structure_complete(moon_shaft_radius);
    rotate(moon_to_zodiac_theta)
      moon_to_zodiac();
    rotate(sun_to_moon_theta)
      sun_to_moon();
    rotate(clock_to_sun_theta)
      clock_to_sun();
    rotate(sun_to_lunar_nodes_theta)
      sun_to_lunar_nodes();
    rotate(sun_to_lunar_phases_theta)
      sun_to_lunar_phases();

    rotate(-90) {
      circular_shaft(r = carrier_outer_radius, theta = 0, length = carrier_3_offset + 1);
      translate([carrier_outer_radius, 0, layer_thickness])
        fillet(gears_shaft_radius - half_allowance, gears_shaft_radius + 3);
    }
  }

  rotate(moon_to_zodiac_theta)
    moon_to_zodiac_drill();
  rotate(sun_to_moon_theta)
    sun_to_moon_drill();
  rotate(clock_to_sun_theta)
    clock_to_sun_drill();
  rotate(sun_to_lunar_nodes_theta)
    sun_to_lunar_nodes_drill();
  rotate(sun_to_lunar_phases_theta)
    sun_to_lunar_phases_drill();
}


module carrier()difference() {
  union() {
    scale([global_scale, global_scale, 1]) {
      carrier_without_motor();
      motor_support();
    }

    translate([0, -clock_to_sun_1_r * global_scale, 0]) {
      translate([0, 0, 7 * layer_thickness])
        rotate(90)
          main_case(wall_width);
      case_holder(wall_width, 2 * layer_thickness - half_allowance);
    }
  }

  translate([0, -eps, 0])
    linear_extrude(1.7 + eps)
      translate([0, -clock_to_sun_1_r * global_scale - 21])
        square([3.5, 40], center = true);
}

carrier();
