.PHONY: cmake-retemplate cmake-refresh

SERVER_MAKEFILE_DIRECTORY=external/dotfiles/CPP/

cmake-retemplate:
	cd ${SERVER_MAKEFILE_DIRECTORY} && make cmake-retemplate

cmake-refresh:
	cd ${SERVER_MAKEFILE_DIRECTORY} && make cmake-refresh
