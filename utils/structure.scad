module spoke()linear_extrude(layer_thickness)
  scale([1, spoke_width, 1])
    translate([hub_radius + 3 / 4 * annulus_sagitta, -1 / 2, 0])
      square([carrier_outer_radius - 3 / 2 * annulus_sagitta - hub_radius, 1]);

module half_spoke()let( //
versin = hub_radius * (1 - 2 / sqrt(4 + pow(spoke_width / hub_radius, 2))) //
)
  scale([1, spoke_width / 2, 1])
    translate([hub_radius - 2 * versin, 0, 0])
      square([carrier_inner_radius - hub_radius + 2 * versin + eps, 1]);

function annulus_middle(n) =
  concat( //
  [
    for (i = [0:n])
      hub_radius + annulus_sagitta / 2 + //
      i / n * (carrier_outer_radius - hub_radius - annulus_sagitta)
  ]);

module annuli()for(dx = annulus_middle(nb_of_annuli))
  polygon(concat( //
  [
    for (theta = [-36:2:36]) //
      [(dx - annulus_sagitta / 2) * cos(theta), (dx - annulus_sagitta / 2) * sin(theta)]
  ], [
    for (theta = [-36:2:36]) //
      [(dx + annulus_sagitta / 2) * cos(-theta), (dx + annulus_sagitta / 2) * sin(-theta)]
  ]));

module spokes() {
  rotate(-36)
    half_spoke();
  rotate(36)
    mirror([0, -1, 0])
      half_spoke();
}

module annuli_and_stokes() {
  annuli();
  spokes();
}

module hub_outer()polygon(concat( //
[
  for (theta = [-36:2:36])
    [hub_radius * cos(theta), hub_radius * sin(theta)]
], [
  for (theta = [-36:2:36])
    [hub_split * hub_radius * cos(-theta), hub_split * hub_radius * sin(-theta)]
]));

module annuli_to_hub_tooth()translate([hub_split * hub_radius, 0])
  rotate(-90)
    scale([hub_split * hub_radius, 0.8 * hub_split * hub_radius])
      dovetail();

module dovetails()rotate(-36)
  for(dx = annulus_middle(nb_of_annuli))
    translate([dx, 0, 0])
      scale([annulus_sagitta * 1.2, spoke_width / 2, 1])
        dovetail();

module base_structure()linear_extrude(layer_thickness)
  offset(delta = -half_allowance)
    difference() {
      union() {
        annuli_and_stokes();
        hub_outer();
        dovetails();
        annuli_to_hub_tooth();
      }
      rotate(72)
        dovetails();
    }

module hub(inner_radius)linear_extrude(layer_thickness)
  offset(delta = -half_allowance)
    difference() {
      circle(r = hub_split * hub_radius);
      for(i = [0:5])
        rotate(i * 360 / 5)
          annuli_to_hub_tooth();
      circle(r = inner_radius);
    }

module base_structure_complete(inner_radius)linear_extrude(layer_thickness)
  difference() {
    union() {
      // Spokes
      for(theta = [18:72:360])
        rotate(theta)
          translate([0, -spoke_width / 2])
            square([carrier_outer_radius, spoke_width]);

      // Annuli
      for(dx = annulus_middle(nb_of_annuli))
        difference() {
          circle(r = dx + annulus_sagitta / 2);
          circle(r = dx - annulus_sagitta / 2);
        }

      difference() {
        circle(r = carrier_outer_radius + outer_annulus_sagitta / 2);
        circle(r = carrier_outer_radius - outer_annulus_sagitta / 2);
      }

      circle(r = hub_radius);
    }

    // Central shaft
    circle(r = inner_radius);
  }

module spacer(spacer_length)difference() {
  circular_shaft(radius = outer_annulus_sagitta / 2, length = spacer_length - 2 * half_allowance / layer_thickness);
  circular_hole(length = spacer_length);
}
