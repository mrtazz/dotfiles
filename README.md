# dotfiles

## Overview

This is my collection of dotfiles. They are mostly used on macOS, FreeBSD, and
GitHub codespaces.

## Installation

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
