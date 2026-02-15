include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/structure.scad>

// Motor case
motor_height = 21;
motor_outer_diameter_top = 50;
motor_outer_diameter_bottom = 49.6;
motor_case_bottom_height = 1;
screwhole_radius = 4.45 / 2;
cables_hole_center = motor_outer_diameter_bottom / 2 - 4.5;
wall_width = 2;

// Shaft
shaft_base_radius = 6.3;
shaft_base_height = 4.8;
shaft_position = 13;

// Screw plate
screw_plate_height = 1.4;
screw_plate_overhead = 6 - screwhole_radius;
screw_plate_width = 14.4;
screw_plate_hole_radius = 28.4;
screw_plate_hole_radius_delta = 0.1;
screw_plate_hole_theta = 83.3;
screw_plate_hole_theta_delta = 13.5647 / 2;

// Plugs and switch
plug_switch_height = 21;
plug_switch_length = 36;

// Computed elements
screw_plate_hole_radius_1 = screw_plate_hole_radius + screw_plate_hole_radius_delta;
screw_plate_hole_radius_2 = screw_plate_hole_radius - screw_plate_hole_radius_delta;
screw_plate_holes_theta_1 = screw_plate_hole_theta + screw_plate_hole_theta_delta;
screw_plate_holes_theta_2 = screw_plate_hole_theta - screw_plate_hole_theta_delta;

screw_plate_hole_1_x = screw_plate_hole_radius_1 * cos(screw_plate_holes_theta_1);
screw_plate_hole_1_y = screw_plate_hole_radius_1 * sin(screw_plate_holes_theta_1);
screw_plate_hole_2_x = screw_plate_hole_radius_2 * cos(screw_plate_holes_theta_2);
screw_plate_hole_2_y = screw_plate_hole_radius_2 * sin(screw_plate_holes_theta_2);
screw_plate_delta_theta = atan((screw_plate_hole_2_y - screw_plate_hole_1_y) / (screw_plate_hole_2_x - screw_plate_hole_1_x));

module screw_plate()for(i = [0, 1])
  mirror([0, i, 0])
    translate([(screw_plate_hole_2_x + screw_plate_hole_1_x) / 2, (screw_plate_hole_2_y + screw_plate_hole_1_y) / 2, 0])
      rotate(screw_plate_delta_theta)
        translate([-screw_plate_width / 2, -20, 0])
          square([screw_plate_width, screw_plate_overhead + 20]);

module screw_plate_case()minkowski() {
  screw_plate();
  circle(wall_width);
}

module place_pins() {
  for(y = [0, 1])
    mirror([0, y, 0]) {
      translate([screw_plate_hole_1_x, screw_plate_hole_1_y, 0])
        children();
      translate([screw_plate_hole_2_x, screw_plate_hole_2_y, 0])
        children();
    }
}

module main_case(wall_width)translate([0, shaft_position, 0])
  rotate(90)
    union() {
      translate([0, 0, -motor_height])
        difference() {
          // Case
          union() {
            translate([0, 0, -motor_case_bottom_height])
              cylinder(r = motor_outer_diameter_top / 2 + wall_width, h = motor_height + motor_case_bottom_height);

            translate([0, 0, motor_height - 4 * screw_plate_height])
              linear_extrude(4 * screw_plate_height)
                screw_plate_case();
          }
          // Main hole
          translate([0, 0, -10 * eps])
            cylinder(r1 = motor_outer_diameter_bottom / 2 + 2 * eps, r2 = motor_outer_diameter_top / 2 + 2 * eps, h = motor_height + 20 * eps);

          // Screw plate
          translate([0, 0, motor_height - screw_plate_height])
            linear_extrude(screw_plate_height + eps)
              screw_plate();

          // Cables hole
          translate([0, 0, -5])
            linear_extrude(10)
              offset(0.5)
                union() {
                  square([plug_switch_length, plug_switch_height], center = true);
                  translate([cables_hole_center, 0, 0])
                    square([5, 8], center = true);
                }

          place_pins()
            translate([0, 0, motor_height - 2 * screw_plate_height - eps])
              cylinder(h = 2 * screw_plate_height + eps, r = 1.03 * screwhole_radius);
        }

      // Pins
      place_pins()
        translate([0, 0, -2 * screw_plate_height - eps])
          cylinder(h = 3 * screw_plate_height + eps, r1 = screwhole_radius - eps, r2 = 0.92 * screwhole_radius);

    }

module main_cap()translate([0, shaft_position, 0])
  rotate(90) {
    difference() {
      union() {
        linear_extrude(layer_thickness)
          screw_plate_case();
        cylinder(r = motor_outer_diameter_top / 2 + wall_width, h = layer_thickness);
      }
      place_pins()
        cylinder(h = screw_plate_height + 4 * eps, r = screwhole_radius + 10 * eps);

      translate([-shaft_position, 0, 0])
        cylinder(r = shaft_base_radius, h = 10 * screw_plate_height);
    }
  }

main_case(wall_width);
