include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/moon_to_zodiac/structure.scad>
include <../../../utils/constants/clock_to_sun/structure.scad>
include <../../../utils/constants/sun_to_moon/structure.scad>
include <../../../utils/constants/sun_to_lunar_nodes/structure.scad>
include <../../../utils/constants/sun_to_lunar_phases/structure.scad>
include <../../motor/motor.module.scad>
use <c3_sector_moon_to_zodiac.module.scad>
use <c3_sector_sun_to_moon.module.scad>
use <c3_sector_clock_to_sun.module.scad>
use <c3_sector_sun_to_lunar_nodes.module.scad>
use <c3_sector_sun_to_lunar_phases.module.scad>

clamp_angle = 360 / 10 + clock_to_sun_2_theta;

module carrier_without_motor()
  difference() {
    union() {
      base_structure_complete(sun_shaft_radius_c3_hub);
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

    for (theta = [-90 - clamp_angle, -90 + clamp_angle, 90 - clamp_angle, 90 + clamp_angle])
      rotate(theta)
        circular_hole(r=carrier_outer_radius, theta=0);
  }

module carrier() difference() {
    union() {
      difference() {
        carrier_without_motor();
      }
      mirror([0, 0, 1])
        translate([0, -clock_to_sun_1_r, 0])
          translate([0, 0, 6 * layer_thickness])
            rotate(-90)
              main_case(wall_width);
    }

    translate([0, -eps, 0])
      linear_extrude(layer_thickness + 1.7 / global_scale + eps)
        translate([0, -carrier_outer_radius])
          square([3.5 / global_scale, 40], center=true);
  }

scale([global_scale, global_scale, global_scale])
  carrier();
