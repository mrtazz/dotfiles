"============================================================================
"File:        checkstyle.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Dmitry Geurkov <d.geurkov at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" Tested with checkstyle 5.5
"============================================================================

if exists("g:loaded_syntastic_java_checkstyle_checker")
    finish
endif
let g:loaded_syntastic_java_checkstyle_checker = 1

if !exists("g:syntastic_java_checkstyle_classpath")
    let g:syntastic_java_checkstyle_classpath = 'checkstyle-5.5-all.jar'
endif

if !exists("g:syntastic_java_checkstyle_conf_file")
    let g:syntastic_java_checkstyle_conf_file = 'sun_checks.xml'
endif

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_java_checkstyle_Preprocess(errors)
    let out = []
    let fname = expand('%')
    for err in a:errors
        if match(err, '\m<error\>') > -1
            let line = str2nr(matchstr(err, '\m\<line="\zs\d\+\ze"'))
            if line == 0
                continue
            endif

            let col = str2nr(matchstr(err, '\m\<column="\zs\d\+\ze"'))

            let type = matchstr(err, '\m\<severity="\zs.\ze')
            if type !~? '^[EW]'
                let type = 'E'
            endif

            let message = syntastic#util#decodeXMLEntities(matchstr(err, '\m\<message="\zs[^"]\+\ze"'))

            call add(out, join([fname, type, line, col, message], ':'))
        elseif match(err, '\m<file name="') > -1
            let fname = syntastic#util#decodeXMLEntities(matchstr(err, '\v\<file name\="\zs[^"]+\ze"'))
        endif
    endfor
    return out
endfunction

function! SyntaxCheckers_java_checkstyle_GetLocList() dict

    let fname = syntastic#util#shescape( expand('%:p:h') . '/' . expand('%:t') )

    if has('win32unix')
        let fname = substitute(system('cygpath -m ' . fname), '\m\%x00', '', 'g')
    endif

    let makeprg = self.makeprgBuild({
        \ 'args': '-cp ' . g:syntastic_java_checkstyle_classpath .
        \         ' com.puppycrawl.tools.checkstyle.Main -c ' . g:syntastic_java_checkstyle_conf_file .
        \         ' -f xml',
        \ 'fname': fname })

    let errorformat = '%f:%t:%l:%c:%m'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'subtype': 'Style',
        \ 'preprocess': 'SyntaxCheckers_java_checkstyle_Preprocess' })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'java',
    \ 'name': 'checkstyle',
    \ 'exec': 'java'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
