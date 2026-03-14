from constants.clock_to_sun.structure import DATA as CLOCK_TO_SUN_STRUCT
from constants.sun_to_lunar_nodes.structure import (
    DATA as SUN_TO_LUNAR_NODES_STRUCT,
)
from constants.sun_to_lunar_phases.structure import (
    DATA as SUN_TO_LUNAR_PHASES_STRUCT,
)
from constants.moon_to_zodiac.structure import (
    DATA as MOON_TO_ZODIAC_STRUCT,
)
from constants.sun_to_moon.structure import DATA as SUN_TO_MOON_STRUCT
from constants.constants import DATA as CONSTANTS
from constants.structure import DATA as STRUCTURE


def spur_gear_max_radius(n, m):
    return m * (n / 2 + 1)


tol = 0.5

shaft_with_sleeve = CONSTANTS["gears_shaft_radius"] + CONSTANTS["spacer_sleeve"]

MOON_TO_ZODIAC = {
    "1": spur_gear_max_radius(
        MOON_TO_ZODIAC_STRUCT["gears"]["1_n"],
        MOON_TO_ZODIAC_STRUCT["gears"]["1_2a_mod"],
    ),
    "2a": spur_gear_max_radius(
        MOON_TO_ZODIAC_STRUCT["gears"]["2a_n"],
        MOON_TO_ZODIAC_STRUCT["gears"]["1_2a_mod"],
    ),
    "2b": spur_gear_max_radius(
        MOON_TO_ZODIAC_STRUCT["gears"]["2b_n"],
        MOON_TO_ZODIAC_STRUCT["gears"]["2b_3a_mod"],
    ),
    "3a": spur_gear_max_radius(
        MOON_TO_ZODIAC_STRUCT["gears"]["3a_n"],
        MOON_TO_ZODIAC_STRUCT["gears"]["2b_3a_mod"],
    ),
    "3b": spur_gear_max_radius(
        MOON_TO_ZODIAC_STRUCT["gears"]["3b_n"],
        MOON_TO_ZODIAC_STRUCT["gears"]["3b_4a_mod"],
    ),
    "4a": spur_gear_max_radius(
        MOON_TO_ZODIAC_STRUCT["gears"]["4a_n"],
        MOON_TO_ZODIAC_STRUCT["gears"]["3b_4a_mod"],
    ),
    "4b": spur_gear_max_radius(
        MOON_TO_ZODIAC_STRUCT["gears"]["4b_n"],
        MOON_TO_ZODIAC_STRUCT["gears"]["4b_5_mod"],
    ),
    "5": spur_gear_max_radius(
        MOON_TO_ZODIAC_STRUCT["gears"]["5_n"],
        MOON_TO_ZODIAC_STRUCT["gears"]["4b_5_mod"],
    ),
}
MOON_TO_ZODIAC["2"] = max(MOON_TO_ZODIAC["2a"], MOON_TO_ZODIAC["2b"])
MOON_TO_ZODIAC["3"] = max(MOON_TO_ZODIAC["3a"], MOON_TO_ZODIAC["3b"])
MOON_TO_ZODIAC["4"] = max(MOON_TO_ZODIAC["4a"], MOON_TO_ZODIAC["4b"])


SUN_TO_LUNAR_NODES = {
    "1": spur_gear_max_radius(
        SUN_TO_LUNAR_NODES_STRUCT["gears"]["1_n"],
        SUN_TO_LUNAR_NODES_STRUCT["gears"]["1_2a_mod"],
    ),
    "2a": spur_gear_max_radius(
        SUN_TO_LUNAR_NODES_STRUCT["gears"]["2a_n"],
        SUN_TO_LUNAR_NODES_STRUCT["gears"]["1_2a_mod"],
    ),
    "2b": spur_gear_max_radius(
        SUN_TO_LUNAR_NODES_STRUCT["gears"]["2b_n"],
        SUN_TO_LUNAR_NODES_STRUCT["gears"]["2b_3_mod"],
    ),
    "3": spur_gear_max_radius(
        SUN_TO_LUNAR_NODES_STRUCT["gears"]["3_n"],
        SUN_TO_LUNAR_NODES_STRUCT["gears"]["2b_3_mod"],
    ),
}
SUN_TO_LUNAR_NODES["2"] = max(SUN_TO_LUNAR_NODES["2a"], SUN_TO_LUNAR_NODES["2b"])

SUN_TO_LUNAR_PHASES = {
    "1": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["1_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["1_2a_mod"],
    ),
    "2a": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["2a_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["1_2a_mod"],
    ),
    "2b": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["2b_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["2b_3a_mod"],
    ),
    "3a": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["3a_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["2b_3a_mod"],
    ),
    "3b": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["3b_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["3b_4a_mod"],
    ),
    "4a": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["4a_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["3b_4a_mod"],
    ),
    "4b": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["4b_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["4b_5a_mod"],
    ),
    "5a": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["5a_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["4b_5a_mod"],
    ),
    "5b": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["5b_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["5b_6_mod"],
    ),
    "6": spur_gear_max_radius(
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["6_n"],
        SUN_TO_LUNAR_PHASES_STRUCT["gears"]["5b_6_mod"],
    ),
}
SUN_TO_LUNAR_PHASES["2"] = max(SUN_TO_LUNAR_PHASES["2a"], SUN_TO_LUNAR_PHASES["2b"])
SUN_TO_LUNAR_PHASES["3"] = max(SUN_TO_LUNAR_PHASES["3a"], SUN_TO_LUNAR_PHASES["3b"])
SUN_TO_LUNAR_PHASES["4"] = max(SUN_TO_LUNAR_PHASES["4a"], SUN_TO_LUNAR_PHASES["4b"])
SUN_TO_LUNAR_PHASES["5"] = max(SUN_TO_LUNAR_PHASES["5a"], SUN_TO_LUNAR_PHASES["5b"])


CLOCK_TO_SUN = {
    "1": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["1_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["1_2a_mod"],
    ),
    "2a": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["2a_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["1_2a_mod"],
    ),
    "2b": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["2b_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["2b_3a_mod"],
    ),
    "3a": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["3a_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["2b_3a_mod"],
    ),
    "3b": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["3b_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["3b_4a_mod"],
    ),
    "4a": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["4a_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["3b_4a_mod"],
    ),
    "4b": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["4b_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["4b_5a_mod"],
    ),
    "5a": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["5a_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["4b_5a_mod"],
    ),
    "5b": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["5b_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["5b_6a_mod"],
    ),
    "6a": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["6a_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["5b_6a_mod"],
    ),
    "6b": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["6b_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["6b_7_mod"],
    ),
    "7": spur_gear_max_radius(
        CLOCK_TO_SUN_STRUCT["gears"]["7_n"],
        CLOCK_TO_SUN_STRUCT["gears"]["6b_7_mod"],
    ),
}
CLOCK_TO_SUN["2"] = max(CLOCK_TO_SUN["2a"], CLOCK_TO_SUN["2b"])
CLOCK_TO_SUN["3"] = max(CLOCK_TO_SUN["3a"], CLOCK_TO_SUN["3b"])
CLOCK_TO_SUN["4"] = max(CLOCK_TO_SUN["4a"], CLOCK_TO_SUN["4b"])
CLOCK_TO_SUN["5"] = max(CLOCK_TO_SUN["5a"], CLOCK_TO_SUN["5b"])
CLOCK_TO_SUN["6"] = max(CLOCK_TO_SUN["6a"], CLOCK_TO_SUN["6b"])


SUN_TO_MOON = {
    "1": spur_gear_max_radius(
        SUN_TO_MOON_STRUCT["gears"]["1_n"],
        SUN_TO_MOON_STRUCT["gears"]["1_2_mod"],
    ),
    "2": spur_gear_max_radius(
        SUN_TO_MOON_STRUCT["gears"]["2_n"],
        SUN_TO_MOON_STRUCT["gears"]["1_2_mod"],
    ),
    "3": spur_gear_max_radius(
        SUN_TO_MOON_STRUCT["gears"]["3_n"],
        SUN_TO_MOON_STRUCT["gears"]["3_4_mod"],
    ),
    "4": spur_gear_max_radius(
        SUN_TO_MOON_STRUCT["gears"]["4_n"],
        SUN_TO_MOON_STRUCT["gears"]["3_4_mod"],
    ),
}


def clock_to_sun():
    assert CLOCK_TO_SUN["5a"] + shaft_with_sleeve + tol < CLOCK_TO_SUN_STRUCT["dist_25"]
    assert (
        CLOCK_TO_SUN["3a"] + CLOCK_TO_SUN["6b"] + tol < CLOCK_TO_SUN_STRUCT["dist_36"]
    )
    assert (
        CLOCK_TO_SUN["7"] + CLOCK_TO_SUN["2b"] + tol < CLOCK_TO_SUN_STRUCT["2b_r"]
    )


def moon_to_zodiac():
    assert (
        MOON_TO_ZODIAC["2"] + MOON_TO_ZODIAC["5"] + tol
        < MOON_TO_ZODIAC_STRUCT["dist_12"]
    )
    assert (
        MOON_TO_ZODIAC["3a"] + MOON_TO_ZODIAC["4b"] + tol
        < MOON_TO_ZODIAC_STRUCT["dist_34"]
    )
    assert (
        MOON_TO_ZODIAC_STRUCT["3_r"] + MOON_TO_ZODIAC["3"] + tol
        < STRUCTURE["carrier_outer_radius"] - STRUCTURE["outer_annulus_sagitta"] / 2
    )


def sun_to_lunar_phases():
    assert (
        SUN_TO_LUNAR_PHASES["1"] + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d13"]
    )
    assert (
        SUN_TO_LUNAR_PHASES["2"] + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d23"]
    )
    assert (
        SUN_TO_LUNAR_PHASES["3a"] + SUN_TO_LUNAR_PHASES["4b"] + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d34"]
    )
    assert (
        SUN_TO_LUNAR_PHASES["5"] + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d35"]
    )


def between_parts():
    # Sun to lunar phases shafts
    assert (
        CLOCK_TO_SUN["7"] + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d12"]
    )
    assert (
        CLOCK_TO_SUN["7"] + shaft_with_sleeve + tol
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d13"]
    )
    assert (
        SUN_TO_LUNAR_NODES["1"] + shaft_with_sleeve
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d12"]
    )
    assert (
        SUN_TO_LUNAR_NODES["1"] + shaft_with_sleeve
        < SUN_TO_LUNAR_PHASES_STRUCT["dist_d13"]
    )
    # Clock to sun shafts
    assert SUN_TO_LUNAR_NODES["1"] + shaft_with_sleeve < CLOCK_TO_SUN_STRUCT["dist_67"]
    assert (
        SUN_TO_LUNAR_PHASES["1"] + CLOCK_TO_SUN["4"] + tol
        < CLOCK_TO_SUN_STRUCT["dist_67"]
    )
    # Sun to moon vs moon to zodiac
    assert (
        MOON_TO_ZODIAC["1"]
        + CONSTANTS["gears_shaft_radius"]
        + 1.5 * CONSTANTS["spacer_sleeve"]
        + tol
        < SUN_TO_MOON_STRUCT["dist_12"]
    )
    assert SUN_TO_MOON["1"] + MOON_TO_ZODIAC["4a"] + tol < MOON_TO_ZODIAC_STRUCT["4_r"]
    # Clock to sun vs sun to moon
    assert SUN_TO_MOON["1"] + CLOCK_TO_SUN["2a"] + tol < CLOCK_TO_SUN_STRUCT["2a_r"]
    # Clock to sun vs moon to zodiac
    assert MOON_TO_ZODIAC["1"] + shaft_with_sleeve + tol < CLOCK_TO_SUN_STRUCT["2a_r"]

def detect_collisions():
    clock_to_sun()
    sun_to_lunar_phases()
    moon_to_zodiac()
    between_parts()


detect_collisions()
