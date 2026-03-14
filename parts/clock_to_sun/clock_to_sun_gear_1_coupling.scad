include <../../utils/constants/constants.scad>
include <../../utils/constants/clock_to_sun/env.scad>
use <clock_to_sun_gear_1.module.scad>

scale([global_scale, global_scale, global_scale])
  shaft_to_gear_coupling();
