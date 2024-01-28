DATA = {
    "1_2a_mod": 1.4,
    "1_n": 103,
    "2a_n": 59,
    "2b_n": 54,
    "3_n": 94,
}

DATA["2b_3_mod"] = (
    DATA["1_2a_mod"] * (DATA["1_n"] + DATA["2a_n"]) / (DATA["2b_n"] + DATA["3_n"])
)
