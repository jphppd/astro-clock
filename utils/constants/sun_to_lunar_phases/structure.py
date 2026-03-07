import math
from math import pi
import numpy as np
from scipy.optimize import fsolve
from . import env
from ..structure import DATA as STRUCT_DATA


def cosine_law_a(b, c, alpha):
    return math.sqrt(b * b + c * c - 2 * b * c * math.cos(alpha))


def cosine_law_alpha(b, c, a):
    return math.acos((b * b + c * c - a * a) / (2 * b * c))


d12 = (env.DATA["1_n"] + env.DATA["2a_n"]) * env.DATA["1_2a_mod"] / 2
d23 = (env.DATA["2b_n"] + env.DATA["3a_n"]) * env.DATA["2b_3a_mod"] / 2
d34 = (env.DATA["3b_n"] + env.DATA["4a_n"]) * env.DATA["3b_4a_mod"] / 2
d45 = (env.DATA["4b_n"] + env.DATA["5a_n"]) * env.DATA["4b_5a_mod"] / 2
d15 = STRUCT_DATA["carrier_outer_radius"] + STRUCT_DATA["annulus_sagitta"] - env.DATA["4b_5a_mod"] * env.DATA["5a_n"]/2 - 1.5

#    5
#      4
#    3
#  2
#    1
# theta = angle(31,32) = angle(34,35)
# alpha = angle(12,13)
# beta = angle(53,54)


def eqn_solve(x):
    theta, alpha, beta = x

    eqn1 = d12 * np.cos(alpha) + d45 * np.cos(beta) + (d23 + d34) * np.cos(theta) - d15
    eqn2 = (
        d12**2
        + d23**2
        + 2 * d12 * d23 * np.cos(alpha + theta)
        - (d12 * np.cos(alpha) + d23 * np.cos(theta)) ** 2
    )
    eqn3 = (
        d34**2
        + d45**2
        + 2 * d34 * d45 * np.cos(beta + theta)
        - (d45 * np.cos(beta) + d34 * np.cos(theta)) ** 2
    )

    return [eqn1, eqn2, eqn3]


theta, alpha, beta = fsolve(eqn_solve, [np.pi / 4, np.pi / 4, np.pi / 4])

d13 = cosine_law_a(d12, d23, np.pi - theta - alpha)
x2 = d12 * math.cos(alpha)
y2 = d12 * math.sin(alpha)
x3 = d13
y3 = 0
x4 = math.hypot(x3, y3) + d34 * math.cos(theta)
y4 = -d34 * math.sin(theta)
x5 = d15
y5 = 0

DATA = {
    "1_r": 0.0,
    "2_r": math.hypot(x2, y2),
    "3_r": math.hypot(x3, y3),
    "4_r": math.hypot(y4, x4),
    "5_r": math.hypot(x5, y5),
    "6_r": math.hypot(x5, y5),
    "2_theta": math.atan2(y2, x2),
    "3_theta": math.atan2(y3, x3),
    "4_theta": math.atan2(y4, x4),
    "5_theta": math.atan2(y5, x5),
    "6_theta": math.atan2(y5, x5),
    "theta": 1 / 2 * pi,
    "1_offset": 1,
    "2_offset": 1,
    "3_offset": 2,
    "4_offset": 4,
    "5_offset": 0,
    "6_offset": 0,
    "4_mirror": True,
    "gears": env.DATA,
    "dist_d12": d12,
    "dist_d13": d13,
    "dist_d23": d23,
    "dist_d34": d34,
    "dist_d35": math.hypot(x5 - x3, y5 - y3),
}
