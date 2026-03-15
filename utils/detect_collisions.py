from constants.clock_to_sun.structure import DATA as CLK_SUN_STR
from constants.sun_to_lunar_nodes.structure import (
    DATA as SUN_LUNAR_N_STR,
)
from constants.sun_to_lunar_phases.structure import (
    DATA as SUN_LUNAR_PH_STR,
)
from constants.moon_to_zodiac.structure import (
    DATA as MOON_ZODIAC_STR,
)
from constants.sun_to_moon.structure import DATA as SUN_MOON_STR
from constants.constants import DATA as CONSTANTS
from constants.structure import DATA as STRUCTURE


def spur_gear_max_radius(n, m):
    return m * (n / 2 + 1)


tol = 0.5

shaft_with_sleeve = CONSTANTS["gears_shaft_radius"] + CONSTANTS["spacer_sleeve"]
carrier_outer_rim_inner = (
    STRUCTURE["carrier_outer_radius"] - STRUCTURE["outer_annulus_sagitta"] / 2
)
carrier_outer_rim_outer = (
    STRUCTURE["carrier_outer_radius"] + STRUCTURE["outer_annulus_sagitta"] / 2
)

MOON_ZODIAC = {
    "1": spur_gear_max_radius(
        MOON_ZODIAC_STR["gears"]["1_n"],
        MOON_ZODIAC_STR["gears"]["1_2a_mod"],
    ),
    "2a": spur_gear_max_radius(
        MOON_ZODIAC_STR["gears"]["2a_n"],
        MOON_ZODIAC_STR["gears"]["1_2a_mod"],
    ),
    "2b": spur_gear_max_radius(
        MOON_ZODIAC_STR["gears"]["2b_n"],
        MOON_ZODIAC_STR["gears"]["2b_3a_mod"],
    ),
    "3a": spur_gear_max_radius(
        MOON_ZODIAC_STR["gears"]["3a_n"],
        MOON_ZODIAC_STR["gears"]["2b_3a_mod"],
    ),
    "3b": spur_gear_max_radius(
        MOON_ZODIAC_STR["gears"]["3b_n"],
        MOON_ZODIAC_STR["gears"]["3b_4a_mod"],
    ),
    "4a": spur_gear_max_radius(
        MOON_ZODIAC_STR["gears"]["4a_n"],
        MOON_ZODIAC_STR["gears"]["3b_4a_mod"],
    ),
    "4b": spur_gear_max_radius(
        MOON_ZODIAC_STR["gears"]["4b_n"],
        MOON_ZODIAC_STR["gears"]["4b_5_mod"],
    ),
    "5": spur_gear_max_radius(
        MOON_ZODIAC_STR["gears"]["5_n"],
        MOON_ZODIAC_STR["gears"]["4b_5_mod"],
    ),
}
MOON_ZODIAC["2"] = max(MOON_ZODIAC["2a"], MOON_ZODIAC["2b"])
MOON_ZODIAC["3"] = max(MOON_ZODIAC["3a"], MOON_ZODIAC["3b"])
MOON_ZODIAC["4"] = max(MOON_ZODIAC["4a"], MOON_ZODIAC["4b"])


SUN_LUNAR_N = {
    "1": spur_gear_max_radius(
        SUN_LUNAR_N_STR["gears"]["1_n"],
        SUN_LUNAR_N_STR["gears"]["1_2a_mod"],
    ),
    "2a": spur_gear_max_radius(
        SUN_LUNAR_N_STR["gears"]["2a_n"],
        SUN_LUNAR_N_STR["gears"]["1_2a_mod"],
    ),
    "2b": spur_gear_max_radius(
        SUN_LUNAR_N_STR["gears"]["2b_n"],
        SUN_LUNAR_N_STR["gears"]["2b_3_mod"],
    ),
    "3": spur_gear_max_radius(
        SUN_LUNAR_N_STR["gears"]["3_n"],
        SUN_LUNAR_N_STR["gears"]["2b_3_mod"],
    ),
}
SUN_LUNAR_N["2"] = max(SUN_LUNAR_N["2a"], SUN_LUNAR_N["2b"])

SUN_LUNAR_PH = {
    "1": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["1_n"],
        SUN_LUNAR_PH_STR["gears"]["1_2a_mod"],
    ),
    "2a": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["2a_n"],
        SUN_LUNAR_PH_STR["gears"]["1_2a_mod"],
    ),
    "2b": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["2b_n"],
        SUN_LUNAR_PH_STR["gears"]["2b_3a_mod"],
    ),
    "3a": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["3a_n"],
        SUN_LUNAR_PH_STR["gears"]["2b_3a_mod"],
    ),
    "3b": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["3b_n"],
        SUN_LUNAR_PH_STR["gears"]["3b_4a_mod"],
    ),
    "4a": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["4a_n"],
        SUN_LUNAR_PH_STR["gears"]["3b_4a_mod"],
    ),
    "4b": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["4b_n"],
        SUN_LUNAR_PH_STR["gears"]["4b_5a_mod"],
    ),
    "5a": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["5a_n"],
        SUN_LUNAR_PH_STR["gears"]["4b_5a_mod"],
    ),
    "5b": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["5b_n"],
        SUN_LUNAR_PH_STR["gears"]["5b_6_mod"],
    ),
    "6": spur_gear_max_radius(
        SUN_LUNAR_PH_STR["gears"]["6_n"],
        SUN_LUNAR_PH_STR["gears"]["5b_6_mod"],
    ),
}
SUN_LUNAR_PH["2"] = max(SUN_LUNAR_PH["2a"], SUN_LUNAR_PH["2b"])
SUN_LUNAR_PH["3"] = max(SUN_LUNAR_PH["3a"], SUN_LUNAR_PH["3b"])
SUN_LUNAR_PH["4"] = max(SUN_LUNAR_PH["4a"], SUN_LUNAR_PH["4b"])
SUN_LUNAR_PH["5"] = max(SUN_LUNAR_PH["5a"], SUN_LUNAR_PH["5b"])


CLK_SUN = {
    "1": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["1_n"],
        CLK_SUN_STR["gears"]["1_2a_mod"],
    ),
    "2a": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["2a_n"],
        CLK_SUN_STR["gears"]["1_2a_mod"],
    ),
    "2b": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["2b_n"],
        CLK_SUN_STR["gears"]["2b_3a_mod"],
    ),
    "3a": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["3a_n"],
        CLK_SUN_STR["gears"]["2b_3a_mod"],
    ),
    "3b": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["3b_n"],
        CLK_SUN_STR["gears"]["3b_4a_mod"],
    ),
    "4a": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["4a_n"],
        CLK_SUN_STR["gears"]["3b_4a_mod"],
    ),
    "4b": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["4b_n"],
        CLK_SUN_STR["gears"]["4b_5a_mod"],
    ),
    "5a": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["5a_n"],
        CLK_SUN_STR["gears"]["4b_5a_mod"],
    ),
    "5b": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["5b_n"],
        CLK_SUN_STR["gears"]["5b_6a_mod"],
    ),
    "6a": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["6a_n"],
        CLK_SUN_STR["gears"]["5b_6a_mod"],
    ),
    "6b": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["6b_n"],
        CLK_SUN_STR["gears"]["6b_7_8_mod"],
    ),
    "7": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["7_n"],
        CLK_SUN_STR["gears"]["6b_7_8_mod"],
    ),
    "8": spur_gear_max_radius(
        CLK_SUN_STR["gears"]["8_n"],
        CLK_SUN_STR["gears"]["6b_7_8_mod"],
    ),
}
CLK_SUN["2"] = max(CLK_SUN["2a"], CLK_SUN["2b"])
CLK_SUN["3"] = max(CLK_SUN["3a"], CLK_SUN["3b"])
CLK_SUN["4"] = max(CLK_SUN["4a"], CLK_SUN["4b"])
CLK_SUN["5"] = max(CLK_SUN["5a"], CLK_SUN["5b"])
CLK_SUN["6"] = max(CLK_SUN["6a"], CLK_SUN["6b"])


SUN_MOON = {
    "1": spur_gear_max_radius(
        SUN_MOON_STR["gears"]["1_n"],
        SUN_MOON_STR["gears"]["1_2_mod"],
    ),
    "2": spur_gear_max_radius(
        SUN_MOON_STR["gears"]["2_n"],
        SUN_MOON_STR["gears"]["1_2_mod"],
    ),
    "3": spur_gear_max_radius(
        SUN_MOON_STR["gears"]["3_n"],
        SUN_MOON_STR["gears"]["3_4_mod"],
    ),
    "4": spur_gear_max_radius(
        SUN_MOON_STR["gears"]["4_n"],
        SUN_MOON_STR["gears"]["3_4_mod"],
    ),
}


def clock_to_sun():
    # Collision with outer carrier
    assert CLK_SUN_STR["1_r"] + CLK_SUN["1"] + tol < carrier_outer_rim_inner
    assert CLK_SUN_STR["2_r"] + CLK_SUN["2"] + tol < carrier_outer_rim_inner
    assert CLK_SUN_STR["3_r"] + CLK_SUN["3"] + tol < carrier_outer_rim_inner
    assert CLK_SUN_STR["4_r"] + CLK_SUN["4"] + tol < carrier_outer_rim_outer
    assert CLK_SUN_STR["5_r"] + CLK_SUN["5"] + tol < carrier_outer_rim_inner
    assert CLK_SUN_STR["6_r"] + CLK_SUN["6"] + tol < carrier_outer_rim_inner
    assert CLK_SUN_STR["7_r"] + CLK_SUN["7"] + tol < carrier_outer_rim_inner
    # Other
    assert CLK_SUN["3"] + shaft_with_sleeve + tol < CLK_SUN_STR["dist_CD"]
    assert CLK_SUN["5"] + shaft_with_sleeve + tol < CLK_SUN_STR["dist_CD"]
    assert CLK_SUN["4"] + shaft_with_sleeve + tol < CLK_SUN_STR["dist_AB"]
    assert CLK_SUN["6"] + shaft_with_sleeve + tol < CLK_SUN_STR["dist_AB"]


def moon_to_zodiac():
    # Collision with outer carrier
    assert MOON_ZODIAC_STR["1_r"] + MOON_ZODIAC["1"] + tol < carrier_outer_rim_inner
    assert MOON_ZODIAC_STR["2_r"] + MOON_ZODIAC["2"] + tol < carrier_outer_rim_outer
    assert MOON_ZODIAC_STR["3_r"] + MOON_ZODIAC["3"] + tol < carrier_outer_rim_inner
    assert MOON_ZODIAC_STR["4_r"] + MOON_ZODIAC["4"] + tol < carrier_outer_rim_inner
    assert MOON_ZODIAC_STR["5_r"] + MOON_ZODIAC["5"] + tol < carrier_outer_rim_inner
    # Other
    assert MOON_ZODIAC["2"] + MOON_ZODIAC["5"] + tol < MOON_ZODIAC_STR["dist_12"]
    assert MOON_ZODIAC["3a"] + MOON_ZODIAC["4b"] + tol < MOON_ZODIAC_STR["dist_34"]


def sun_to_lunar_nodes():
    # Collision with outer carrier
    assert SUN_LUNAR_N_STR["1_r"] + SUN_LUNAR_N["1"] + tol < carrier_outer_rim_inner
    assert SUN_LUNAR_N_STR["2_r"] + SUN_LUNAR_N["2"] + tol < carrier_outer_rim_inner
    assert SUN_LUNAR_N_STR["3_r"] + SUN_LUNAR_N["3"] + tol < carrier_outer_rim_inner


def sun_to_lunar_phases():
    # Collision with outer carrier
    assert SUN_LUNAR_PH_STR["1_r"] + SUN_LUNAR_PH["1"] + tol < carrier_outer_rim_inner
    assert SUN_LUNAR_PH_STR["2_r"] + SUN_LUNAR_PH["2"] + tol < carrier_outer_rim_inner
    assert SUN_LUNAR_PH_STR["3_r"] + SUN_LUNAR_PH["3"] + tol < carrier_outer_rim_inner
    assert SUN_LUNAR_PH_STR["4_r"] + SUN_LUNAR_PH["4"] + tol < carrier_outer_rim_inner
    assert SUN_LUNAR_PH_STR["5_r"] + SUN_LUNAR_PH["5"] + tol < carrier_outer_rim_outer
    # Other
    assert SUN_LUNAR_PH["1"] + shaft_with_sleeve + tol < SUN_LUNAR_PH_STR["dist_d13"]
    assert SUN_LUNAR_PH["2"] + shaft_with_sleeve + tol < SUN_LUNAR_PH_STR["dist_d23"]
    assert SUN_LUNAR_PH["3a"] + SUN_LUNAR_PH["4b"] + tol < SUN_LUNAR_PH_STR["dist_d34"]
    assert SUN_LUNAR_PH["5"] + shaft_with_sleeve + tol < SUN_LUNAR_PH_STR["dist_d35"]


def sun_to_moon():
    # Collision with outer carrier
    assert SUN_MOON_STR["1_r"] + SUN_MOON["1"] + tol < carrier_outer_rim_inner
    assert SUN_MOON_STR["2_r"] + SUN_MOON["2"] + tol < carrier_outer_rim_inner
    assert SUN_MOON_STR["3_r"] + SUN_MOON["3"] + tol < carrier_outer_rim_inner
    assert SUN_MOON_STR["4_r"] + SUN_MOON["4"] + tol < carrier_outer_rim_inner


def between_parts():
    # Sun to lunar phases shafts
    assert CLK_SUN["7"] + shaft_with_sleeve + tol < SUN_LUNAR_PH_STR["dist_d12"]
    assert CLK_SUN["7"] + shaft_with_sleeve + tol < SUN_LUNAR_PH_STR["dist_d13"]
    assert SUN_LUNAR_N["1"] + shaft_with_sleeve < SUN_LUNAR_PH_STR["dist_d12"]
    assert SUN_LUNAR_N["1"] + shaft_with_sleeve < SUN_LUNAR_PH_STR["dist_d13"]
    # Clock to sun shafts
    assert SUN_LUNAR_N["1"] + shaft_with_sleeve < CLK_SUN_STR["7_r"]
    # Sun to moon vs moon to zodiac
    assert (
        MOON_ZODIAC["1"]
        + CONSTANTS["gears_shaft_radius"]
        + 1.5 * CONSTANTS["spacer_sleeve"]
        + tol
        < SUN_MOON_STR["dist_12"]
    )
    assert SUN_MOON["1"] + MOON_ZODIAC["4a"] + tol < MOON_ZODIAC_STR["4_r"]
    # Clock to sun vs sun to moon
    assert SUN_MOON["1"] + CLK_SUN["2a"] + tol < CLK_SUN_STR["2a_r"]
    # Clock to sun vs moon to zodiac
    assert MOON_ZODIAC["1"] + shaft_with_sleeve + tol < CLK_SUN_STR["2a_r"]


def detect_collisions():
    clock_to_sun()
    moon_to_zodiac()
    sun_to_lunar_nodes()
    sun_to_lunar_phases()
    sun_to_moon()
    between_parts()


detect_collisions()
