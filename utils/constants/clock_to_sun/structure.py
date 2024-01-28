import math
import sympy
from . import env

DATA = {
    "theta": 17 / 10 * math.pi,
    "c3_mirror": True,
    "2_mirror": True,
    "1_offset": 1,
    "2_offset": 2,
    "4_offset": 1,
    "5_offset": 2,
    "6a_offset": 3,
}

rOA = (env.DATA["6b_n"] + env.DATA["7_n"]) * env.DATA["6b_7_mod"] / 2
rAB = (env.DATA["5b_n"] + env.DATA["6a_n"]) * env.DATA["mod"] / 2
rBC = (env.DATA["3a_n"] + env.DATA["2b_n"]) * env.DATA["2b_3a_mod"] / 2
rCD = (env.DATA["1_n"] + env.DATA["2a_n"]) * env.DATA["1_2a_mod"] / 2


rOD = 135 / 0.75
thetaOA = math.radians(-40) - DATA["theta"]
thetaAB = math.radians(-90) - DATA["theta"]
thetaOD = -math.radians(90) - DATA["theta"]


xOA, yOA, xAB, yAB, xBC, yBC, xCD, yCD, xOD, yOD = sympy.symbols(
    "xOA yOA xAB yAB xBC yBC xCD yCD xOD yOD"
)

xOA = rOA * math.cos(thetaOA)
yOA = rOA * math.sin(thetaOA)
xAB = rAB * math.cos(thetaAB)
yAB = rAB * math.sin(thetaAB)
xOD = rOD * math.cos(thetaOD)
yOD = rOD * math.sin(thetaOD)

F = [
    xBC**2 + yBC**2 - rBC**2,
    xCD**2 + yCD**2 - rCD**2,
    xOA + xAB + xBC + xCD - xOD,
    yOA + yAB + yBC + yCD - yOD,
]
gb = sympy.groebner(F, xBC, yBC, xCD, yCD, order="grlex")

value_yCD, value_xBC = sympy.solve_poly_system(gb[0:2], yCD, xBC)[0]
rules = {yCD: value_yCD, xBC: value_xBC}

value_xCD, value_yBC = sympy.solve_poly_system(
    [gb[2].subs(rules), gb[3].subs(rules)], xCD, yBC
)[0]


xOA = float(xOA)
xOB = float(xOA + xAB)
xOC = float(xOB + value_xBC)
xOD = float(xOC + value_xCD)
yOA = float(yOA)
yOB = float(yOA + yAB)
yOC = float(yOB + value_yBC)
yOD = float(yOC + value_yCD)

rOA = math.hypot(xOA, yOA)
rOB = math.hypot(xOB, yOB)
rOC = math.hypot(xOC, yOC)
rOD = math.hypot(xOD, yOD)
thetaOA = math.atan2(yOA, xOA)
thetaOB = math.atan2(yOB, xOB)
thetaOC = math.atan2(yOC, xOC)
thetaOD = math.atan2(yOD, xOD)

assert not math.isnan(rOA)
assert not math.isnan(rOB)
assert not math.isnan(rOC)
assert not math.isnan(rOD)


#
#       A
#   O        B
#              C
#                D

DATA = {
    **DATA,
    "1_r": rOD,
    "2_r": rOC,
    "3_r": rOB,
    "4_r": rOA,
    "5_r": rOB,
    "6a_r": rOA,
    "6b_r": rOA,
    "7_r": 0.0,
    "1_theta": thetaOD,
    "2_theta": thetaOC,
    "3_theta": thetaOB,
    "4_theta": thetaOA,
    "5_theta": thetaOB,
    "6a_theta": thetaOA,
    "6b_theta": thetaOA,
    "7_theta": 0,
}
