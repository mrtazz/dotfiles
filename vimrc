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
set number
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

" quick function to count the number of words in the buffer
if !exists("*WordCount")
function WordCount()
  let s:old_status = v:statusmsg
  exe "silent normal g\<c-g>"
  let s:word_count = str2nr(split(v:statusmsg)[11])
  let v:statusmsg = s:old_status
  return s:word_count
endfunction
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

" command shortcuts
let mapleader=","

map <leader>w <C-w>
map <leader>b :sb
map <leader>m :make<CR>
map <leader>p :CtrlP<CR>
map <leader>i :Simplenote -o agtzaW1wbGUtbm90ZXINCxIETm90ZRjVvJMNDA<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>t :VoomToggle markdown<CR>
map <leader>M :set filetype=markdown<CR>

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

" set backup and swap dir to specific folder to play nice with open files in
" dropbox
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" activate spell checker in insert mode
autocmd InsertEnter *.tex setlocal spell
autocmd InsertLeave *.tex setlocal nospell

if filereadable($HOME."/.simplenoterc")
  exec ":source ". $HOME . "/.simplenoterc"
endif

" let's see if we can work without arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

let g:SimplenoteListHeight=30
let g:SimplenoteFiletype="markdown"
let g:SimplenoteSortOrder="pinned,modifydate"

" source overrides configs
if filereadable($HOME."/.dotoverrides/vimrc")
  exec ":source ". $HOME . "/.dotoverrides/vimrc"
endif

let g:markdown_fold_style = 'nested'
set foldlevel=2
set foldminlines=10
set foldnestmax=2
