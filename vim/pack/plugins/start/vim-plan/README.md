# vim-plan

VIM plugin that supports my planning and note taking workflow.

## Overview

## Usage

This plugin provides a handful of helper functions to organize a directory of
notes. The general setup is that there are at least 2 different directories.
One for generic notes (by default `notes/`) and one for daily notes (by
default `dailies/`). This workflow is heavily inspired by tools like
[Obsidian][obsidian] and [NotePlan][noteplan] and should be in large parts
compatible.

Helper functions are by default mapped to commands but not mapped to any
keybindings to not clash with any existing mappings:

```
command! PlanDaily :call plan#OpenDailyNote()
command! PlanNote :call plan#OpenNote()
command! PlanMarkDone :call plan#MarkDone()
command! PlanMarkCanceled :call plan#MarkCanceled()
command! PlanMigrateToToday :call plan#MigrateToToday()
```

### Syntax
vim-plan uses the `conceal` feature to show todos in a visually different way
to make it easier to quickly scan notes for todos. It suppports 4 different
states of todos:

```
- [ ] an open task
- [x] a completed task
- [-] a cancelled task
- [>] a moved task
```

which will look like this as long as the cursor isn't on the line:

```
⭕️ an open task
✅ a completed task
❎ a cancelled task
🔜 a moved task
```

This only works if vim is compiled with `conceal` support and utf-8 encoding.
This is how it looks like in MacVim:

![screen recording of conceal feature](https://github.com/mrtazz/vim-plan/assets/68183/5062d1c3-f487-4de4-86f2-e83b9ec11030)


### TODOs in location window
The plugin provides a command `:PlanFindTodos` that uses `:lgrep` to find the
pattern `- [ ] ` in the dailies and notes directories and shows the results in
a location window for the buffer to select and jump to. I'm using it with
[rg](https://github.com/BurntSushi/ripgrep) via the following `.vimrc`
setting, to show me the newest daily notes first:

```
" set rg as grep program
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --sortr=path
```

### Autosaving of notes
Notes are saved periodically when the cursor is idle (in both normal and
insert mode) and also on leaving a buffer.


### Templating
When opening a file that doesn't exist yet, vim-plan reads a template folder
to figure out if there is a template set for the file type. This is very
similar to how [vim-stencil][vim_stencil] works. Valid template files are
`daily` or `note`.

When reading those templates in vim-plan will replace the following template
variables inline:

- `%%DATE%%` with the current date of the format mm/dd/yyyy
- `%%DATE_8601%%` with the current date of the format yyyy/mm/dd
- `%%WEEKDAY%%` with the name of weekday
- `%%WEEKNUMBER%%` with the number of the week
- `%%YEAR%%` with the current year yyyy
- `%%MONTH%%` with the name of the current month

### Useful shell commands

I complement this workflow with a couple of shell commands I run from a
Makefile in my notes repository:

```make

TODAY := $(shell date "+%Y%m%d")
TODAY_ATTACHMENTS := ./dailies/$(TODAY)_attachments

$(TODAY_ATTACHMENTS):
	install -d $@

# this is run from Hazel on macos to sync screenshots to a daily attachments
# folder for my daily note
.PHONY: sync-screenshots-to-today
sync-screenshots-to-today: $(TODAY_ATTACHMENTS)
	mv ~/Desktop/Screenshot*.png $<

# this is useful to find images I imported but never linked in any notes
.PHONY: find-unlinked-images
find-unlinked-images:
	@find dailies -type f -name "*.png" | sort | while read img ; do grep -q "$$(basename "$$img")" -R dailies notes || echo "Image: $$img not linked in any notes" ; done

# get a list of all open todos
.PHONY: find-todos
find-todos:
	@rg --sort path '\- \[ \]' dailies notes

# get a list of notes tagged with something (#fr in this case)
.PHONY: recent-fr-tasks
recent-fr-tasks:
	@rg --sort path '#fr' dailies notes

# generate tags, see below for ctag definitions I use
.PHONY: tags
tags:
	ctags -R .

```

### Tags
I use a small addition to the normal ctags definitions mostly to be able to
tab complete @usernames in vim:

```
% cat .ctags.d/md.ctags
--langdef=markdowntags
--languages=markdowntags
--langmap=markdowntags:.md
--kinddef-markdowntags=t,tag,tags
--mline-regex-markdowntags=/(^|[[:space:]])@(\w\S*)/\2/t/{mgroup=1}
```

In my notes repo I have a nightly action that updates tags which makes it really easy
to have completion of notes with about a day or so delay:

```
name: update-tags

on:
  workflow_dispatch:
  schedule:
    # run every weekday morning
    - cron: '30 3 * * 1-5'

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: dependencies
        run:  sudo apt-get install universal-ctags

      - name: generate tags
        run: make tags

      - name: commit and push changes
        run: |
          git config user.name Github Actions
          git config user.email actions@noreply.github.com
          git add tags
          git commit --allow-empty -m "update tags"
          git push
```

### Additional tooling
There is a commandline tool [`plan`](https://github.com/mrtazz/plan) which provides some additional
support tooling mostly around automation. For example I run this Action every weekday morning to 
prep my daily note with some information:

```
name: daily-prep

on:
  workflow_dispatch:
  schedule:
    # run every weekday morning
    - cron: '30 5 * * 1-5'

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: populate daily note
        run:  make prepare-the-day
        env:
          ISSUES_TOKEN_GITHUB: ${{ secrets.ISSUES_TOKEN_GITHUB }}

      - name: commit and push changes
        run: |
          git config user.name Github Actions
          git config user.email actions@noreply.github.com
          git add dailies
          git commit -m "create daily note"
          git push
```

## Configuration
There are a couple of variables that can be set to customize mostly file
locations:

```vimscript
" base dor for all notes
let g:PlanBaseDir = get(g:, 'PlanBaseDir', $HOME . "/.plan")
" template dir relative to base dir
let g:PlanTemplateDir = get(g:, 'PlanTemplatePath', "templates")
" daily notes dir relative to base dir
let g:PlanDailiesDir = get(g:, 'PlanTemplatePath', "dailies")
" generic notes dir relative to base dir
let g:PlanNotesDir = get(g:, 'PlanTemplatePath', "notes")
```

## See also
- [vim-stencil][vim_stencil]

[vim_stencil]: https://github.com/mrtazz/vim-stencil
[obsidian]: https://obsidian.md/
[noteplan]: https://noteplan.co/
