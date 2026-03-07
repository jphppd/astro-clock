from fractions import Fraction

DATA = {
    "mod": 1.0,
    "1_n": 131,
    "2a_n": 60,
    "2b_n": 103,
    "3a_n": 81,
    "3b_n": 60,
    "4a_n": 90,
    "4b_n": 60,
    "5_n": 107,
}

ratio_1_2 = Fraction(DATA["1_n"], DATA["2a_n"])
ratio_2_3 = Fraction(DATA["2b_n"], DATA["3a_n"])
ratio_3_4 = Fraction(DATA["3b_n"], DATA["4a_n"])
ratio_4_5 = Fraction(DATA["4b_n"], DATA["5_n"])

assert ratio_1_2 * ratio_2_3 * ratio_3_4 * ratio_4_5 == Fraction(26986, 26001)
