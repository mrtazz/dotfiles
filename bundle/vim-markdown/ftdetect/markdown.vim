autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \   set ft=markdown |
      \ else |
      \   setf markdown |
      \   setlocal statusline=[%n]\ %t\ %y\ words:%{WordCount()}\ (%l,%c)\ %m\ %P |
      \ endif
