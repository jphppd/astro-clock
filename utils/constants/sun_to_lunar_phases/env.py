from math import pi, sin

DATA = {
    "1_2a_mod": 2,
    "2b_3a_mod": 1.9,
    "6_7_mod": 1.0,
    "1_n": 20,
    "2a_n": 50,
    "2b_n": 20,
    "3a_n": 50,
    "3b_n": 20,
    "4a_n": 45,
    "4b_n": 20,
    "5_n": 42,
    "6_n": 30,
}

DATA["1_n"] *= 2
DATA["5_n"] *= 2

DATA["3b_4a_mod"] = (
    DATA["2b_3a_mod"] * (DATA["2b_n"] + DATA["3a_n"]) / (DATA["3b_n"] + DATA["4a_n"])
)
DATA["4b_5_mod"] = (
    DATA["2b_3a_mod"] * (DATA["2b_n"] + DATA["3a_n"]) / (DATA["4b_n"] + DATA["5_n"])
)
DATA["7_n"] = DATA["6_n"]
DATA["bevel_offset"] = (
    (sin(pi / 4 + 1 / 20 + 2.2173 / DATA["6_n"]) - sin(pi / 4))
    * DATA["6_n"]
    * DATA["6_7_mod"]
    / 2
)
