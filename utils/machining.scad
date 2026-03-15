module translate_polar(r, theta, z = 0) translate(v=[r * cos(theta), r * sin(theta), z])
    children();

module pattern(radius, n, radius_offset, stellation_ratio = undef, stellation_radius = undef) let (
    alpha = (is_undef(stellation_ratio) && !is_undef(stellation_radius)) ? (stellation_radius / radius)
    : (!is_undef(stellation_ratio) && is_undef(stellation_radius)) ? stellation_ratio : 1
  )
  polygon(
    [
      for (i = [0:(2 * n)]) let (
        th = 360 * i / (2 * n),
        r = (i % 2 == 1) ? radius + radius_offset : alpha * radius + radius_offset
      ) [r * cos(th), r * sin(th)],
    ]
  );

module extruded_pattern(radius, radius_offset = 0, n = 64, length = 1, r = 0, theta = 0, stellation_ratio = undef, stellation_radius = undef, z = 0)
  translate_polar(r, theta, 0)
    linear_extrude(length * layer_thickness)
      pattern(radius, n, radius_offset, stellation_ratio=stellation_ratio, stellation_radius=stellation_radius);

module circular_shaft(radius = gears_shaft_radius, length = 1, r = 0, theta = 0, n = 64, stellation_ratio = undef, stellation_radius = undef)
  extruded_pattern(radius=radius, radius_offset=-half_allowance, length=length, r=r, theta=theta, n=n, stellation_ratio=stellation_ratio, stellation_radius=stellation_radius);

module circular_hole(radius = gears_shaft_radius, length = 1, r = 0, theta = 0, n = 64, stellation_ratio = undef, stellation_radius = undef)
  extruded_pattern(radius=radius, radius_offset=+half_allowance, length=length + 2 * eps, r=r, theta=theta, n=n, stellation_ratio=stellation_ratio, stellation_radius=stellation_radius, z=-eps);

module hex_shaft(apothem = undef, circumradius = undef, length = 1, r = 0, theta = 0, stellation_ratio = undef, stellation_radius = undef)
  circular_shaft(
    radius=(is_undef(apothem) && !is_undef(circumradius)) ? circumradius
    : (!is_undef(apothem) && is_undef(circumradius)) ? apothem / cos(180 / 6) : undef, length=length, r=r, theta=theta, stellation_ratio=is_undef(stellation_ratio) && is_undef(stellation_radius) ? cos(180 / 6)
    : stellation_ratio, stellation_radius=stellation_radius, n=6
  );

module hex_hole(apothem = undef, circumradius = undef, length = 1, r = 0, theta = 0, stellation_ratio = undef, stellation_radius = undef)
  circular_hole(
    radius=(is_undef(apothem) && !is_undef(circumradius)) ? circumradius
    : (!is_undef(apothem) && is_undef(circumradius)) ? apothem / cos(180 / 6) : undef, length=length, r=r, theta=theta, stellation_ratio=is_undef(stellation_ratio) && is_undef(stellation_radius) ? cos(180 / 6)
    : stellation_ratio, stellation_radius=stellation_radius, n=6
  );

module dovetail() translate([0, 1 / 8, 0])
    polygon(
      [
        [1 / 8, 0],
        [3 / 16, -1 / 2],
        [-3 / 16, -1 / 2],
        [-1 / 8, 0],
      ]
    );

module fillet(inner_radius, outer_radius) let (fillet_radius = outer_radius - inner_radius)
  rotate_extrude()
    union() {
      square([inner_radius + eps, fillet_radius]);
      translate([outer_radius, fillet_radius, 0])
        rotate(180)
          difference() {
            square(fillet_radius);
            circle(fillet_radius);
          }
    }
