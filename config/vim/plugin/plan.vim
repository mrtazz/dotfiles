""" vim-plan related settings
" set rg as grep program
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --sort=path

" vim-plan keybindings
map <leader>d :PlanDaily<CR>
map <leader>w :PlanWeekly<CR>
map <leader>pf :PlanFindTodos<CR>
map <leader>pn :PlanNote
map <leader>pd :PlanMarkDone<CR>
map <leader>pm :PlanMigrateToToday<CR>

" states for markdown checkboxes
let g:checkbox_states = [' ', 'x', '-', '>']

