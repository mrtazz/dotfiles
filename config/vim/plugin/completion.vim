" tab completion for file opening
set wildmode=longest,list,full
set wildmenu
set wildignorecase
"
" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Supertab settings
let g:SuperTabDefaultCompletionTypeDiscovery = [
\ "&completefunc:<c-x><c-u>",
\ "&omnifunc:<c-x><c-o>",
\ ]
let g:SuperTabLongestHighlight = 1

