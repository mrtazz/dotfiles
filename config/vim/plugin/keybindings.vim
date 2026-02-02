map <leader>b :buffer

" replace ctrlp with FZF
nmap <C-P> :FZF<CR>
" rg search from vim with fzf preview
map <Leader>s :Rg<CR>
imap <c-x><c-f> <plug>(fzf-complete-path)


" nerdtree bindings
map <leader>t :NERDTreeToggle<CR>


" bookmarked command
command! ChangeDirectoryToCurrentFile :cd %:p:h

" let's see if we can work without arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>


