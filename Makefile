#
# some housekeeping tasks for my vim setup
#
UPDATECMD = vim-bundle update
PLUGINS  = "kien/ctrlp.vim"
PLUGINS += "tpope/vim-fugitive"
PLUGINS += "tpope/vim-markdown"
PLUGINS += "ervandew/supertab"
PLUGINS += "scrooloose/syntastic"
PLUGINS += "mrtazz/molokai.vim"
PLUGINS += "juvenn/mustache.vim"
PLUGINS += "mrtazz/simplenote.vim"
PLUGINS += "tpope/vim-commentary"

# targets

update-plugins:
	@$(foreach dir,$(PLUGINS),${UPDATECMD} $(dir);)
