from constants.clock_to_sun.structure import DATA as CLOCK_TO_SUN_STRUCT
from constants.moon_to_zodiac.structure import DATA as MOON_TO_ZODIAC_STRUCT
from constants.sun_to_lunar_nodes.structure import (
    DATA as SUN_TO_LUNAR_NODES_STRUCT,
)
from constants.sun_to_lunar_phases.structure import (
    DATA as SUN_TO_LUNAR_PHASES_STRUCT,
)
from constants.sun_to_moon.structure import DATA as SUN_TO_MOON_STRUCT
from constants.constants import DATA as CONSTANTS
from constants.structure import DATA as STRUCT_CONSTANTS


def spur_gear_max_radius(n, m):
    return m * (n / 2 + 1)


def clock_to_sun():
    clock_to_sun_5a_r = spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["5a_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["4b_5a_mod"],
    )
    clock_to_sun_3a_r = spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["3a_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["2b_3a_mod"],
    )
    clock_to_sun_6b_r = spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["6b_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["6b_7_mod"],
    )

    assert (
        clock_to_sun_5a_r
        + CONSTANTS["gears_shaft_radius"]
        + CONSTANTS["spacer_sleeve"]
        + 0.1
        < CLOCK_TO_SUN_STRUCT["dist_25"]
    )
    assert clock_to_sun_3a_r + clock_to_sun_6b_r + 0.1 < CLOCK_TO_SUN_STRUCT["dist_36"]


def between_parts():
    clock_to_sun_4a_r = spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["4a_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["3b_4a_mod"],
    )
    sun_to_lunar_phases_1_max_radius = spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["1_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["1_2a_mod"],
    )
    assert (
        clock_to_sun_4a_r + sun_to_lunar_phases_1_max_radius
        < CLOCK_TO_SUN_STRUCT["4_r"]
    )


def detect_collisions():
    clock_to_sun()


detect_collisions()
