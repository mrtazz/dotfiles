#
# some housekeeping tasks for my vim setup
#
FILES := vimrc
SOURCES := $(filter-out $(METAS),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))

UPDATECMD = ./vim-bundle update

PLUGINS += "tpope/vim-fugitive"
PLUGINS += "ervandew/supertab"
PLUGINS += "scrooloose/syntastic"
PLUGINS += "altercation/vim-colors-solarized"
PLUGINS += "tpope/vim-rhubarb"
PLUGINS += "ctrlpvim/ctrlp.vim"

# my plugins
PLUGINS += "mrtazz/vim-tinygo"

# targets
.PHONY : uninstall

.PHONY: clean-plugins
clean-plugins:
	rm -rf ./pack/plugins/start/*

update-plugins: clean-plugins
	@$(foreach dir,$(PLUGINS),${UPDATECMD} $(dir);)

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -s $< $@

install: $(DOTFILES)

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done
