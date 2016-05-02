if &cp || (exists('g:loaded_tinygo_vim') && g:loaded_tinygo_vim)
  finish
endif
let g:loaded_tinygo_vim = 1

" enable all syntastic checkers for go
let g:syntastic_go_checkers = ["go", "gofmt", "golint", "govet"]
let g:syntastic_aggregate_errors = 1

" ripped from the original golang vim plugin
let g:gofmt_command = "gofmt"

function! tinygo#GoFormat()
    let view = winsaveview()
    silent execute "%!" . g:gofmt_command
    if v:shell_error
        let errors = []
        for line in getline(1, line('$'))
            let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\)\s*\(.*\)')
            if !empty(tokens)
                call add(errors, {"filename": @%,
                                 \"lnum":     tokens[2],
                                 \"col":      tokens[3],
                                 \"text":     tokens[4]})
            endif
        endfor
        if empty(errors)
            % | " Couldn't detect gofmt error format, output errors
        endif
        undo
        if !empty(errors)
            call setqflist(errors, 'r')
        endif
        echohl Error | echomsg "Gofmt returned error" | echohl None
    endif
    call winrestview(view)
endfunction
command! Fmt call tinygo#GoFormat()

autocmd FileType go autocmd BufWritePre <buffer> Fmt
