$(CURDIR)/utils/constants/%.scad: $(CURDIR)/utils/constants/%.py $(CURDIR)/utils/py2scad.py
	@echo Generating $@ from $<
	@mkdir --parents $(dir $@)
	@python3 utils/py2scad.py $< $@

$(CURDIR)/utils/constants/structure.scad: $(CURDIR)/utils/constants/constants.py

PY_FILES += $(CURDIR)/utils/constants/constants.py
PY_FILES += $(CURDIR)/utils/constants/structure.py
