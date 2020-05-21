stl =  $(shell ls src/*.scad | sed 's/src/output/g' | sed 's/scad/stl/g')

output/%.stl: src/%.scad
	mkdir -p `dirname $@`
	openscad $^ -o $@

.PHONY: all

all: $(stl)
