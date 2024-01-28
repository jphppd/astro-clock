from fractions import Fraction

DATA = {
    "mod": 1.4,
    "1_2a_mod": 1.3,
    "2b_3a_mod": 1.45,
    "6b_7_mod": 1.6,
    "1_n": 23,
    "2a_n": 50,
    "2b_n": 27,
    "3a_n": 50,
    "3b_n": 16,
    "4a_n": 64,
    "4b_n": 16,
    "5a_n": 64,
    "5b_n": 16,
    "6a_n": 64,
    "6b_n": 16,
    "7_n": 96,
}

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
