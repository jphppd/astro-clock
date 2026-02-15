from math import pi
from . import env

DATA = {
    "1_r": 0.0,
    "2_r": (env.DATA["1_n"] + env.DATA["2_n"]) * env.DATA["1_2_mod"] / 2,
    "3_r": (env.DATA["1_n"] + env.DATA["2_n"]) * env.DATA["1_2_mod"] / 2,
    "4_r": 0.0,
    "theta": 1 / 10 * pi,
    "1_offset": 5,
    "2_offset": 5,
    "3_offset": 0,
    "4_offset": 0,
    "gears": env.DATA,
}
