include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

spacer_length = carrier_2_offset - carrier_1_offset - 1;

scale([global_scale, global_scale, 1])
  difference() {
    spacer(spacer_length);
    fillet(gears_shaft_radius - half_allowance, outer_annulus_sagitta / 2);
  }
