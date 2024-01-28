STL_FILES += $(CURDIR)/parts/motor/motor_case.stl
STL_FILES += $(CURDIR)/parts/motor/motor_cap.stl

MOTOR_DEPS = $(CURDIR)/utils/constants/structure.scad

$(CURDIR)/parts/motor/motor_case.stl: $(MOTOR_DEPS)
$(CURDIR)/parts/motor/motor_cap.stl: $(CURDIR)/parts/motor/motor_case.scad $(MOTOR_DEPS)
