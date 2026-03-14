from fractions import Fraction

DATA = {
    "1_2_mod": 1.37,
    "1_n": 83,
    "2_n": 70,
    "3_n": 66,
    "4_n": 81,
}

DATA["3_4_mod"] = (
    DATA["1_2_mod"] * (DATA["1_n"] + DATA["2_n"]) / (DATA["3_n"] + DATA["4_n"])
)

ratio_1_2 = Fraction(DATA["1_n"], DATA["2_n"])
ratio_3_4 = Fraction(DATA["3_n"], DATA["4_n"])

assert ratio_1_2 * ratio_3_4 == Fraction(913, 945)
