.PHONY: cmake-init cmake-update cmake-purge

URL=https://github.com/sz3kz/dotfiles.git
ROOT_DIRECTORY=external/dotfiles/
CPP_DIRECTORY=CPP/
MAKEFILE_DIRECTORY=make/
CMAKE_CLIENT_MAKEFILE=cmake.mk

# This initializes the existing cmake
cmake-init:
	git submodule update --init													# fetches existing commit
	cd ${ROOT_DIRECTORY}${CPP_DIRECTORY} && make sync

# This updates the target cmake 
cmake-update:
	git submodule update --init --remote								# fetches latest commit
	cd ${ROOT_DIRECTORY}${CPP_DIRECTORY} && make deploy

cmake-purge:
	git rm -f ${ROOT_DIRECTORY}
	-git rm --cached ${ROOT_DIRECTORY}
	-git config -f .git/config --remove-section submodule.${ROOT_DIRECTORY}
	-git config -f .gitmodules --remove-section submodule.${ROOT_DIRECTORY}
	-rm -rf .git/modules/${ROOT_DIRECTORY}
	rm ${MAKEFILE_DIRECTORY}${CMAKE_CLIENT_MAKEFILE}
	-rmdir ${MAKEFILE_DIRECTORY}
