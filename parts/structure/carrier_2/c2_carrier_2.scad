use <c2_carrier.module.scad>

difference() {
  carrier();
  translate([0, 0, -500])
    cube(1000, center = true);
}
