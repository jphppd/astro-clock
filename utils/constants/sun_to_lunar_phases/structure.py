import math
from math import pi
from . import env


def cosine_law_a(b, c, alpha):
    return math.sqrt(b * b + c * c - 2 * b * c * math.cos(alpha))


def cosine_law_alpha(b, c, a):
    return math.acos((b * b + c * c - a * a) / (2 * b * c))


#       1
#   2~4
#      3~5

a213 = 0.7 * pi / 5
d12 = (env.DATA["1_n"] + env.DATA["2a_n"]) * env.DATA["1_2a_mod"] / 2
d23 = (env.DATA["2b_n"] + env.DATA["3a_n"]) * env.DATA["2b_3a_mod"] / 2
d13 = math.sqrt(d23**2 - d12**2 * math.sin(a213) ** 2) + d12 * math.cos(a213)

DATA = {
    "1_r": 0.0,
    "2_r": d12,
    "3_r": d13,
    "2_theta": -a213,
    "theta": 1 / 2 * pi,
    "1_offset": 0,
    "2_offset": 0,
    "3_offset": 1,
    "4_offset": 2,
    "5_offset": 3,
    "6_offset": 8,
    "7_offset": 9,
}

DATA["4_r"] = DATA["2_r"]
DATA["5_r"] = DATA["3_r"]
DATA["4_theta"] = DATA["2_theta"]

DATA["6_r"] = DATA["5_r"]
DATA["7_r"] = DATA["5_r"]

DATA["4_theta"] = DATA["2_theta"]
