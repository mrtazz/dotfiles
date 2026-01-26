" some information in the statusline
set statusline=[%n]\ %t\ %y\ (%l,%c)\ %m\ %P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=\ %{ObsessionStatus()}
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
set laststatus=2

