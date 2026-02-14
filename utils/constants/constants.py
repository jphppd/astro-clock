import math

DATA = {
    "$fs": 0.1,
    "$fn": 64,
    "eps": 0.001,
    "global_scale": 0.75,
    "half_allowance_absolute": 0.12,
    "spacer_sleeve": 3,
    "layer_thickness": 4,
    "carrier_1_width": 7,
    "carrier_2_width": 7,
    "ecliptic_inclination": 23.44,
    "gears_shaft_radius": 4.0,
    "sun_shaft_radius": 20.0,
    "lunar_phases_shaft_radius": 6.0,
    "clock_shaft_radius": 7.0,
    "obs_latitude": 47.7343,
}

DATA.update(
    {
        "half_allowance": DATA["half_allowance_absolute"] / DATA["global_scale"],
        "gear_thickness": DATA["layer_thickness"]
        - 2 * DATA["half_allowance_absolute"] / DATA["global_scale"],
    }
)

# Shafts
# [moon : zodiac : sun_shaft_radius_lunar_nodes : lunar_nodes]
# = [0.66541 : 0.812296 : 0.91644 : 1]
# = [0.72608 : 0.886358 : 1 : 1.09118]
DATA["sun_shaft_radius_c3_hub"] = DATA["sun_shaft_radius"] - 2.0
DATA["sun_shaft_radius_lunar_nodes"] = (
    math.sqrt(3) / 2 * DATA["sun_shaft_radius_c3_hub"]
)
DATA["sun_shaft_radius_lunar_phases"] = DATA["sun_shaft_radius"] + DATA["spacer_sleeve"]

DATA["lunar_nodes_shaft_radius"] = DATA["sun_shaft_radius_lunar_nodes"] + 3
DATA["zodiac_shaft_radius"] = DATA["sun_shaft_radius_lunar_nodes"] - 3
DATA["moon_shaft_radius"] = DATA["sun_shaft_radius_lunar_nodes"] - 6
DATA["moon_shaft_radius_zodiac"] = DATA["moon_shaft_radius"] + DATA["spacer_sleeve"]

s_ecl_inclin = math.sin(math.radians(DATA["ecliptic_inclination"]))
c_ecl_inclin = math.cos(math.radians(DATA["ecliptic_inclination"]))
t_ecl_inclin = math.tan(math.radians(DATA["ecliptic_inclination"]))

DATA["stereo_proj_scale_factor"] = math.sqrt((1 + s_ecl_inclin) / (1 - s_ecl_inclin))
DATA["tropic_cancer_radius"] = (
    math.sqrt((1 + s_ecl_inclin) / (1 - s_ecl_inclin))
    / DATA["stereo_proj_scale_factor"]
)
DATA["tropic_capricorn_radius"] = (
    math.sqrt((1 - s_ecl_inclin) / (1 + s_ecl_inclin))
    / DATA["stereo_proj_scale_factor"]
)
DATA["ecliptic_radius"] = 1 / c_ecl_inclin / DATA["stereo_proj_scale_factor"]
DATA["ecliptic_center_offset"] = -t_ecl_inclin / DATA["stereo_proj_scale_factor"]

DATA["carrier_1_offset"] = 0
DATA["carrier_2_offset"] = DATA["carrier_1_offset"] + DATA["carrier_1_width"]
DATA["carrier_3_offset"] = DATA["carrier_2_offset"] + DATA["carrier_2_width"]
