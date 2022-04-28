#
# some housekeeping tasks for my vim setup
#
FILES := vimrc
SOURCES := $(filter-out $(METAS),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))

PLUGINSDIR := pack/plugins/start

# general plugins
plugin_vim-fugitive         := https://github.com/tpope/vim-fugitive/tarball/master
plugin_supertab             := https://github.com/ervandew/supertab/tarball/master
plugin_syntastic            := https://github.com/scrooloose/syntastic/tarball/master
plugin_vim-colors-solarized := https://github.com/altercation/vim-colors-solarized/tarball/master
plugin_fzf                  := https://github.com/junegunn/fzf/tarball/master
plugin_fzf.vim              := https://github.com/junegunn/fzf.vim/tarball/master
plugin_vim-tla              := https://github.com/florentc/vim-tla/tarball/master
plugin_vim-lsp              := https://github.com/prabirshrestha/vim-lsp/tarball/master
plugin_vim-lsp-settings     := https://github.com/mattn/vim-lsp-settings/tarball/master
plugin_vim-marked           := https://github.com/itspriddle/vim-marked/tarball/master
plugin_vim-checkbox         := https://github.com/jkramer/vim-checkbox/tarball/master
plugin_vim-plan             := https://github.com/mrtazz/vim-plan/tarball/v2
plugin_vim-nerdtree         := https://github.com/preservim/nerdtree/tarball/master

# my plugins
plugin_vim-tinygo           := https://github.com/mrtazz/vim-tinygo/tarball/master

# GitHub related plugins
plugin_vim-coffee-script    := https://github.com/kchmck/vim-coffee-script/tarball/master

# this filters out all variables with a plugin_ prefix and regards them as
# plugin definitions
ALL_DEFINED_PLUGINS := $(filter plugin_%, $(.VARIABLES))
# from the defined variables list we only extract the name
ALL_PLUGINS := $(subst plugin_,,$(ALL_DEFINED_PLUGINS))

# this will install all plugins via the wildcard matching target below
.PHONY: install-plugins
install-plugins: $(patsubst %, $(PLUGINSDIR)/%, $(ALL_PLUGINS))

.PHONY: clean-plugins
clean-plugins:
	rm -rf ./pack/plugins/start/*

.PHONY: update-plugins
update-plugins: clean-plugins install-plugins

$(PLUGINSDIR):
	install -d $@

$(PLUGINSDIR)/%: $(PLUGINSDIR)
	@echo "Installing $@ from $(plugin_$*)"
	@install -d $@
	@curl -Lfs $(plugin_$*) | tar xz -C $@ --strip-components=1

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -s $< $@

.PHONY: install
install: $(DOTFILES)

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done
