include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>

module sun_to_lunar_phases(){}

module sun_to_lunar_phases_drill(){}

difference() {
  union() {
    base_structure();
    sun_to_lunar_phases();
  }
  sun_to_lunar_phases_drill();
}
