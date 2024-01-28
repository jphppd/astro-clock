include <../../utils/tympan.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/structure.scad>

scale([global_scale, global_scale, 1])
  linear_extrude(height = layer_thickness)
    offset(delta = -half_allowance)
      almucantar_half_sector(obs_latitude, -18, -12, -1, tympan_scale_factor);
