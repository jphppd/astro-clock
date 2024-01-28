from . import constants

DATA = {
    "carrier_outer_radius": 200,
    "outer_annulus_sagitta": 15,
    "annulus_sagitta": 6,
    "spoke_width": 2
    * (constants.DATA["gears_shaft_radius"] + constants.DATA["spacer_sleeve"]),
    "nb_of_annuli": 3,
    "hub_split": 0.65,
}
DATA["carrier_inner_radius"] = DATA["carrier_outer_radius"] - DATA["annulus_sagitta"]
DATA["hub_radius"] = 0.1 * DATA["carrier_outer_radius"]
DATA["spoke_length"] = DATA["carrier_inner_radius"] + 2 * constants.DATA["eps"]
DATA["tympan_scale_factor"] = (
    DATA["carrier_outer_radius"] / constants.DATA["stereo_proj_scale_factor"]
)
