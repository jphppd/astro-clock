include <../../../utils/machining.scad>
include <../../../utils/structure.scad>
include <../../../utils/constants/constants.scad>
include <../../../utils/constants/structure.scad>
include <clamp.module.scad>

difference() {
  clamp();
  translate([0, 0, -5])
    linear_extrude(1.7 + 5)
      square([40, 3.5], center = true);
}
