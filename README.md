# my vimfiles
Fresh setup with submodules and tim pope's pathogen

## Plugin management
I manage my plugins with [vim-bundle](https://github.com/benmills/vim-bundle)
instead of submodules. The repository includes a Makefile which includes a task
to update all plugins with
```
make update-plugins
```

## Dependencies
- vim compiled with `+python` for simplenote plugin
