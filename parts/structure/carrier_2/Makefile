STL_FILES += $(CURDIR)/parts/structure/carrier_2/c2_carrier_1.stl
STL_FILES += $(CURDIR)/parts/structure/carrier_2/c2_carrier_2.stl

CARRIER_2_DEPS += $(CURDIR)/utils/constants/constants.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/structure.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/moon_to_zodiac/structure.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/clock_to_sun/structure.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/sun_to_moon/structure.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/sun_to_lunar_nodes/structure.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/sun_to_lunar_phases/structure.scad

$(CURDIR)/parts/structure/carrier_2/c2_carrier_1.scad: $(CARRIER_2_DEPS)
$(CURDIR)/parts/structure/carrier_2/c2_carrier_2.scad: $(CARRIER_2_DEPS)