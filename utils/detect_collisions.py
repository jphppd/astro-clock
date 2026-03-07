from constants.clock_to_sun.structure import DATA as CLOCK_TO_SUN_STRUCT
from constants.sun_to_lunar_nodes.structure import (
    DATA as SUN_TO_LUNAR_NODES_STRUCT,
)
from constants.sun_to_lunar_phases.structure import (
    DATA as SUN_TO_LUNAR_PHASES_STRUCT,
)
from constants.constants import DATA as CONSTANTS


def spur_gear_max_radius(n, m):
    return m * (n / 2 + 1)


tol = 0.5

shaft_with_sleeve = CONSTANTS["gears_shaft_radius"] + CONSTANTS["spacer_sleeve"]

sun_to_lunar_nodes_1 = spur_gear_max_radius(
    SUN_TO_LUNAR_NODES_STRUCT["gears"]["1_n"],
    SUN_TO_LUNAR_NODES_STRUCT["gears"]["1_2a_mod"],
)

sun_to_lunar_phases_1 = spur_gear_max_radius(
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["1_n"],
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["1_2a_mod"],
)
sun_to_lunar_phases_2 = spur_gear_max_radius(
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["2a_n"],
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["1_2a_mod"],
)
sun_to_lunar_phases_3 = spur_gear_max_radius(
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["3a_n"],
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["2b_3a_mod"],
)
sun_to_lunar_phases_4 = spur_gear_max_radius(
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["4b_n"],
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["4b_5a_mod"],
)
sun_to_lunar_phases_5 = spur_gear_max_radius(
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["5a_n"],
    SUN_TO_LUNAR_PHASES_STRUCT["gears"]["4b_5a_mod"],
)


clock_to_sun_3 = spur_gear_max_radius(
    CLOCK_TO_SUN_STRUCT["gears"]["3a_n"],
    CLOCK_TO_SUN_STRUCT["gears"]["2b_3a_mod"],
)
clock_to_sun_4 = spur_gear_max_radius(
    CLOCK_TO_SUN_STRUCT["gears"]["4a_n"],
    CLOCK_TO_SUN_STRUCT["gears"]["3b_4a_mod"],
)
clock_to_sun_5 = spur_gear_max_radius(
    CLOCK_TO_SUN_STRUCT["gears"]["5a_n"],
    CLOCK_TO_SUN_STRUCT["gears"]["4b_5a_mod"],
)
clock_to_sun_6 = spur_gear_max_radius(
    CLOCK_TO_SUN_STRUCT["gears"]["6b_n"],
    CLOCK_TO_SUN_STRUCT["gears"]["6b_7_mod"],
)
clock_to_sun_7 = spur_gear_max_radius(
    CLOCK_TO_SUN_STRUCT["gears"]["7_n"],
    CLOCK_TO_SUN_STRUCT["gears"]["6b_7_mod"],
)


def clock_to_sun():
    assert clock_to_sun_5 + shaft_with_sleeve + tol < CLOCK_TO_SUN_STRUCT["dist_25"]
    assert clock_to_sun_3 + clock_to_sun_6 + tol < CLOCK_TO_SUN_STRUCT["dist_36"]


def sun_to_lunar_phases():
    assert (
        sun_to_lunar_phases_1 + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d13"]
    )
    assert (
        sun_to_lunar_phases_2 + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d23"]
    )
    assert (
        sun_to_lunar_phases_3 + sun_to_lunar_phases_4 + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d34"]
    )
    assert (
        sun_to_lunar_phases_5 + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d35"]
    )


def between_parts():
    # Sun to lunar phases shafts
    assert (
        clock_to_sun_7 + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d12"]
    )
    assert (
        clock_to_sun_7 + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d13"]
    )
    assert (
        sun_to_lunar_nodes_1 + shaft_with_sleeve
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d12"]
    )
    assert (
        sun_to_lunar_nodes_1 + shaft_with_sleeve
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d13"]
    )
    # Clock to sun shafts
    assert sun_to_lunar_nodes_1 + shaft_with_sleeve < CLOCK_TO_SUN_STRUCT["dist_67"]
    assert sun_to_lunar_phases_1 + clock_to_sun_4 + tol < CLOCK_TO_SUN_STRUCT["dist_67"]


def detect_collisions():
    clock_to_sun()
    sun_to_lunar_phases()
    between_parts()


detect_collisions()
