"
" File: ham.vim
"
" When you need to go HAM
"
if &cp || (exists('g:loaded_ham_vim') && g:loaded_ham_vim)
  finish
endif
let g:loaded_ham_vim = 1

function! ham#Ham()
  setlocal statusline+=\ HAM
  echo "HARD AS A MOTHERFUCKER"
endfunction

command! HAM :call ham#Ham()

