DATA = {
    "1_2_mod": 1.5,
    "1_n": 83,
    "2_n": 70,
    "3_n": 66,
    "4_n": 81,
}

DATA["3_4_mod"] = (
    DATA["1_2_mod"] * (DATA["1_n"] + DATA["2_n"]) / (DATA["3_n"] + DATA["4_n"])
)
