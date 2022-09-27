#
# basic install script for dotfiles
#

GIT := $(shell which git)
# files you want to install
EXCLUDE := README.md Makefile vscode ssh install.sh homebrew bin spec
FILES := $(shell ls)
SOURCES := $(filter-out $(EXCLUDE),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))
NESTED_DOTFILES := ${HOME}/.vimrc ${HOME}/.muttrc ${HOME}/.zshrc ${HOME}/.zlogin ${HOME}/.tmux.conf
AUTHORIZED_KEYS := ${HOME}/.ssh/authorized_keys
BREWFILE := homebrew/Brewfile
BREW_OPTIONS := --no-lock
BIN := ${HOME}/bin

# bin/ is linked explicitly because we want it to not be ~/.bin
${HOME}/bin:
	ln -s ${PWD}/bin $@

# ssh needs special treatment because the folder can't be symlinked as the
# link always has the wrong permissions
${HOME}/.ssh:
	install -d -m 700 $@

SSH_FILES := $(patsubst %, ${HOME}/.ssh/%, $(shell ls ssh))
${HOME}/.ssh/%: ${PWD}/ssh/% | ${HOME}/.ssh
	ln -fs $< $@

DEFAULT_TARGETS := $(DOTFILES) $(NESTED_DOTFILES) $(SSH_FILES) $(AUTHORIZED_KEYS) $(BIN)

# allow hostname based brewfiles
HOSTNAME := $(shell hostname -s)
BREWFILE_LOCAL := homebrew/Brewfile.$(HOSTNAME)

OS   := $(shell uname -s)
ARCH := $(shell uname -m)
ifeq ($(OS),Darwin)
ifeq ($(ARCH), arm64)
HOMEBREW_LOCATION := /opt/homebrew/bin
else
HOMEBREW_LOCATION := /usr/local/bin
endif
else ifeq ($(OS),Linux)
HOMEBREW_LOCATION := /home/linuxbrew/.linuxbrew/bin
endif

.PHONY: homebrew
homebrew: $(HOMEBREW_LOCATION)/brew

$(AUTHORIZED_KEYS): ${HOME}/.ssh
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

${HOME}/.tmux.conf:
	ln -fs $(PWD)/tmux/tmux.conf $@

${HOME}/.config/Code/User/settings.json:
	install -d $(dir $@)
	ln -fs $(PWD)/vscode/settings.json $@

.PHONY: vscode
vscode: ${HOME}/.config/Code/User/settings.json

ifeq ($(CODESPACES), true)
# don't fully clone homebrew on codespaces
export HOMEBREW_INSTALL_FROM_API=true
install: $(DEFAULT_TARGETS) brew-bundle codespaces vscode
else ifeq ($(OS), FreeBSD)
install: $(DEFAULT_TARGETS)
else ifeq ($(CI), true)
install: $(DEFAULT_TARGETS) brew-bundle
else
install: $(DEFAULT_TARGETS) brew-bundle
endif

.PHONY: brew-bundle
brew-bundle: homebrew
	$(HOMEBREW_LOCATION)/brew bundle install $(BREW_OPTIONS) --file $(BREWFILE)
	if [ -f $(BREWFILE_LOCAL) ]; then $(HOMEBREW_LOCATION)/brew bundle install $(BREW_OPTIONS) --file $(BREWFILE_LOCAL); fi

$(HOMEBREW_LOCATION)/brew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o /tmp/install_homebrew.sh
	/bin/bash < /tmp/install_homebrew.sh

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done

.PHONY: codespaces
codespaces:
	./script/setup-codespaces

.PHONY: bundle-install
bundle-install:
	bundle install --gemfile=spec/Gemfile

.PHONY: spec
spec:
	bundle exec --gemfile=spec/Gemfile rspec --format=documentation spec/
