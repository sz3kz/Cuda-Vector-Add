.PHONY: dotfiles-activate dotfiles-update dotfiles-deinit dotfiles-refresh

REPOSITORY_ROOT_DIRECTORY=external/dotfiles/
LANGUAGE_DIRECTORY=CPP/

dotfiles-activate:
	git submodule update --init
	cd ${REPOSITORY_ROOT_DIRECTORY} && git sparse-checkout init --cone
	cd ${REPOSITORY_ROOT_DIRECTORY} && git sparse-checkout set ${LANGUAGE_DIRECTORY}

dotfiles-update:
	cd ${REPOSITORY_ROOT_DIRECTORY}${LANGUAGE_DIRECTORY} && make dotfiles-update

dotfiles-deinit:
	cd ${REPOSITORY_ROOT_DIRECTORY}${LANGUAGE_DIRECTORY} && make dotfiles-deinit

dotfiles-refresh:
	cd ${REPOSITORY_ROOT_DIRECTORY}${LANGUAGE_DIRECTORY} && make dotfiles-refresh
