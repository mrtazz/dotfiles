#
# basic install script for dotfiles
#

GIT := $(shell which git)
# files you want to install
METAS := README.md Makefile ackrc
FILES := $(shell ls)
SOURCES := $(filter-out $(METAS),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))
NESTED_DOTFILES := ${HOME}/.vimrc ${HOME}/.muttrc ${HOME}/.zshrc

# tasks
.PHONY : uninstall update

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -s $< $@

${HOME}/.vimrc:
	ln -s $(PWD)/vim/vimrc $@

${HOME}/.muttrc:
	ln -s $(PWD)/mutt/muttrc $@

${HOME}/.zshrc:
	ln -s $(PWD)/zsh/zshrc $@

install: $(DOTFILES) $(NESTED_DOTFILES)

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done

update:
	$(GIT) pull && $(GIT) submodule update

