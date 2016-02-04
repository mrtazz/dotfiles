" =============================================================================
" File:          ftdetect/tjp.vim
" Description:   TaskJuggler file detection
" Author:        Jim Kalafut <github.com/kalafut>
" Credits:       Contents derived from the TaskJuggler distribution
" =============================================================================

augroup filetypedetect
au BufNewFile,BufRead *.tjp,*.tji     setf tjp
augroup END
