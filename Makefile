#
# basic install script for dotfiles
#

GIT := $(shell which git)
# files you want to install
EXCLUDE := README.md Makefile ackrc vscode
FILES := $(shell ls)
SOURCES := $(filter-out $(EXCLUDE),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))
NESTED_DOTFILES := ${HOME}/.vimrc ${HOME}/.muttrc ${HOME}/.zshrc ${HOME}/.zlogin

AUTHORIZED_KEYS := ${HOME}/.ssh/authorized_keys

OS := $(shell uname -s)

ifeq ($(OS),Darwin)
HOMEBREW_LOCATION := /usr/local/bin/
else ifeq ($(OS),Linux)
HOMEBREW_LOCATION := /home/linuxbrew/.linuxbrew/bin/
endif

.PHONY: homebrew
homebrew: $(HOMEBREW_LOCATION)/brew

$(AUTHORIZED_KEYS): $(DOTFILES)
	curl -Ls https://github.com/mrtazz.keys > $@

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

${HOME}/.config/Code/User/settings.json:
	install -d $(dir $@)
	ln -fs $(PWD)/vscode/settings.json $@

.PHONY: vscode
vscode: ${HOME}/.config/Code/User/settings.json

ifeq ($(CODESPACES),true)
install: $(DOTFILES) $(NESTED_DOTFILES) $(AUTHORIZED_KEYS) brew-bundle codespaces vscode
else ifeq ($(OS), FreeBSD)
install: $(DOTFILES) $(NESTED_DOTFILES) $(AUTHORIZED_KEYS)
else
install: $(DOTFILES) $(NESTED_DOTFILES) $(AUTHORIZED_KEYS) brew-bundle
endif

.PHONY: brew-bundle
brew-bundle: homebrew
	$(HOMEBREW_LOCATION)/brew bundle install --no-lock --file "homebrew/Brewfile"

$(HOMEBREW_LOCATION)/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/install_homebrew.sh
	/bin/bash < /tmp/install_homebrew.sh

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done

.PHONY: codespaces
codespaces:
	./script/setup-codespaces
