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

.PHONY: homebrew
ifeq ($(OS),Darwin)
homebrew: /usr/local/bin/brew
else ifeq ($(OS),Linux)
homebrew:	/home/linuxbrew/.linuxbrew/bin/brew
else
homebrew:
endif

# tasks
.PHONY : uninstall install

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -fs $< $@

${HOME}/.vimrc:
	ln -fs $(PWD)/vim/vimrc $@

${HOME}/.muttrc:
	ln -fs $(PWD)/mutt/muttrc $@

${HOME}/.zshrc:
	ln -fs $(PWD)/zsh/zshrc $@

${HOME}/.zlogin:
	ln -fs $(PWD)/zsh/zlogin $@

install: $(DOTFILES) $(NESTED_DOTFILES) brew-bundle

.PHONY: brew-bundle
brew-bundle: homebrew
	brew bundle install --no-lock --file "homebrew/Brewfile"

/usr/local/bin/brew:
/home/linuxbrew/.linuxbrew/bin/brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done
