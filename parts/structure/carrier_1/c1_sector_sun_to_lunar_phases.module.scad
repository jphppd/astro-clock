include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <../../../utils/constants/sun_to_lunar_phases/structure.scad>

module sun_to_lunar_phases() {
  for (angle = [-sun_to_lunar_phases_4_theta, sun_to_lunar_phases_4_theta])
    rotate(angle)
      spoke();
}

module sun_to_lunar_phases_drill(){}

difference() {
  union() {
    base_structure();
    sun_to_lunar_phases();
  }
  sun_to_lunar_phases_drill();
}
