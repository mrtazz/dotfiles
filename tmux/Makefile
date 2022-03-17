# some tmux plugin management tasks

PLUGINSDIR := plugins

# general plugins
plugin_tmux-resurrect := https://github.com/tmux-plugins/tmux-resurrect/tarball/master
plugin_tmux-continuum := https://github.com/tmux-plugins/tmux-continuum/tarball/master

# this filters out all variables with a plugin_ prefix and regards them as
# plugin definitions
ALL_DEFINED_PLUGINS := $(filter plugin_%, $(.VARIABLES))
# from the defined variables list we only extract the name
ALL_PLUGINS := $(subst plugin_,,$(ALL_DEFINED_PLUGINS))

# this will install all plugins via the wildcard matching target below
.PHONY: install-plugins
install-plugins: $(PLUGINSDIR) $(patsubst %, $(PLUGINSDIR)/%, $(ALL_PLUGINS))

.PHONY: clean-plugins
clean-plugins:
	rm -rf ./$(PLUGINSDIR)/*

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
