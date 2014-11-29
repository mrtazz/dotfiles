"
" File: stencil.vim
" Author: Daniel Schauenberg <d@unwiredcouch.com>
" WebPage: https://github.com/mrtazz/vim-stencil
" License: MIT
" Version: 0.1.0
" Usage:
"   Stencil - Load one of the existing templates
"
"

if &cp || (exists('g:loaded_stencil_vim') && g:loaded_stencil_vim)
  finish
endif
let g:loaded_stencil_vim = 1

if !exists("g:StencilTemplatepath")
  let g:StencilTemplatepath = "~/.vim/templates/"
endif

"define the Stencil() command
command! -complete=customlist,AvailableTemplates -n=1
    \ Stencil :call LoadTemplate('<args>')

function! LoadTemplate(name)

    "read in the template
    execute 'read ' . g:StencilTemplatepath . a:name

    " replace occurrences of DATE with the actual date
    let thedate = strftime("%m\\/%d\\/%Y")
    silent exe "1,$g/%%DATE%%/s/%%DATE%%/" . thedate

    " replace occurrences of WEEKDAY with the current weekday
    let weekday = strftime("%A")
    silent exe "1,$g/%%WEEKDAY%%/s/%%WEEKDAY%%/" . weekday

    "if the cursor was previously on a blank line, delete it
    if getline(line(".")-1) =~ '^\s*$'
        exec line(".")-1 . 'd'
    endif
endfunction

function! AvailableTemplates(lead, cmdline, cursorpos)
    let templateDir = expand(g:StencilTemplatepath)
    let files = split(globpath(templateDir, a:lead . '*'), '\n')

    "chop off the templateDir from each file
    return map(files, 'strpart(v:val,strlen(templateDir))')
endfunction
