#
# basic install script for dotfiles
#

# files you want to install
METAS := README.md Makefile
FILES := zshrc
SOURCES := $(filter-out $(METAS),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))

# tasks
.PHONY : uninstall

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -s $< $@

install: $(DOTFILES)

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done

