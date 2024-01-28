include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

spacer_length = carrier_3_offset - carrier_2_offset - 1;

scale([global_scale, global_scale, 1])
  spacer(spacer_length);
