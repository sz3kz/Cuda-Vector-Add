.PHONY: ncu-sync

NCU_SECTION_DIRECTORY=.ncu-compute-profiler/
NCU_BINARY_PATH=$(shell which ncu)

# This initializes the existing cmake
ncu-sync:
	mkdir ${NCU_SECTION_DIRECTORY}
	cp ${NCU_BINARY_PATH}../../sections/*.section ${NCU_SECTION_DIRECTORY}
	cp ${NCU_BINARY_PATH}../../sections/*.py ${NCU_SECTION_DIRECTORY}

ncu-purge:
	rm -r ${NCU_SECTION_DIRECTORY}
