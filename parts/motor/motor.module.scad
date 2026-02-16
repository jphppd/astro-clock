include <../../utils/machining.scad>
include <../../utils/constants/constants.scad>
include <../../utils/constants/structure.scad>

// Motor case
wall_width = 2.5;
motor_height = 21;
motor_outer_diameter_top = 50;
motor_outer_diameter_bottom = 49.6;
motor_case_bottom_height = 7 * layer_thickness - motor_height;
screwhole_radius = 4.45 / 2;
cables_hole_center = motor_outer_diameter_bottom / 2 - 4.5;

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
plug_switch_length = 36.5;

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

module screw_plate_case(wall_width)offset(wall_width)
  screw_plate();

module place_pins() {
  for(y = [0, 1])
    mirror([0, y, 0]) {
      translate([screw_plate_hole_1_x, screw_plate_hole_1_y, 0])
        children();
      translate([screw_plate_hole_2_x, screw_plate_hole_2_y, 0])
        children();
    }
}

module top_contour_w_screw(wall_width)difference() {
  union() {
    circle(motor_outer_diameter_top / 2 + wall_width);
    screw_plate_case(wall_width);
  }
  circle(motor_outer_diameter_top / 2 + half_allowance);
  screw_plate();
}

module top_contour_wo_screw(wall_width)difference() {
  union() {
    circle(motor_outer_diameter_top / 2 + wall_width);
    screw_plate_case(wall_width);
  }
  circle(motor_outer_diameter_top / 2 + half_allowance);
}

module top_contour(wall_width)translate([0, 0, -4 * screw_plate_height]) {
  translate([0, 0, 3 * screw_plate_height - eps])
    linear_extrude(screw_plate_height + eps)
      top_contour_w_screw(wall_width);

  difference() {
    linear_extrude(3 * screw_plate_height - eps)
      top_contour_wo_screw(wall_width);
    place_pins()
      translate([0, 0, 2 * screw_plate_height])
        cylinder(h = screw_plate_height + eps, r = screwhole_radius + half_allowance / 2);
  }

  place_pins()
    translate([0, 0, 2 * screw_plate_height - eps])
      cylinder(h = 2 * screw_plate_height + layer_thickness + eps, r1 = screwhole_radius - eps, r2 = 0.92 * screwhole_radius);
}

module motor_cylinder(wall_width, top_height = 0)translate([0, 0, -motor_height])
  difference() {
    cylinder( //
    r = motor_outer_diameter_top / 2 + wall_width, //
    h = motor_height - top_height //
    );
    translate([0, 0, -3 * eps])
      cylinder( //
      r1 = motor_outer_diameter_bottom / 2 + half_allowance, //
      r2 = motor_outer_diameter_top / 2 + half_allowance, //
      h = motor_height - top_height + 6 * eps);
  }


module plug_hole()circle(r = plug_switch_length / 2 + 2);

module bottom(wall_width)translate([0, 0, -motor_height - motor_case_bottom_height])
  linear_extrude(motor_case_bottom_height)
    difference() {
      circle(r = motor_outer_diameter_top / 2 + wall_width);


      union() {
        plug_hole();
        translate([cables_hole_center, 0, 0])
          offset(0.5)
            square([5, 8], center = true);
      }
    }


module main_case(wall_width)translate([shaft_position, 0, 0]) {
  top_contour(wall_width);
  motor_cylinder(wall_width, 4 * screw_plate_height);
  bottom(wall_width);
}

module main_cap(wall_width)linear_extrude(layer_thickness)
  translate([shaft_position, 0, 0])
    difference() {
      union() {
        screw_plate_case(wall_width);
        circle(r = motor_outer_diameter_top / 2 + wall_width);
      }
      place_pins()
        circle(r = screwhole_radius + 10 * eps);
      translate([-shaft_position, 0, 0])
        circle(r = shaft_base_radius);
    }


module cap_holder(width, height, tolerance)mirror([0, 0, 1])
  translate([0, shaft_position, 0])
    rotate(90)
      linear_extrude(height)
        difference() {
          circle(r = motor_outer_diameter_top / 2 + wall_width + width);
          circle(r = motor_outer_diameter_top / 2 + wall_width + tolerance);
          scale([1.05, 1.05])
            screw_plate_case();
        }

module case_holder(wall_width, height)translate([0, shaft_position, 0])
  linear_extrude(height)
    difference() {
      circle(r = motor_outer_diameter_top / 2 + wall_width);
      circle(r = motor_outer_diameter_top / 2);
    }

module motor_support()linear_extrude(layer_thickness)
  translate([0, -clock_to_sun_1_r - 21])
    square([spoke_width, 10], center = true);

