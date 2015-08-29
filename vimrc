set nocompatible
" if filetype is not on and then turned off, vim issues a bad exit status,
" which is a problem for git for example
filetype on
" this needs to be done to guarantee proper plugin loading
filetype off
" disable plugins
"let g:pathogen_disabled = ["syntastic"]
" load modules via pathogen
call pathogen#infect()
call pathogen#helptags()
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

" use solarized palette incase it's used
set background=light
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

syntax on
if has("gui_running")
    colorscheme solarized
    set go-=T
    set guifont=Monaco:h12
    set antialias
else
    "colorscheme molokai
    colorscheme solarized
endif

" some information in the statusline
set statusline=[%n]\ %t\ %y\ %{fugitive#statusline()}\ (%l,%c)\ %m\ %P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
set laststatus=2

" tab completion for file opening
set wildmode=longest,list,full
set wildmenu
set wildignorecase

function! Today()
  let today = strftime("%A %m\/%d\/%Y")
  exe "normal a". today
endfunction
command! Today :call Today()

" command shortcuts
let mapleader=","

map <leader>w <C-w>
map <leader>b :sb
map <leader>m :make<CR>
map <leader>p :CtrlP<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>t :VoomToggle markdown<CR>
map <leader>T :TagbarToggle<CR>
map <leader>M :set filetype=markdown<CR>
map <leader>d :Today<CR>
map <leader>g :Goyo<CR>

" open ctags definition in new tab
"map <C-\> :tab split<CR>:exec("tag \".expand("<cword>"))<CR>
" open ctags definition in horizontal split
map <C-\> :sp <CR>:exec("tag ".expand("<cword>"))<CR>
" open ctags in vertical split
map <leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" see if this makes me happy
imap jj <Esc>

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

" set backup and swap dir to specific folder to play nice with open files in
" dropbox
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

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

let g:StencilTemplatepath = $HOME . "/.vim/templates/"
