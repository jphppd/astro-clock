import math
from math import pi, tau
from . import env


def cosine_law_a(b, c, alpha):
    return math.sqrt(b * b + c * c - 2 * b * c * math.cos(alpha))


def cosine_law_alpha(b, c, a):
    return math.acos((b * b + c * c - a * a) / (2 * b * c))


#             2
#   1=5      /
#           /     3
#          4


DATA = {
    "theta": 1 / 10 * pi,
    "1_r": 0.0,
    "1_theta": 0.0,
    "5_r": 0.0,
    "5_theta": 0.0,
    "aperture_theta": tau / 8,
    "1_offset": 0,
    "2_offset": 2,
    "3_offset": 1,
    "4_offset": 2,
    "5_offset": 3,
    "2_mirror": True,
    "c2_mirror": True,
    "gears": env.DATA,
}
a214 = DATA["aperture_theta"]
d12 = (env.DATA["1_n"] + env.DATA["2a_n"]) * env.DATA["mod"] / 2
d14 = (env.DATA["4b_n"] + env.DATA["5_n"]) * env.DATA["mod"] / 2
d23 = (env.DATA["2b_n"] + env.DATA["3a_n"]) * env.DATA["mod"] / 2
d34 = (env.DATA["3b_n"] + env.DATA["4a_n"]) * env.DATA["mod"] / 2
d24 = cosine_law_a(d12, d14, a214)
a124 = cosine_law_alpha(d12, d24, d14)
a423 = cosine_law_alpha(d24, d23, d34)
a123 = a124 + a423
d13 = cosine_law_a(d12, d23, a123)
a213 = cosine_law_alpha(d12, d13, d23)

DATA["2_r"] = (env.DATA["1_n"] + env.DATA["2a_n"]) * env.DATA["mod"] / 2
DATA["2_theta"] = -DATA["aperture_theta"] / 2
DATA["4_r"] = (env.DATA["5_n"] + env.DATA["4b_n"]) * env.DATA["mod"] / 2
DATA["4_theta"] = DATA["aperture_theta"] / 2
DATA["3_r"] = d13
DATA["3_theta"] = DATA["2_theta"] + a213
