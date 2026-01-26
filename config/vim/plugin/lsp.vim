" some LSP settings
map <leader>pi :LspPeekImplementation<CR>
map <leader>pd :LspPeekDefinition<CR>
map <leader>pt :LspPeekTypeDefinition<CR>
" Splits horizontally and opens a window to the above.
map <C-\> :leftabove LspDefinition<CR>
" Splits vertically and opens a window to the right.
map <leader>] :rightbelow vertical LspDefinition<CR>
" show diagnostics in status line for line under cursor
let g:lsp_diagnostics_echo_cursor = 1
" don't add virtual text into the file for diagnostics
let g:lsp_diagnostics_virtual_text_enabled = 0

