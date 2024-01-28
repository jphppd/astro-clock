// Follows the formalism explained in the open access paper:
// https://www.sciencedirect.com/science/article/pii/S0263224118310315
// Other reference:
// https://www.tec-science.com/mechanical-power-transmission/involute-gear/geometry-of-involute-gears/

// Helper functions for lists
function fn_range(range) =
  [
    for (x = range)
      x
  ];
function fn_pop_last(list) =
  len(list) > 1 ? [
    for (idx = [0:max(0, len(list) - 2)])
      list[idx]
  ] : [];
function fn_pop_first(list) =
  len(list) > 1 ? [
    for (idx = [1:len(list) - 1])
      list[idx]
  ] : [];
function fn_pop_first_last(list) =
  len(list) > 2 ? [
    for (idx = [1:max(0, len(list) - 2)])
      list[idx]
  ] : [];
function fn_reverse(list) =
  let (length = len(list))
    [
      for (idx = [1:length])
        list[length - idx]
    ];
function fn_zip(list1, list2) =
  [
    for (idx = [0:max(0, min(len(list1), len(list2)) - 1)]) //
      [list1[idx], list2[idx]]
  ];
function fn_pairwise(list) = //
  len(list) > 2 //
  ? fn_zip(fn_pop_last(list), fn_pop_first(list)) //
  : len(list) == 2 //
  ? [list] //
  : []; //

// Helpers functions for geometry
function fn_scale(points, scal) =
  [
    for (point = points)
      [
        for (coord = point)
          scal * coord
      ]
  ];
function fn_rotate(points, angle) = //
  let (s = sin(angle), //
  c = cos(angle) //
  ) //
    [
      for (point = points) //
        [c * point.x - s * point.y, s * point.x + c * point.y, point.z] //
    ];
function fn_rotate_and_scale(points, angle, scale) = //
  let (s = scale * sin(angle), //
  c = scale * cos(angle) //
  ) //
    [
      for (point = points)
        [c * point.x - s * point.y, s * point.x + c * point.y, point.z]
    ];

/**
[gear module] Base circle radius (below the pitch circle)
Parameters:
- [-] n: number of teeth
- [deg] pressure angle: normal pressure angle at pitch circle alpha_n0
- [deg] helix_angle: helix angle at pitch circle beta0
*/
function fn_r_base(n, pressure_angle = 20, helix_angle = 0) = //
  n / (2 * sqrt(pow(cos(helix_angle), 2) + pow(tan(pressure_angle), 2)));

/**
[gear module] Pitch (reference) circle radius r0
Parameters:
- [-] n: number of teeth
- [deg] helix_angle: helix angle at pitch circle beta0
*/
function fn_r_pitch(n, helix_angle = 0) =
  n / (2 * cos(helix_angle));

/**
[-] Base radius over pitch radius rb/r0
Parameters:
- [deg] pressure angle: normal pressure angle at pitch circle alpha_n0
- [deg] helix_angle: helix angle at pitch circle beta0
Eqn 1 and 6
*/
function fn_r_base_over_r_pitch(pressure_angle, helix_angle = 0) = //
  1 / sqrt(1 + pow(tan(pressure_angle) / cos(helix_angle), 2));

/**
[gear module] Addendum (tip) circle radius
Parameters:
- [-] n: number of teeth
- [deg] helix_angle: helix angle at pitch circle beta0
- [gear module] addendum: extra addendum
*/
function fn_r_addendum(n, helix_angle = 0, addendum = 0) =
  fn_r_pitch(n, helix_angle) + (1 + addendum);

/**
[gear module] Dedendum (root) circle radius
Parameters:
- [-] n: number of teeth
- [deg] helix_angle: helix angle at pitch circle beta0
- [gear module] dedendum: extra dedendum
*/
function fn_r_dedendum(n, helix_angle = 0, dedendum = 0) =
  fn_r_pitch(n, helix_angle) - (1 + 0.167) * (1 + dedendum);

/**
[deg] Angular start position of the involute at base circle in reference plane
for the left flank (flank -1) and external gear (type 1).
Parameters:
- [-] n: number of teeth
- [deg] pressure angle: normal pressure angle at pitch circle alpha_n0
- [deg] helix_angle: helix angle at pitch circle beta0
- [-] backslash:
*/
function fn_phib(n, pressure_angle, helix_angle = 0, backlash = 0) = //
  let ( //
  rb_over_r0 = fn_r_base_over_r_pitch(pressure_angle, helix_angle), //
  // Eqn 1 and 6, simplified
  r0_sqrt_over_rb = sqrt(1 / pow(rb_over_r0, 2) - 1) * 180 / PI, //
  // Eqn 7 and 8 simplified
  acos_x_r0 = (90 - backlash * cos(helix_angle)) / n //
  )
    // Eqn 9
    r0_sqrt_over_rb - acos(rb_over_r0) + acos_x_r0;

/**
[[gear module,gear module], ...] Cartesian coordinates of the left flank
of a tooth, whose tip lies on direction x.
Parameters:
- [deg] alpha_t_min, alpha_t_max: Minimal/maximal transverse pressure angle,
parameter of the involute curve of the flank
- [deg] phib: angular start position of the involute at base circle
*/
function fn_flank(alpha_t_min, alpha_t_max, phib, rb_over_r0, $fn = 10) =
  [ //
    for (alpha_t = [alpha_t_min:(alpha_t_max - alpha_t_min) / $fn:alpha_t_max]) //
      let (
      // Eqn 2
      inv_alpha_t = tan(alpha_t) * 180 / PI - alpha_t, //
      r = rb_over_r0 / cos(alpha_t), //
      // Eqn 14
      theta = phib - inv_alpha_t //
      )
        [r * cos(theta), r * sin(theta)]
  ];

/**
[gear module, gear module] Distance between the origin and the center, and radius,
of the undercut circular arc forming the root of the tooth.
r_dedendum must be lower than r_base.
Parameters:
- [gear module] r_dedendum: radius of dedendum circle
- [gear module] r_base: radius of base circle
- [deg] delta_phi: angle between two teeth
*/
function fn_undercut_root_center_radius(r_dedendum, r_base, delta_phi) =
  let ( //
  r_dedendum_2 = pow(r_dedendum, 2), //
  r_base_2 = pow(r_base, 2), //
  r_basecdp = r_base * cos(delta_phi), //
  r_base_cdp_r_dedendum = 2 * (r_basecdp - r_dedendum) //
  )
    [(r_base_2 - r_dedendum_2) / r_base_cdp_r_dedendum, //
    (r_dedendum_2 - 2 * r_dedendum * r_basecdp + r_base_2) / (r_base_cdp_r_dedendum)];

/**
[deg] Angle of the circular arc forming the half left root of the tooth.
Parameters:
- [gear module] r_dedendum: radius of dedendum circle
- [gear module] r_base: radius of base circle
- [gear module] root_radius: radius of the root circle
*/
function fn_root_arc_angle(r_dedendum, r_base, root_radius) = //
  let ( //
  a = r_base, //
  b = root_radius, //
  c = r_dedendum + root_radius //
  ) //
    acos((pow(b, 2) + pow(c, 2) - pow(a, 2)) / (2 * b * c));

/**
[[gear module,gear module], ...] Cartesian coordinates of the circular arc
forming the half left root of the tooth, whose tip lies on direction x.
Parameters:
- [gear module] root_center: distance between the origin and the center of the root arc
- [gear module] root_radius: radius of the root arc
- [deg] root_arc_angle: angle of the root arc
- [delta_phi] delta_phi: angle between two teeth
*/
function fn_root_arc(root_center, root_radius, root_arc_angle, delta_phi) = //
  fn_rotate( //
  [
    for (theta = [0:max(3, root_arc_angle / 8):root_arc_angle]) //
      [root_center - root_radius * cos(theta), -root_radius * sin(theta)]
  ], delta_phi);

/**
[[gear module,gear module], ...] Cartesian coordinates of the circular arc
forming the half left root of the tooth, whose tip lies on direction x,
when an undercut is necessary.
Parameters:
- [gear module] r_dedendum: radius of dedendum circle
- [gear module] r_base: radius of base circle
- [delta_phi] delta_phi: angle between two teeth
- [deg] phib: angular start position of the involute at base circle
*/
function root_arc_when_undercut(r_dedendum, delta_phi, phib, r_base) =
  let ( //
  root_center_radius = fn_undercut_root_center_radius(r_dedendum, r_base, delta_phi - phib), //
  root_radius = root_center_radius[1], //
  root_center = root_center_radius[0], //
  root_arc_angle = fn_root_arc_angle(r_dedendum, r_base, root_radius)) //
    fn_root_arc(root_center, root_radius, root_arc_angle, delta_phi);

/**
[[gear module,gear module], ...] Cartesian coordinates of the half left root of the tooth,
whose tip lies on direction x, when no undercut is necessary.
It basically amounts to a small arc between the teeth, concentric to the main center of the gear.
Parameters:
- [gear module] r_dedendum: radius of dedendum circle
- [delta_phi] delta_phi: angle between two teeth
- [deg] phib: angular start position of the involute at base circle
*/
function root_arc_when_no_undercut(r_dedendum, delta_phi, phib) = //
  [
    for (angle = [delta_phi, phib])
      [r_dedendum * cos(angle), r_dedendum * sin(angle)]
  ];

/**
[[gear module,gear module], ...] Cartesian coordinates of the half left root of the tooth,
whose tip lies on direction x.
Parameters:
- [gear module] r_dedendum: radius of dedendum circle
- [gear module] r_base: radius of base circle
- [delta_phi] delta_phi: angle between two teeth
- [deg] phib: angular start position of the involute at base circle
*/
function fn_root(r_dedendum, delta_phi, phib, r_base) = //
  r_base > r_dedendum //
  ? root_arc_when_undercut(r_dedendum, delta_phi, phib, r_base) //
  : root_arc_when_no_undercut(r_dedendum, delta_phi, phib);

/**
[[[gear module,gear module], ...], -, -]
1st element: cartesian coordinates of the left flank
and half root of the tooth, whose tip lies on direction x, clockwise order.
This is the primitive chunk whose symmetry and repetition build the whole gear.
2nd element: number of elements of the root arc.
3rd element: number of elements of the flank.
Parameters:
- [-] n: number of teeth
- [deg] pressure angle: normal pressure angle at pitch circle alpha_n0
- [deg] helix_angle: helix angle at pitch circle beta0
- [gear module] addendum: extra addendum
- [gear module] dedendum: extra dedendum
- [-] backslash:
*/
function fn_flank_and_root( //
n, //
pressure_angle = 20, //
helix_angle = 0, //
addendum = 0, //
dedendum = 0, //
backlash = 0.1 //
) = //
  let ( //
  r_base = fn_r_base(n, pressure_angle, helix_angle), //
  r_addendum = fn_r_addendum(n, helix_angle, addendum), //
  r_dedendum = fn_r_dedendum(n, helix_angle, dedendum), //
  phib = fn_phib(n, pressure_angle, helix_angle, backlash), //
  alpha_t_max = acos(r_base / r_addendum), //
  alpha_t_min = acos(min(1, r_base / r_dedendum)), //
  flank = fn_flank(alpha_t_min, alpha_t_max, phib, r_base), //
  delta_phi = 180 / n, //
  root_arc = fn_root(r_dedendum, delta_phi, phib, r_base) //
  ) //
    [concat(fn_pop_last(root_arc), flank), len(root_arc), len(flank)];

/**
[[[gear module,gear module], ...], -, -]
1st element: cartesian coordinates of the tooth whose tip lies on direction x,
anti-clockwise order.
2nd element: number of elements of the root arc.
3rd element: number of elements of the flank.
Parameters:
- [-] n: number of teeth
- [deg] pressure angle: normal pressure angle at pitch circle alpha_n0
- [deg] helix_angle: helix angle at pitch circle beta0
- [gear module] addendum: extra addendum
- [gear module] dedendum: extra dedendum
- [-] backslash:
*/
function fn_gear_tooth( //
n, //
pressure_angle = 20, //
helix_angle = 0, //
addendum = 0, //
dedendum = 0, //
backlash = 0.1 //
) = //
  let ( //
  flank_and_root_with_len = fn_flank_and_root(n, pressure_angle, helix_angle, addendum, dedendum, backlash), //
  flank_and_root = flank_and_root_with_len[0], //
  flank_and_root_len = flank_and_root_with_len[1] + flank_and_root_with_len[2] - 1, //
  tooth_and_roots = concat(flank_and_root, //
  [
    for (i = [1:flank_and_root_len]) //
      [flank_and_root[flank_and_root_len - i].x, //
      -flank_and_root[flank_and_root_len - i].y]
  ]) //
  )
    [
      [
        for (pt = tooth_and_roots)
          [pt.x, -pt.y]
      ], 
      flank_and_root_with_len[1], 
      flank_and_root_with_len[2]
    ];

/**
[[[gear module,gear module], ...], -, -]
1st element: cartesian coordinates of the gear section, anti-clockwise order.
2nd element: number of elements of the root arc.
3rd element: number of elements of the flank.
Parameters:
- [-] n: number of teeth
*/
function fn_gear_section(n) = //
  let ( //
  gt = fn_gear_tooth(n), //
  tooth = gt[0], //
  delta_theta = 360 / n //
  ) //
    [
      [
        for (i = [0:n - 1])
          each fn_pop_last(fn_rotate(tooth, i * delta_theta))
      ], 
      gt[1], 
      gt[2]
    ];

/**
List of faces corresponding to the flanks.
Parameters:
- [-] layers_nb: number of layers
- [-] layer_stride: index offset between two layers
- [-] teeth_nb: number of teeth
- [-] tooth_stride: index offset between two teeth
- [-] flank_and_roots_points_nb: number of points of the flank and root of one tooth
*/
function fn_flank_faces(layers_nb, layer_stride, teeth_nb, tooth_stride, flank_and_roots_points_nb) = //
  [
    for ( //
    layer_index = [0:layers_nb - 2], //
    tooth_idx = [0:teeth_nb - 1], //
    idx = fn_pairwise(fn_range([0:flank_and_roots_points_nb - 1])) //
    ) //
      each let (layer_offset = layer_index * layer_stride, tooth_offset = tooth_idx * tooth_stride)
        [ //
          [layer_offset + (tooth_offset + idx[0]) % layer_stride, layer_offset + (tooth_offset + idx[0]) % layer_stride + layer_stride, layer_offset + (tooth_offset + idx[1]) % layer_stride, ], 
          [layer_offset + (tooth_offset + idx[0]) % layer_stride + layer_stride, layer_offset + (tooth_offset + idx[1]) % layer_stride + layer_stride, layer_offset + (tooth_offset + idx[1]) % layer_stride, ]
        ]
  ];

// Helper functions to identify the offset of the index of some specitic points on the tooth.
function fn_right_root_begin(root_pts_nb, flank_pts_nb) =
  0;
function fn_right_root_end(root_pts_nb, flank_pts_nb) =
  root_pts_nb;
function fn_flank_begin(root_pts_nb, flank_pts_nb) =
  root_pts_nb;
function fn_flank_end(root_pts_nb, flank_pts_nb) =
  root_pts_nb + 2 * flank_pts_nb + 1;
function fn_left_root_begin(root_pts_nb, flank_pts_nb) =
  root_pts_nb + 2 * flank_pts_nb + 1;
function fn_left_root_end(root_pts_nb, flank_pts_nb) =
  2 * (root_pts_nb + flank_pts_nb) + 1;
function fn_tooth_pitch(root_pts_nb, flank_pts_nb) =
  2 * (root_pts_nb + flank_pts_nb) + 2;
function fn_tooth_base(root_pts_nb, flank_pts_nb) =
  2 * (root_pts_nb + flank_pts_nb) + 3;
function fn_tooth_dedendum(root_pts_nb, flank_pts_nb) =
  2 * (root_pts_nb + flank_pts_nb) + 4;

/**
List of faces corresponding to the teeth top and bottom surfaces, on the lid.
Parameters:
- [-] layers_nb: number of layers
- [-] layer_stride: index offset between two layers
- [-] teeth_nb: number of teeth
- [-] tooth_stride: index offset between two teeth
- [-] root_pts_nb: number of points used for the root of each tooth
- [-] flank_pts_nb: number of points used for the flanks of each tooth
*/
function fn_lid_teeth_faces(layers_nb, layer_stride, teeth_nb, tooth_stride, root_pts_nb, flank_pts_nb) =
  let ( //
  right_root_begin = fn_right_root_begin(root_pts_nb, flank_pts_nb), //
  right_root_end = fn_right_root_end(root_pts_nb, flank_pts_nb), //
  right_root_middle = floor((right_root_begin + right_root_end) / 2), //
  flank_begin = fn_flank_begin(root_pts_nb, flank_pts_nb), //
  flank_end = fn_flank_end(root_pts_nb, flank_pts_nb), //
  left_root_begin = fn_left_root_begin(root_pts_nb, flank_pts_nb), //
  left_root_end = fn_left_root_end(root_pts_nb, flank_pts_nb), //
  left_root_middle = floor((left_root_begin + left_root_end + 1) / 2), //
  pitch = fn_tooth_pitch(root_pts_nb, flank_pts_nb), //
  base = fn_tooth_base(root_pts_nb, flank_pts_nb), //
  dedendum = fn_tooth_dedendum(root_pts_nb, flank_pts_nb), //
  bottom_lid_teeth = [
    for (tooth_idx = [0:teeth_nb - 1])
      each //
      let ( //
      offset = tooth_idx * tooth_stride, //
      flanks = fn_pairwise(fn_range([flank_begin:flank_end])), //
      right_root_a = fn_pairwise(fn_range([right_root_begin:right_root_middle])), //
      right_root_b = fn_pairwise(fn_range([right_root_middle:right_root_end])), //
      left_root_b = fn_pairwise(fn_range([left_root_begin:left_root_middle])), //
      left_root_a = fn_pairwise(fn_range([left_root_middle:left_root_end])) //
      ) //
        concat( //
        [
          for (idx = flanks)
            [offset + pitch, offset + idx[0], offset + idx[1]]
        ], //
        [
          for (idx = right_root_a)
            [offset + dedendum, offset + idx[0], offset + idx[1]]
        ], //
        [
          for (idx = right_root_b)
            [offset + base, offset + idx[0], offset + idx[1]]
        ], //
        [
          for (idx = left_root_b)
            [offset + base, offset + idx[0], offset + idx[1]]
        ], //
        [
          for (idx = left_root_a)
            [offset + dedendum, offset + idx[0], offset + idx[1]]
        ], //
        [
          [offset + flank_begin, offset + pitch, offset + base]
        ], //
        [
          [offset + flank_end, offset + base, offset + pitch]
        ], //
        base > _subded_factor * dedendum ? [
          [offset + left_root_middle, offset + dedendum, offset + base]
        ] : [], //
        base > _subded_factor * dedendum ? [
          [offset + right_root_middle, offset + base, offset + dedendum]
        ] : [], //
        [])
  ], //
  top_lid_teeth = [
    for (triangle = bottom_lid_teeth)
      [
        for (pt = fn_reverse(triangle))
          pt + (layers_nb - 1) * layer_stride
      ]
  ] //
  )
    concat(bottom_lid_teeth, top_lid_teeth);

/**
List of faces corresponding to the top and bottom lids.
Parameters:
- [-] layers_nb: number of layers
- [-] layer_stride: index offset between two layers
- [-] teeth_nb: number of teeth
- [-] tooth_stride: index offset between two teeth
- [-] root_pts_nb: number of points used for the root of each tooth
- [-] flank_pts_nb: number of points used for the flanks of each tooth
*/
function fn_lid_inner_faces(layers_nb, layer_stride, teeth_nb, tooth_stride, root_pts_nb, flank_pts_nb) =
  let ( //
  right_root_begin = fn_right_root_begin(root_pts_nb, flank_pts_nb), //
  left_root_end = fn_left_root_end(root_pts_nb, flank_pts_nb), //
  dedendum = fn_tooth_dedendum(root_pts_nb, flank_pts_nb), //
  bottom_lid_inner_tooth = [right_root_begin, dedendum, tooth_stride], bottom_lid_inner = [
    for (tooth_idx = [0:teeth_nb - 1], pt = bottom_lid_inner_tooth) //
      (pt + tooth_idx * tooth_stride) % layer_stride
  ], top_lid_inner = [
    for (pt = fn_reverse(bottom_lid_inner))
      pt + (layers_nb - 1) * layer_stride
  ] //
  )
    concat([bottom_lid_inner], [top_lid_inner]);

/**
List of all faces to create the polyhedron.
Parameters:
- [-] layers_nb: number of layers
- [-] layer_stride: index offset between two layers
- [-] teeth_nb: number of teeth
- [-] tooth_stride: index offset between two teeth
- [-] root_pts_nb: number of points used for the root of each tooth
- [-] flank_pts_nb: number of points used for the flanks of each tooth
*/
function fn_faces(layers_nb, layer_stride, teeth_nb, tooth_stride, root_pts_nb, flank_pts_nb) =
  let ( //
  flank_faces = fn_flank_faces(layers_nb, layer_stride, teeth_nb, tooth_stride, 2 * (root_pts_nb + flank_pts_nb + 1)), lid_teeth_faces = fn_lid_teeth_faces(layers_nb, layer_stride, teeth_nb, tooth_stride, root_pts_nb, flank_pts_nb), lid_inner_faces = fn_lid_inner_faces(layers_nb, layer_stride, teeth_nb, tooth_stride, root_pts_nb, flank_pts_nb)) //
    concat(flank_faces, lid_teeth_faces, lid_inner_faces);

/**
Fold a set of points on a sphere, to construct a bevel gear.
Parameters:
- [[x,y,z], ...] points: list of points
- [gear_module] r_pitch: radius of the pitch circle at z=0, required in the construction to be invariant
- [deg] cone_half_angle: half angle of the cone of the bevel gear
*/
function fold_on_sphere(points, r_pitch, cone_half_angle) = //
  let ( //
  s_cone = sin(cone_half_angle), //
  c_cone = cos(cone_half_angle), //
  t_cone = tan(cone_half_angle)) //
    [
      for (pt = points)
        let ( //
        rho_plane = sqrt(pt.x * pt.x + pt.y * pt.y), //
        h = r_pitch / t_cone - pt.z, //
        r_sphere = h / c_cone, //
        theta = 180 - cone_half_angle + //
        (s_cone - rho_plane / r_sphere) * 180 / PI, //
        r_sin_theta_over_rho = r_sphere * sin(theta) / rho_plane //
        )
          [ //
          r_sin_theta_over_rho * pt.x, //
          r_sin_theta_over_rho * pt.y, //
          r_sphere * cos(theta) + h + pt.z]
    ];

_subded_factor = 0.95;
/**
Coordinates of points and faces of a gear with given parametrization.
Parameters:
- [-] n: number of teeth
- [distance] m: gear module
- [z0, z1, ...] layers: z coordinates of the different layers
- [deg] cone_half_angle: half angle of the cone of the bevel gear (optional)
*/
function fn_gear(n, m, layers, bevel_cone_angle = 0) =
  let ( //
  delta_theta = 360 / n, //
  r_pitch_over_m = fn_r_pitch(n), //
  r_pitch = m * fn_r_pitch(n), //
  gt = fn_gear_tooth(n), //
  tooth_contour = gt[0], //
  root_pts_nb = gt[1] - 1, //
  flank_pts_nb = gt[2] - 1, //
  tooth = concat(tooth_contour, [
    [r_pitch_over_m, 0], 
    [fn_r_base(n), 0], 
    [_subded_factor * fn_r_dedendum(n), 0]
  ]), //
  tooth_per_layer = [
    for (layer = layers)
      let ( //
      layer_z = layer[0] * cos(bevel_cone_angle), //
      layer_twist = layer[1], //
      h_over_h0 = 1 - layer_z * tan(bevel_cone_angle) / r_pitch, //
      m_s = m * sin(layer_twist) * h_over_h0, //
      m_c = m * cos(layer_twist) * h_over_h0, //
      rotated_scaled_tooth = [
        for (pt = tooth) //
          [m_c * pt.x - m_s * pt.y, m_s * pt.x + m_c * pt.y, layer_z]
      ] //
      ) //
        bevel_cone_angle == 0 ? rotated_scaled_tooth : fold_on_sphere(rotated_scaled_tooth, r_pitch, bevel_cone_angle)
  ], extruded_profile = [
    for (layer_idx = [0:len(layers) - 1], i = [0:n - 1])
      each fn_rotate(tooth_per_layer[layer_idx], i * delta_theta)
  ], faces = fn_faces(len(layers), len(extruded_profile) / len(layers), n, len(tooth), root_pts_nb, flank_pts_nb) //
  ) //
    [extruded_profile, faces];

module spur_gear(n, m, thickness = layer_thickness, bevel_cone_angle = 0) {
  layers = [
    [0, 0], 
    [thickness, 0]
  ];
  ep_f = fn_gear(n, m, layers, bevel_cone_angle = bevel_cone_angle);
  polyhedron(ep_f[0], ep_f[1]);
}

module helical_gear(n, m, thickness = layer_thickness, invert = false, helix_angle = 20, bevel_cone_angle = 0) {
  twist = (invert ? -1 : 1) * tan(helix_angle) * thickness / (n * m) * 180 / PI;
  layers = [
    [0, -twist], 
    [thickness, twist]
  ];
  ep_f = fn_gear(n, m, layers, bevel_cone_angle = bevel_cone_angle);
  polyhedron(ep_f[0], ep_f[1]);
}

module herringbone_gear(n, m, thickness = layer_thickness, invert = false, helix_angle = 20, bevel_cone_angle = 0) {
  twist = (invert ? -1 : 1) * tan(helix_angle) * thickness / (n * m) * 180 / PI;
  layers = [
    [0, twist], 
    [thickness / 2, 0], 
    [thickness, twist]
  ];
  ep_f = fn_gear(n, m, layers, bevel_cone_angle = bevel_cone_angle);
  polyhedron(ep_f[0], ep_f[1]);
}

module default_gear(n, m, thickness = gear_thickness, invert = false, bevel_cone_angle = 0)spur_gear(n, m, thickness = thickness, bevel_cone_angle = bevel_cone_angle);

function fn_gear_profile_partial(n, n_partial, $fn = 32) =
  let ( //
  tooth = fn_gear_tooth(n), //
  teeth = [
    for (i = [-(n_partial - 1) / 2:n_partial / 2])
      each fn_pop_last(fn_rotate(tooth, i * 360 / n))
  ], //
  r_dedendum = fn_r_dedendum(n, 0, 0), //
  cylinder_dedendum = [
    for (i = [n_partial / 2:(n - n_partial) / ($fn - 1):n - n_partial / 2]) //
      [r_dedendum * cos(i * 360 / n), r_dedendum * sin(i * 360 / n)]
  ] //
  )
    concat(fn_pop_first(teeth), cylinder_dedendum);

function anti_gear(n, m, thickness = layer_thickness, $fn = 32) =
  let ( //
  c = cos(180 / n), //
  s = sin(180 / n), //
  flank = fn_flank_and_root(n), //
  flank_left = [
    for (pt = flank)
      [c * pt.x + s * pt.y, -s * pt.x + c * pt.y]
  ], //
  flank_left_len = len(flank_left), //
  flank_right = [
    for (i = [1:flank_left_len]) //
      [flank_left[flank_left_len - i].x, -flank_left[flank_left_len - i].y]
  ], //
  anti_tooth = concat(flank_right, flank_left), //
  r_addendum = fn_r_addendum(n, 0, 0), //
  cylinder_addendum = [
    for (i = [1 / 2:(n - 1) / ($fn - 1):n - 1 / 2]) //
      [r_addendum * cos(-i * 360 / n), r_addendum * sin(-i * 360 / n)]
  ] //
  )
    fn_scale(concat(anti_tooth, cylinder_addendum), m);
