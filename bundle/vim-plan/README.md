# vim-plan

VIM plugin that supports my planning workflow.

## Overview
I use a planning process that is heavily inspired by the [Ink & Volt
planner][ink_volt] but is implemented with a bunch of markdown files in a git
repo. This plugin codifies easy access to often used files and the templating
involved when opening them for the first time.

My files are stored in a path that is also configured as a [vimwiki][vimwiki]
and this plugin makes my planning process integrate nicely with vimwiki.

## Usage

Default mappings
```
map <leader>pw :OpenWeekPlan<CR>
map <leader>pm :OpenMonthPlan<CR>
map <leader>py :OpenYearPlan<CR>
map <leader>pd :Today<CR>
```

Plan folder layout:

```
Plan
├── 2018
│   ├── 01-January.md
│   ├── 02-February.md
│   ├── weeks
│   │   ├── 01.md
│   │   ├── 02.md
│   │   ├── 03.md
│   │   ├── 04.md
│   │   ├── 05.md
│   │   └── 06.md
│   └── year.md
```

### Templating
When opening a file that doesn't exist yet, vim-plan reads a template folder
to figure out if there is a template set for the file type. This is very
similar to how [vim-stencil][vim_stencil] works. Valid template files are
`week`, `month`, or `year`.

When reading those templates in vim-plan will replace the following template
variables inline:

- `%%DATE%%` with the current date of the format mm/dd/yyyy
- `%%WEEKDAY%%` with the name of weekday
- `%%WEEKNUMBER%%` with the number of the week
- `%%YEAR%%` with the current year yyyy
- `%%MONTH%%` with the name of the current month

## Configuration
- `g:PlanPath` configures location of the plan files (default: `~/.plan/`)
- `g:PlanTemplatePath` configures location of plan templates (default: `~/.plan/templates/`

## See also
- [vimwiki][vimwiki]
- [vim-stencil][vim_stencil]
- [Ink & Volt][ink_volt]

[vimwiki]: https://github.com/vimwiki/vimwiki
[vim_stencil]: https://github.com/mrtazz/vim-stencil
[ink_volt]: https://inkandvolt.com/
