$(CURDIR)/utils/constants/%.scad: $(CURDIR)/utils/constants/%.py $(CURDIR)/utils/py2scad.py
	@echo Generating $@ from $<
	@mkdir --parents $(dir $@)
	@python3 utils/py2scad.py $< $@

$(CURDIR)/utils/constants/structure.scad: $(CURDIR)/utils/constants/constants.py

PY_FILES += $(CURDIR)/utils/constants/constants.py
PY_FILES += $(CURDIR)/utils/constants/structure.py

CONSTANTS_SUBDIRS := $(CURDIR)/utils/constants/clock_to_sun $(CURDIR)/utils/constants/moon_to_zodiac $(CURDIR)/utils/constants/sun_to_lunar_nodes $(CURDIR)/utils/constants/sun_to_lunar_phases $(CURDIR)/utils/constants/sun_to_moon
include $(CONSTANTS_SUBDIRS:%=%/Makefile)
