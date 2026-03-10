include <clamp.module.scad>
include <half_moon.module.scad>

scale([global_scale, global_scale, global_scale])
  translate([0, r_half_moon, (carrier_2_offset - carrier_1_offset) * layer_thickness + z_half_moon])
    half_moon();
