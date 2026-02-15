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

scale([global_scale, global_scale, 1])
  difference() {
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

