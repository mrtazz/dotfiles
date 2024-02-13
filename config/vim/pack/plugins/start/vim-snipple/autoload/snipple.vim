if &cp || (exists('g:loaded_snipple_vim') && g:loaded_snipple_vim)
  finish
endif
let g:loaded_snipple_vim = 1

function! snipple#LoadSnippet(snippetFile)
  let fqSnippetFile = g:SnippleBaseDir . '/' . a:snippetFile
  if filereadable(fqSnippetFile)
    execute 'read ' . fqSnippetFile
  else
    call snipple#PrintError('Unable to load snippet file: ' . fqSnippetFile)
  endif
endfunction

function! snipple#PrintError(msg) abort
  execute 'normal! \<Esc>'
  echohl ErrorMsg
  echomsg a:msg
  echohl None
endfunction

function! snipple#AvailableSnippets(ArgLead, cmdline, cursorpos)
  let basePrefixLength = strlen(g:SnippleBaseDir . '/')

  " strip the prefix and only return parts matching the provided prefix on the
  " command completion
  return globpath(g:SnippleBaseDir, '**/*', 0, 1)
         \ ->filter('!isdirectory(v:val)')
         \ ->map('strpart(v:val,basePrefixLength)')
         \ ->filter('v:val =~ "^'. a:ArgLead .'"')
endfunction
