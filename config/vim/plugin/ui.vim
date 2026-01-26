" use solarized palette incase it's used
set background=light
let g:solarized_contrast="high"
let g:solarized_visibility="high"

"" GUI related things
" set guifont for the few times I use a GUI vim
set guifont=Bitstream\ Vera\ Sans\ Mono:h14
set guioptions+=k

" mouse options, only set when not in codespace
if empty($CODESPACES)
  set ttymouse=xterm2
  set mouse=a
endif

syntax on
colorscheme solarized


