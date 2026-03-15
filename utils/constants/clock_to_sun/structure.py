import math
from . import env


def cosine_law_alpha(b, c, a):
    return math.acos((b * b + c * c - a * a) / (2 * b * c))


DATA = {
    "theta": 17 / 10 * math.pi,
    "c3_mirror": True,
    "1_mirror": True,
    "1_offset": -1,
    "2a_offset": -2,
    "4_offset": 1,
    "5_offset": 2,
    "6a_offset": 3,
}

#        A[7]
# O[8       B[4,6]
#        C[3,5]
#    D[2]
# E[1]


rOA = (env.DATA["7_n"] + env.DATA["8_n"]) * env.DATA["6b_7_8_mod"] / 2
rAB = (env.DATA["6b_n"] + env.DATA["7_n"]) * env.DATA["6b_7_8_mod"] / 2
rBC = (env.DATA["5b_n"] + env.DATA["6a_n"]) * env.DATA["5b_6a_mod"] / 2
rCD = (env.DATA["2b_n"] + env.DATA["3a_n"]) * env.DATA["2b_3a_mod"] / 2
rDE = (env.DATA["1_n"] + env.DATA["2a_n"]) * env.DATA["1_2a_mod"] / 2

rOE = 110 / 0.75
rOD = rOE
rOC = rOE
rOB = rOE

thetaOE = -math.radians(90) - DATA["theta"]
thetaOD = thetaOE + cosine_law_alpha(rOD, rOE, rDE)
thetaOC = thetaOD + cosine_law_alpha(rOC, rOD, rCD)
thetaOB = thetaOC + cosine_law_alpha(rOB, rOC, rBC)
thetaOA = thetaOB + cosine_law_alpha(rOA, rOB, rAB)

assert not math.isnan(rOA)
assert not math.isnan(rOB)
assert not math.isnan(rOC)
assert not math.isnan(rOD)
assert not math.isnan(rOE)
assert not math.isnan(thetaOA)
assert not math.isnan(thetaOB)
assert not math.isnan(thetaOC)
assert not math.isnan(thetaOD)
assert not math.isnan(thetaOE)

DATA = {
    **DATA,
    "1_r": rOE,
    "2_r": rOD,
    "2a_r": rOD,
    "2b_r": rOD,
    "3_r": rOC,
    "4_r": rOB,
    "5_r": rOC,
    "6_r": rOB,
    "6a_r": rOB,
    "6b_r": rOB,
    "7_r": rOA,
    "8_r": 0.0,
    "1_theta": thetaOE,
    "2_theta": thetaOD,
    "2a_theta": thetaOD,
    "2b_theta": thetaOD,
    "3_theta": thetaOC,
    "4_theta": thetaOB,
    "5_theta": thetaOC,
    "6a_theta": thetaOB,
    "6b_theta": thetaOB,
    "7_theta": thetaOA,
    "8_theta": 0.0,
    "dist_AB": rAB,
    "dist_BC": rBC,
    "dist_CD": rCD,
    "dist_DE": rDE,
    "gears": env.DATA,
}
