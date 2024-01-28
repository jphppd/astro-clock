STL_FILES += $(CURDIR)/parts/structure/carrier_2/c2_carrier_1.stl
STL_FILES += $(CURDIR)/parts/structure/carrier_2/c2_carrier_2.stl

CARRIER_2_DEPS += $(CURDIR)/utils/constants/moon_to_zodiac/structure.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/clock_to_sun/structure.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/sun_to_moon/structure.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/sun_to_lunar_nodes/structure.scad
CARRIER_2_DEPS += $(CURDIR)/utils/constants/sun_to_lunar_phases/structure.scad
CARRIER_2_DEPS += $(CURDIR)/parts/structure/carrier_2/c2_sector_moon_to_zodiac.module.scad
CARRIER_2_DEPS += $(CURDIR)/parts/structure/carrier_2/c2_sector_sun_to_moon.module.scad
CARRIER_2_DEPS += $(CURDIR)/parts/structure/carrier_2/c2_sector_clock_to_sun.module.scad
CARRIER_2_DEPS += $(CURDIR)/parts/structure/carrier_2/c2_sector_sun_to_lunar_nodes.module.scad
CARRIER_2_DEPS += $(CURDIR)/parts/structure/carrier_2/c2_sector_sun_to_lunar_phases.module.scad
CARRIER_2_DEPS += $(STRUCTURE_DEPS)

$(CURDIR)/parts/structure/carrier_2/c2_carrier_1.scad: $(CARRIER_2_DEPS)
$(CURDIR)/parts/structure/carrier_2/c2_carrier_2.scad: $(CARRIER_2_DEPS)