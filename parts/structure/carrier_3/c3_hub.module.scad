include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

scale([global_scale, global_scale, 1])
  hub(sun_shaft_radius_c3_hub);
