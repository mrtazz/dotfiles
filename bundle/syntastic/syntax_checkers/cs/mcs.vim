"============================================================================
"File:        cs.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Daniel Walker <dwalker@fifo99.com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

function! SyntaxCheckers_cs_mcs_IsAvailable()
    return executable('mcs')
endfunction

function! SyntaxCheckers_cs_mcs_GetLocList()
    let makeprg = syntastic#makeprg#build({
                \ 'exe': 'mcs',
                \ 'args': '--parse' })
    let errorformat = '%f(%l\,%c): %trror %m'
    return SyntasticMake({ 'makeprg': makeprg,
                         \ 'errorformat': errorformat,
                         \ 'defaults': {'bufnr': bufnr("")} })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'cs',
    \ 'name': 'mcs'})
