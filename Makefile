.SUFFIXES:
.DEFAULT_GOAL := all
TARGET := clock.blend
SUBDIRS := utils/constants parts

all: $(TARGET)

include $(SUBDIRS:%=%/Makefile)

%.stl: %.scad $(CURDIR)/utils/constants/constants.scad
	@echo Generating $(basename $(notdir $@))
	@openscad --hardwarnings -o $@ --export-format binstl $<

.PHONY: clean
clean:
	@find parts -type f -name '*.stl' -delete
	@find parts -type f -name '*.pyc' -delete
	@find utils/constants -type f -name "*scad" -delete
	@rm --force clock.blend


clock.blend: parts_merger.py $(STL_FILES) $(PY_FILES)
	@rm --force $@
	blender --background --python parts_merger.py
