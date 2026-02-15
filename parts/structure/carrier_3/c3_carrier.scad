include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/moon_to_zodiac/structure.scad>
include <../../../utils/constants/clock_to_sun/structure.scad>
include <../../../utils/constants/sun_to_moon/structure.scad>
include <../../../utils/constants/sun_to_lunar_nodes/structure.scad>
include <../../../utils/constants/sun_to_lunar_phases/structure.scad>
use <c3_sector_moon_to_zodiac.module.scad>
use <c3_sector_sun_to_moon.module.scad>
use <c3_sector_clock_to_sun.module.scad>
use <c3_sector_sun_to_lunar_nodes.module.scad>
use <c3_sector_sun_to_lunar_phases.module.scad>

scale([global_scale, global_scale, 1])
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

    rotate(-90)
      circular_hole(r = carrier_outer_radius, theta = 0);
  }
