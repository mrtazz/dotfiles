" get basedir and strip trailing slashes to not clash with completion
" and path construction
let g:SnippleBaseDir = substitute(get(g:, 'SnippleBaseDir', $HOME . '/.snippets/'), "/$", "", "")

" command definitions
command! -nargs=1 -complete=customlist,snipple#AvailableSnippets SnippleLoad :call snipple#LoadSnippet(<q-args>)
