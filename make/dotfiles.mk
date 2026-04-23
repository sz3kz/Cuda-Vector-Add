.PHONY: dotfiles-init dotfiles-update dotfiles-purge

URL=https://github.com/sz3kz/dotfiles.git
ROOT_DIRECTORY=external/dotfiles/
CPP_DIRECTORY=CPP/
MAKEFILE_DIRECTORY=make/
CMAKE_CLIENT_MAKEFILE=cmake.mk


#Create "make/" directory
dotfiles-setup:
	-mkdir ${CLIENT_ROOT_DIRECTORY}${MAKEFILE_DIRECTORY}

# This updates the target cmake 
dotfiles-update:
	git submodule update --init --remote								# fetches latest commit
	cd ${ROOT_DIRECTORY}${CPP_DIRECTORY} && make cmake--initialize
	cd ${ROOT_DIRECTORY}${CPP_DIRECTORY} && make ncu-sync

dotfiles-purge:
	git rm -f ${ROOT_DIRECTORY}
	-git rm --cached ${ROOT_DIRECTORY}
	-git config -f .git/config --remove-section submodule.${ROOT_DIRECTORY}
	-git config -f .gitmodules --remove-section submodule.${ROOT_DIRECTORY}
	-rm -rf .git/modules/${ROOT_DIRECTORY}
	rm ${MAKEFILE_DIRECTORY}${CMAKE_CLIENT_MAKEFILE}
	-rmdir ${MAKEFILE_DIRECTORY}
