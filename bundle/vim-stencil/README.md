# vim-stencil

## Overview
VIM plugin to load templates from a directory and do basic variable substitution.

## Installation
If you don't have a preferred installation method, I recommend installing
[pathogen.vim][pathogen], and then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/mrtazz/vim-stencil.git

## Usage
Set the path where to find the templates like this:
`let g:StencilTemplatepath = "~/.vim/templates/"`

Then you can load templates with the `:Stencil` command. It supports tab
completion for choosing the template. The template loader will always load the
template after the first line of the file.

## Variable expansion
Stencil supports expansion of some simple variables. Those are:

- %%DATE%% will be replaced by the current date in the format mm/dd/yyyy
- %%WEEKDAY%% will be replaced by the full name of the weekday (e.g. Friday)


[pathogen]: https://github.com/tpope/vim-pathogen
