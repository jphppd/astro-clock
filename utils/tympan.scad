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

function fn_proj_circle(axis, scalar_product, scale_factor = 1) =
  let (d = -scalar_product) //
    [
      [-scale_factor * axis.x / (axis.z + d), -scale_factor * axis.y / (axis.z + d)], 
      scale_factor * sqrt((pow(axis.x, 2) + pow(axis.y, 2) + pow(axis.z, 2) - pow(d, 2)) / pow(axis.z + d, 2))
    ];

function fn_almucantar(obs_latitude, almucantar_altitude, scale_factor = 1) =
  fn_proj_circle( //
  [sin(obs_latitude), 0, cos(obs_latitude)], sin(almucantar_altitude), scale_factor);

function fn_great_circle(latitude, scale_factor = 1) =
  fn_proj_circle( //
  [sin(latitude), 0, cos(latitude)], 0, scale_factor);

function fn_circle_intersection(circle1, circle2) = //
  let ( //
  c1 = circle1[0], //
  r1 = circle1[1], //
  c2 = circle2[0], //
  r2 = circle2[1], //
  /* ax + by + c == 0 */
  r12 = pow(r1, 2), //
  r22 = pow(r2, 2), //
  a = 2 * (c1.x - c2.x), //
  b = 2 * (c1.y - c2.y), //
  c = pow(c2.x, 2) - pow(c1.x, 2) + pow(c2.y, 2) - pow(c1.y, 2) + r12 - r22, //
  a2 = pow(a, 2), //
  b2 = pow(b, 2), //
  delta = r12 * (a2 + b2) - pow(a * c1.x + b * c1.y + c, 2) //
  ) //
    (delta >= 0) //
    ? let ( //
    sqrt_delta = sqrt(delta), //
    denom = a2 + b2, //
    xbb = b2 * c1.x - a * (c + b * c1.y), //
    ybb = a2 * c1.y - b * (c + a * c1.x), //
    x1 = (xbb - sqrt_delta * abs(b)) / denom, //
    x2 = (xbb + sqrt_delta * abs(b)) / denom, //
    sign_b = b != 0 ? sign(b) : 1, //
    y1 = (ybb + a * sign_b * sqrt_delta) / denom, //
    y2 = (ybb - a * sign_b * sqrt_delta) / denom //
    )
      [
        [x1, y1], 
        [x2, y2]
      ] : undef;

function fn_circle_intersection_angles(circle_main, intersct) = //
  is_undef(intersct) //
  ? undef //
  : let ( //
  intersct1 = intersct[0], //
  intersct2 = intersct[1], //
  rcos1 = intersct1.x - circle_main[0].x, //
  rsin1 = intersct1.y - circle_main[0].y, //
  r1 = sqrt(pow(rcos1, 2) + pow(rsin1, 2)), //
  rcos2 = intersct2.x - circle_main[0].x, //
  rsin2 = intersct2.y - circle_main[0].y, //
  r2 = sqrt(pow(rcos2, 2) + pow(rsin2, 2)), cos1 = rcos1 / r1, //
  cos2 = rcos2 / r2, //
  sin1 = rsin1 / r1, //
  sin2 = rsin2 / r2) //
    (sin1 >= sin2 ? [
      [cos1, sin1], 
      [cos2, sin2]
    ] : [
      [cos2, sin2], 
      [cos1, sin1]
    ]);

function fn_interpolate_angles(list, reverse = false) =
  concat( //
  [
    for (angles = fn_pairwise(list))
      each [ //
      angles[0], //
      let (rc = (angles[0].x + angles[1].x), rs = (angles[0].y + angles[1].y), r = sqrt(pow(rc, 2) + pow(rs, 2))) //
        reverse ? [-rc / r, -rs / r] : [rc / r, rs / r]]
  ], [list[len(list) - 1]] //
  );

function interpolate_angles(list, reverse = false, depth = 6) = //
  depth <= 0 ? list : interpolate_angles(fn_interpolate_angles(list, reverse = reverse), reverse = false, depth = depth - 1);

module south_pole_to_capricorn(scale_factor = 1) {
  tropic_of_capricorn = fn_proj_circle([0, 0, 1], sin(-ecliptic_inclination), scale_factor);
  translate(tropic_of_capricorn[0])
    circle(r = tropic_of_capricorn[1], $fn = 128);
}

module capricorn_to_equator(scale_factor = 1) {
  equator = fn_proj_circle([0, 0, 1], 0, scale_factor);
  tropic_of_capricorn = fn_proj_circle([0, 0, 1], sin(-ecliptic_inclination), scale_factor);
  difference() {
    translate(equator[0])
      circle(r = equator[1]);
    translate(tropic_of_capricorn[0])
      circle(r = tropic_of_capricorn[1]);
  }
}

module equator_to_cancer(scale_factor = 1) {
  tropic_of_cancer = fn_proj_circle([0, 0, 1], sin(ecliptic_inclination), scale_factor);
  equator = fn_proj_circle([0, 0, 1], 0, scale_factor);
  difference() {
    translate(tropic_of_cancer[0])
      circle(r = tropic_of_cancer[1]);
    translate(equator[0])
      circle(r = equator[1]);
  }
}

module almucantar_complete_sector(obs_latitude, alt1, alt2, scale_factor = 1) {

  almucantar1 = fn_almucantar(obs_latitude, alt1, scale_factor);
  almucantar2 = fn_almucantar(obs_latitude, alt2, scale_factor);

  almucantar_min = almucantar1[1] < almucantar2[1] ? almucantar1 : almucantar2;
  almucantar_max = almucantar1[1] > almucantar2[1] ? almucantar1 : almucantar2;

  difference() {
    translate(almucantar_max[0])
      circle(r = almucantar_max[1]);
    translate(almucantar_min[0])
      circle(r = almucantar_min[1]);
  }
}

function point_on_arc(center_and_r, theta) =
  [center_and_r[0].x + center_and_r[1] * theta[0], center_and_r[0].y + center_and_r[1] * theta[1]];

function xor(a, b) =
  (a && !b) || (!a && b);
function arc(center_and_r, thetas, reverse = undef) = //
  let (do_reverse = //
  is_undef(reverse) //
  ? xor(thetas[0].x < 0, center_and_r[0].x > center_and_r[1]) //
  : reverse //
  ) //
    [
      for (theta = interpolate_angles(thetas, reverse = do_reverse))
        point_on_arc(center_and_r, theta)
    ];

function arc_east_to_west(center_and_r, thetas, reverse = undef) = //
  let (points = arc(center_and_r, thetas, reverse), //
  first_point = points[0], //
  last_point = points[len(points) - 1], //
  rev = (first_point.y * last_point.y < 0) && (first_point.y > last_point.y)) //
    (rev ? fn_reverse(points) : points);

function arc_west_to_east(center_and_r, thetas, reverse = undef) = //
  fn_reverse(arc_east_to_west(center_and_r, thetas, reverse));

function arc_north_to_south(center_and_r, thetas, reverse = undef) = //
  let (points = arc(center_and_r, thetas, reverse), //
  first_point = points[0], //
  last_point = points[len(points) - 1], //
  rev = (first_point.x * last_point.x < 0) && (first_point.x < last_point.x)) //
    (rev ? fn_reverse(points) : points);

function arc_south_to_north(center_and_r, thetas, reverse = undef) = //
  fn_reverse(arc_north_to_south(center_and_r, thetas, reverse));

function almucantar_flat_sector(obs_latitude, alt1, alt2, scale_factor = 1) =
  let (
  // Compute circles and radius
  almucantar_zenith = fn_almucantar(obs_latitude, max(alt1, alt2), scale_factor), almucantar_nadir = fn_almucantar(obs_latitude, min(alt1, alt2), scale_factor), tropic_of_capricorn = fn_proj_circle([0, 0, 1], sin(-ecliptic_inclination), scale_factor), tropic_of_cancer = fn_proj_circle([0, 0, 1], sin(+ecliptic_inclination), scale_factor), 

  zenith_cancer = fn_circle_intersection(almucantar_zenith, tropic_of_cancer), nadir_cancer = fn_circle_intersection(almucantar_nadir, tropic_of_cancer), 

  thetas_zenith = fn_circle_intersection_angles(almucantar_zenith, zenith_cancer), thetas_nadir = fn_circle_intersection_angles(almucantar_nadir, nadir_cancer), 

  thetas_cancer_zenith = fn_circle_intersection_angles(tropic_of_cancer, zenith_cancer), thetas_cancer_nadir = fn_circle_intersection_angles(tropic_of_cancer, nadir_cancer), 

  thetas_cancer_west = [is_undef(thetas_zenith) ? [1, 0] : thetas_cancer_zenith[0], is_undef(thetas_nadir) ? [-1, 0] : thetas_cancer_nadir[0]], thetas_cancer_east = [is_undef(thetas_zenith) ? [1, 0] : thetas_cancer_zenith[1], is_undef(thetas_nadir) ? [-1, 0] : thetas_cancer_nadir[1]], 

  almucantar_zenith_half_arc = is_undef(thetas_zenith) ? [] : arc_east_to_west(almucantar_zenith, thetas_zenith), almucantar_nadir_half_arc = is_undef(thetas_nadir) ? [] : arc_west_to_east(almucantar_nadir, thetas_nadir), cancer_west = arc_north_to_south(tropic_of_cancer, thetas_cancer_west, reverse = false), cancer_east = arc_south_to_north(tropic_of_cancer, thetas_cancer_east, reverse = false))
    concat(almucantar_zenith_half_arc, cancer_west, almucantar_nadir_half_arc, cancer_east);

module almucantar_half_sector(obs_latitude, alt1, alt2, side = 0, scale_factor = 1) {
  rotate(a = 90, v = [0, 0, 1])
    difference() {
      polygon(almucantar_flat_sector(obs_latitude, alt1, alt2, scale_factor));
      south_pole_to_capricorn(scale_factor);
      translate([0, -side * scale_factor, 0])
        square([side != 0 ? 4 * scale_factor : 0, side != 0 ? 2 * scale_factor : 0], center = true);
    }
}
