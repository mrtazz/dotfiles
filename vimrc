set nocompatible
" this needs to be done to guarantee proper plugin loading
filetype off
" load modules via pathogen
call pathogen#runtime_append_all_bundles()
" enable after plugins are loaded
filetype plugin indent on

" general settings
set ruler
set number
set textwidth=79
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

syntax on
if has("gui_running")
    colorscheme default
    set go-=T
else
    colorscheme railscasts
endif
" some information in the statusline
set statusline=%t\ %y\ %{fugitive#statusline()}\ (%l,%c)\ %m
set laststatus=2

" command shortcuts
let mapleader=","

map <leader>t :FuzzyFinderTextMate<CR>
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>l :TlistToggle<CR>

" remove unneeded spaces for a good whitespace carbon footprint
autocmd BufWritePre * :%s/\s\+$//e


" Supertab settings
let g:SuperTabDefaultCompletionTypeDiscovery = [
\ "&completefunc:<c-x><c-u>",
\ "&omnifunc:<c-x><c-o>",
\ ]
let g:SuperTabLongestHighlight = 1

" tag list on the right side of the vim window
let Tlist_Use_Right_Window = 1
