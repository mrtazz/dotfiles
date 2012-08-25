# dotfiles

## Overview
This is basically the collection of my dotfiles which are not already in a
subdirectory like my [vimfiles](https://github.com/mrtazz/vimfiles) and
[muttfiles](https://github.com/mrtazz/muttfiles).

## Setup
There is a makefile which sets up symlinks from the home directory. It prepends
a dot to all files. Use it by running:
``` shell
make install
```
There is also a command to uninstall the symlinks. Since this is potentially
hazardous, rm is invoked to prompt for each file entry and only works on
symlinks:
``` shell
make uninstall
```
