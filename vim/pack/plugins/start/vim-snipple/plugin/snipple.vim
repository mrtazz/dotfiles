" get basedir and strip trailing slashes to not clash with completion
" and path construction
let g:SnippleBaseDir = get(g:, 'SnippleBaseDir', $HOME . '/.snippets/')->trim("/", 2)

" command definitions
command! -nargs=1 -complete=customlist,snipple#AvailableSnippets SnippleLoad :call snipple#LoadSnippet(<q-args>)
