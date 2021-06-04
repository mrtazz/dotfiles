#
# basic install script for dotfiles
#

GIT := $(shell which git)
# files you want to install
METAS := README.md Makefile ackrc
FILES := $(shell ls)
SOURCES := $(filter-out $(METAS),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))
NESTED_DOTFILES := ${HOME}/.vimrc ${HOME}/.muttrc ${HOME}/.zshrc ${HOME}/.zlogin

OS := $(shell uname -s)

ifeq ($(OS),Darwin)
HOMEBREW_LOCATION := /usr/local/bin/
else ifeq ($(OS),Linux)
HOMEBREW_LOCATION := /home/linuxbrew/.linuxbrew/bin/
endif

.PHONY: homebrew
homebrew: $(HOMEBREW_LOCATION)/brew

# tasks
.PHONY : uninstall install

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -fs $< $@

${HOME}/.vimrc:
	ln -fs $(PWD)/vim/vimrc $@

${HOME}/.muttrc:
	ln -fs $(PWD)/mutt/muttrc $@

${HOME}/.zshrc: $(PWD)/zsh/zshrc
	ln -fs $(PWD)/zsh/zshrc $@

${HOME}/.zlogin:
	ln -fs $(PWD)/zsh/zlogin $@

install: $(DOTFILES) $(NESTED_DOTFILES) brew-bundle

.PHONY: brew-bundle
brew-bundle: homebrew
	$(HOMEBREW_LOCATION)/brew bundle install --no-lock --file "homebrew/Brewfile"

$(HOMEBREW_LOCATION)/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/install_homebrew.sh
	/bin/bash < /tmp/install_homebrew.sh

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done
