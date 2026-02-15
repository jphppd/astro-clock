from fractions import Fraction
import math

DATA = {
    "1_2a_mod": 1.2,
    "2b_3a_mod": 1.55,
    "3b_4a_mod": 1.35,
    "6b_7_mod": 1.72,
    "1_n": 23,
    "2a_n": 50,
    "2b_n": 21,
    "3a_n": 50,
    "3b_n": 15,
    "4a_n": 68,
    "4b_n": 17,
    "5a_n": 60,
    "5b_n": 23,
    "6a_n": 70,
    "6b_n": 15,
    "7_n": 92,
}


DATA["4b_5a_mod"] = (
    DATA["3b_4a_mod"] * (DATA["3b_n"] + DATA["4a_n"]) / (DATA["4b_n"] + DATA["5a_n"])
)
DATA["5b_6a_mod"] = (
    DATA["3b_4a_mod"] * (DATA["3b_n"] + DATA["4a_n"]) / (DATA["5b_n"] + DATA["6a_n"])
)


ratio_1_2 = Fraction(DATA["1_n"], DATA["2a_n"])
ratio_2_3 = Fraction(DATA["2b_n"], DATA["3a_n"])
ratio_3_4 = Fraction(DATA["3b_n"], DATA["4a_n"])
ratio_4_5 = Fraction(DATA["4b_n"], DATA["5a_n"])
ratio_5_6 = Fraction(DATA["5b_n"], DATA["6a_n"])
ratio_6_7 = Fraction(DATA["6b_n"], DATA["7_n"])

assert (
    ratio_1_2 * ratio_2_3 * ratio_3_4 * ratio_4_5 * ratio_5_6 * ratio_6_7
    == Fraction(207, 320000)
)

assert math.gcd(DATA["1_n"], DATA["2a_n"]) == 1
assert math.gcd(DATA["2b_n"], DATA["3a_n"]) == 1
assert math.gcd(DATA["3b_n"], DATA["4a_n"]) == 1
assert math.gcd(DATA["4b_n"], DATA["5a_n"]) == 1
assert math.gcd(DATA["5b_n"], DATA["6a_n"]) == 1
assert math.gcd(DATA["6b_n"], DATA["7_n"]) == 1
