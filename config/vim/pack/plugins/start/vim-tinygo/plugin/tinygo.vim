command! Fmt call tinygo#GoFormat()

autocmd FileType go autocmd BufWritePre <buffer> Fmt
