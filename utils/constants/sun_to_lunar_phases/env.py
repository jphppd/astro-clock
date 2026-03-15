from fractions import Fraction
from math import pi, sin

DATA = {
    "1_2a_mod": 1.95,
    "2b_3a_mod": 1.7,
    "3b_4a_mod": 1.8,
    "4b_5a_mod": 1.18,
    "5b_6_mod": 1.2,
    "1_n": 40,
    "2a_n": 50,
    "2b_n": 20,
    "3a_n": 50,
    "3b_n": 20,
    "4a_n": 45,
    "4b_n": 20,
    "5a_n": 84,
    "5b_n": 21,
    "6_n": 21,
}

DATA["bevel_offset"] = (
    (sin(pi / 4 + 1 / 20 + 2.2173 / DATA["6_n"]) - sin(pi / 4))
    * DATA["6_n"]
    * DATA["5b_6_mod"]
    / 2
)

ratio_1_2 = Fraction(DATA["1_n"], DATA["2a_n"])
ratio_2_3 = Fraction(DATA["2b_n"], DATA["3a_n"])
ratio_3_4 = Fraction(DATA["3b_n"], DATA["4a_n"])
ratio_4_5 = Fraction(DATA["4b_n"], DATA["5a_n"])
ratio_5_6 = Fraction(DATA["5b_n"], DATA["6_n"])

assert ratio_1_2 * ratio_2_3 * ratio_3_4 * ratio_4_5 * ratio_5_6 == Fraction(32, 945)
