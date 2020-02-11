#
# some housekeeping tasks for my vim setup
#
FILES := vimrc
SOURCES := $(filter-out $(METAS),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))

UPDATECMD = ./vim-bundle update

PLUGINS += "tpope/vim-pathogen"
PLUGINS += "tpope/vim-fugitive"
PLUGINS += "ervandew/supertab"
PLUGINS += "scrooloose/syntastic"
PLUGINS += "tpope/vim-commentary"
PLUGINS += "altercation/vim-colors-solarized"
PLUGINS += "tpope/vim-rhubarb"
PLUGINS += "ledger/vim-ledger"
PLUGINS += "ctrlpvim/ctrlp.vim"
PLUGINS += "thoughtbot/vim-rspec"

# my plugins
PLUGINS += "mrtazz/vim-tinygo"

# targets
.PHONY : uninstall

update-plugins:
	@$(foreach dir,$(PLUGINS),${UPDATECMD} $(dir);)

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -s $< $@

install: $(DOTFILES)

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done
