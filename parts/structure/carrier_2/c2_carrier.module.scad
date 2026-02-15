include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/moon_to_zodiac/structure.scad>
include <../../../utils/constants/clock_to_sun/structure.scad>
include <../../../utils/constants/sun_to_moon/structure.scad>
include <../../../utils/constants/sun_to_lunar_nodes/structure.scad>
include <../../../utils/constants/sun_to_lunar_phases/structure.scad>
use <c2_sector_moon_to_zodiac.module.scad>
use <c2_sector_sun_to_moon.module.scad>
use <c2_sector_clock_to_sun.module.scad>
use <c2_sector_sun_to_lunar_nodes.module.scad>
use <c2_sector_sun_to_lunar_phases.module.scad>
include <../../motor/motor.module.scad>

module carrier_without_motor() {
  difference() {
    union() {
      base_structure_complete(sun_shaft_radius);
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

    rotate(-90)
      circular_hole(r = carrier_outer_radius, theta = 0);
  }
}


module annular_sector_mask(theta1, theta2)let( //
r1 = annulus_middle(3)[2], //
r2 = annulus_middle(3)[3] - 2 //
)
  polygon(concat( //
  [
    for (theta = [theta1:0.2:theta2])
      [r1 * cos(theta), r1 * sin(theta)]
  ], [
    for (theta = [theta2:-0.2:theta1])
      [r2 * cos(theta), r2 * sin(theta)]
  ]));


module carrier()translate([0, 0, -layer_thickness / 2])
  scale([global_scale, global_scale, 1]) {
    carrier_without_motor();

    difference() {
      // Mask for the motor cap
      union()
        let( //
        delta_theta = clock_to_sun_theta + clock_to_sun_2_theta - 270, //
        theta1 = 270 - delta_theta, //
        theta2 = 270 + delta_theta //
        ) {
          linear_extrude(layer_thickness)
            annular_sector_mask(theta1, theta2);

          translate([0, -clock_to_sun_1_r, 0])
            scale([1 / global_scale, 1 / global_scale, 1])
              main_cap();

        }

      // Drill pins in the motor cap
      translate([0, -clock_to_sun_1_r + shaft_position / global_scale, 0])
        rotate(90)
          scale([1 / global_scale, 1 / global_scale, 1]) {

            place_pins()
              cylinder(h = 3 * layer_thickness + 4 * eps, r = screwhole_radius + 10 * eps);

            translate([-shaft_position, 0, 0])
              cylinder(r = shaft_base_radius, h = 10 * screw_plate_height);
          }



    }
  }

carrier();
