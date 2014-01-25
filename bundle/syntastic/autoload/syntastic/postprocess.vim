if exists("g:loaded_syntastic_postprocess_autoload")
    finish
endif
let g:loaded_syntastic_postprocess_autoload = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:compareErrorItems(a, b)
    if a:a['bufnr'] != a:b['bufnr']
        " group by files
        return a:a['bufnr'] - a:b['bufnr']
    elseif a:a['lnum'] != a:b['lnum']
        return a:a['lnum'] - a:b['lnum']
    elseif a:a['type'] !=? a:b['type']
        " errors take precedence over warnings
        return a:a['type'] ==? 'e' ? -1 : 1
    else
        return get(a:a, 'col') - get(a:b, 'col')
    endif
endfunction

" natural sort
function! syntastic#postprocess#sort(errors)
    return sort(copy(a:errors), 's:compareErrorItems')
endfunction

" merge consecutive blanks
function! syntastic#postprocess#compressWhitespace(errors)
    for e in a:errors
        let e['text'] = substitute(e['text'], "\001", '', 'g')
        let e['text'] = substitute(e['text'], '\n', ' ', 'g')
        let e['text'] = substitute(e['text'], '\m\s\{2,}', ' ', 'g')
    endfor

    return a:errors
endfunction

" remove spurious CR under Cygwin
function! syntastic#postprocess#cygwinRemoveCR(errors)
    if has('win32unix')
        for e in a:errors
            let e['text'] = substitute(e['text'], '\r', '', 'g')
        endfor
    endif

    return a:errors
endfunction

" decode XML entities
function! syntastic#postprocess#decodeXMLEntities(errors)
    for e in a:errors
        let e['text'] = syntastic#util#decodeXMLEntities(e['text'])
    endfor

    return a:errors
endfunction

" filter out errors referencing other files
function! syntastic#postprocess#filterForeignErrors(errors)
    return filter(copy(a:errors), 'get(v:val, "bufnr") == ' . bufnr(''))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
