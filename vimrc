set nocompatible
" if filetype is not on and then turned off, vim issues a bad exit status,
" which is a problem for git for example
filetype on
" this needs to be done to guarantee proper plugin loading
filetype off
" enable after plugins are loaded
filetype plugin indent on

" general settings
set ruler
set nonumber
set textwidth=78
set copyindent
set shiftwidth=2           " tab indention
set tabstop=2              " how big is ur tab
set expandtab              " tabs are evil if not spaces
set softtabstop=2          " softtabs are 4 spaces wide
set shiftround
set bs=2                   " backspacing over everything
set incsearch
set ignorecase
set encoding=utf-8
set cursorline

" set colors
set t_Co=256

" use open buffers
set switchbuf=useopen
" allow buffers to be hidden
set hidden

" use solarized palette incase it's used
set background=light
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

syntax on
colorscheme solarized

" some information in the statusline
set statusline=[%n]\ %t\ %y\ (%l,%c)\ %m\ %P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
set laststatus=2

" cpplint for syntastic
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_cpp_cpplint_args = '--filter=-legal/copyright'

" C++11 for syntastic
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
" add vendorized gtest and json.h  to include path
let syntastic_cpp_include_dirs = ['vendor/gtest-1.7.0/include', 'vendor/jsoncpp-0.10.5/dist']

" tab completion for file opening
set wildmode=longest,list,full
set wildmenu
set wildignorecase

" command shortcuts
let mapleader=","

map <leader>w <C-w>
map <leader>b :buffer
map <leader>m :make<CR>
map <leader>M :set filetype=markdown<CR>

" rspec setup
let g:rspec_command = "!./bin/rspec {spec}"
map <Leader>r :call RunNearestSpec()<CR>
map <Leader>f :call RunCurrentSpecFile()<CR>

" ctrlp ignore vendor directories
let g:ctrlp_custom_ignore = 'vendor'

" open ctags definition in new tab
"map <C-\> :tab split<CR>:exec("tag \".expand("<cword>"))<CR>
" open ctags definition in horizontal split
map <C-\> :sp <CR>:exec("tag ".expand("<cword>"))<CR>
" open ctags in vertical split
map <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" remove unneeded spaces for a good whitespace carbon footprint
autocmd BufWritePre * :%s/\s\+$//e

" Supertab settings
let g:SuperTabDefaultCompletionTypeDiscovery = [
\ "&completefunc:<c-x><c-u>",
\ "&omnifunc:<c-x><c-o>",
\ ]
let g:SuperTabLongestHighlight = 1

" set indents for python files
au FileType python setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
" set indents for php files
au FileType php setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
" handle .json files as javascript
autocmd BufNewFile,BufRead *.json set filetype=javascript
" make .md files markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" spell checking settings
" set the spellfile for added words if it exists
if filereadable($HOME."/.vim/vim-spell.add")
  set spellfile=$HOME/.vim/vim-spell.add
endif

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" activate spell checker in insert mode
autocmd InsertEnter *.tex setlocal spell
autocmd InsertLeave *.tex setlocal nospell
autocmd FileType markdown setlocal spell
autocmd FileType mail setlocal spell

" let's see if we can work without arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" source overrides configs
if filereadable($HOME."/.dotoverrides/vimrc")
  exec ":source ". $HOME . "/.dotoverrides/vimrc"
endif
