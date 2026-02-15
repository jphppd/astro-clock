from math import pi
from . import env

DATA = {
    "1_r": 0,
    "2_r": (env.DATA["1_n"] + env.DATA["2a_n"]) * env.DATA["1_2a_mod"] / 2,
    "3_r": 0,
    "theta": 13 / 10 * pi,
    "1_offset": 0,
    "2_offset": 0,
    "3_offset": 1,
    "gears": env.DATA,
}
