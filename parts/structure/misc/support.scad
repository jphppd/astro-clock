include <clamp.module.scad>

scale([global_scale, global_scale, global_scale])
  translate([0, 0, -carrier_2_offset * layer_thickness])
    difference() {
      union() {
        for (theta = [-90 - clamp_angle, -90 + clamp_angle])
          rotate(theta)
            translate([carrier_outer_radius, 0, 0])
              clamp();

        for (tz = [0, carrier_2_offset - carrier_1_offset, carrier_3_offset - carrier_1_offset])
          translate([0, 0, tz * layer_thickness])
            arc_support(bottom_support_height);
      }

      translate([0, -(carrier_outer_radius + outer_annulus_sagitta / 2), carrier_3_offset * layer_thickness])
        cube([3.5 / global_scale, 3.4 / global_scale, 3 * layer_thickness], center=true);
    }
