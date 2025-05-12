#
# some housekeeping tasks for my vim setup
#
FILES := vimrc
SOURCES := $(filter-out $(METAS),$(FILES))
DOTFILES := $(patsubst %, ${HOME}/.%, $(SOURCES))

PLUGINS_BASE_DIR := pack/plugins

# general plugins
plugin_vim-fugitive         := https://github.com/tpope/vim-fugitive/tarball/master
plugin_supertab             := https://github.com/ervandew/supertab/tarball/master
plugin_syntastic            := https://github.com/scrooloose/syntastic/tarball/master
plugin_vim-colors-solarized := https://github.com/altercation/vim-colors-solarized/tarball/master
plugin_fzf                  := https://github.com/junegunn/fzf/tarball/master
plugin_fzf.vim              := https://github.com/junegunn/fzf.vim/tarball/master
plugin_rust.vim             := https://github.com/rust-lang/rust.vim/tarball/master
plugin_vim-tla              := https://github.com/florentc/vim-tla/tarball/master

# these are all for note taking (mostly on macOS)
plugin_vim-marked           := https://github.com/itspriddle/vim-marked/tarball/master
plugin_vim-checkbox         := https://github.com/jkramer/vim-checkbox/tarball/master
plugin_vim-plan             := https://github.com/mrtazz/vim-plan/tarball/main
plugin_vim-nerdtree         := https://github.com/preservim/nerdtree/tarball/master
plugin_vim-goyo         		:= https://github.com/junegunn/goyo.vim/tarball/master

# my plugins
plugin_vim-tinygo           := https://github.com/mrtazz/vim-tinygo/tarball/master
plugin_vim-snipple          := https://github.com/mrtazz/vim-snipple/tarball/main

# optional plugins, these are too noisy to always keep enabled
plugin-opt_vim-lsp          := https://github.com/prabirshrestha/vim-lsp/tarball/master
plugin-opt_copilot.vim      := https://github.com/github/copilot.vim/tarball/release

# this filters out all variables with a plugin_ prefix and regards them as
# plugin definitions
ALL_DEFINED_PLUGINS := $(filter plugin_%, $(.VARIABLES))
ALL_DEFINED_OPT_PLUGINS := $(filter plugin-opt_%, $(.VARIABLES))
# from the defined variables list we only extract the name
ALL_PLUGINS := $(subst plugin_,,$(ALL_DEFINED_PLUGINS))
ALL_OPT_PLUGINS := $(subst plugin-opt_,,$(ALL_DEFINED_OPT_PLUGINS))

# generate all plugin paths
ALL_PLUGIN_PATHS     := $(patsubst %, $(PLUGINS_BASE_DIR)/start/%, $(ALL_PLUGINS))
ALL_PLUGIN_OPT_PATHS := $(patsubst %, $(PLUGINS_BASE_DIR)/opt/%, $(ALL_OPT_PLUGINS))

# this will install all plugins via the wildcard matching target below
.PHONY: install-plugins
install-plugins: $(ALL_PLUGIN_PATHS) $(ALL_PLUGIN_OPT_PATHS)

.PHONY: clean-plugins
clean-plugins:
	rm -rf ./$(PLUGINS_BASE_DIR)/*

.PHONY: update-plugins
update-plugins: clean-plugins install-plugins

$(PLUGINS_BASE_DIR):
	install -d $@

# I don't super like the repetitive rules here but there isn't really a good
# way to move up the wildcard to include start/opt and still easily choose the
# right variable that contains the plugin URL
$(PLUGINS_BASE_DIR)/start/%: $(PLUGINS_BASE_DIR)
	@echo "Installing $@ from $(plugin_$*)"
	@install -d $@
	@curl -Lfs $(plugin_$*) | tar xz -C $@ --strip-components=1

$(PLUGINS_BASE_DIR)/opt/%: $(PLUGINS_BASE_DIR)
	@echo "Installing $@ from $(plugin-opt_$*)"
	@install -d $@
	@curl -Lfs $(plugin-opt_$*) | tar xz -C $@ --strip-components=1

$(DOTFILES): $(addprefix ${HOME}/., %) : ${PWD}/%
	ln -s $< $@

.PHONY: install
install: $(DOTFILES)

uninstall:
	@echo "Cleaning up dotfiles"
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi ; done
