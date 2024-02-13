if &cp || (exists('g:loaded_plan_vim') && g:loaded_plan_vim)
  finish
endif
let g:loaded_plan_vim = 1


" set up some directory definitions
let s:dailiesDirectory = g:PlanBaseDir . "/" . g:PlanDailiesDir
let s:notesDirectory = g:PlanBaseDir . "/" . g:PlanNotesDir
let s:templatePath = g:PlanBaseDir . "/" . g:PlanTemplateDir
let s:titleEnabled = g:PlanPromptForTitle

function! plan#OpenDailyNote()
  let today = strftime("%Y%m%d")
  call plan#EnsureDirectoryExists(s:dailiesDirectory)
  let plan = s:dailiesDirectory . "/" . today . ".md"
  execute 'edit' plan
  if !filereadable(plan)
    "read in the template file if available
    let tmplPath = s:templatePath . "/daily"
    if filereadable(tmplPath)
      execute 'read ' . tmplPath
      call plan#replaceTemplateVariables()
    endif
  endif
  call plan#setupBuffer()
endfunction

function! plan#OpenNote()
  let msg = s:titleEnabled ? input('Enter note file title: ') : ''
  let maybeTitle = msg ==  '' ? msg : "-" . msg
  let dateTime = strftime("%Y%m%d-%H%M%S")
  call plan#EnsureDirectoryExists(s:notesDirectory)
  let plan = s:notesDirectory . "/" . dateTime . maybeTitle . ".md"
  execute 'edit' plan
  call plan#setupBuffer()
endfunction

function! plan#MarkDone()
  call setline(line('.'), substitute(getline('.'), '- \[ \]', '- [x]', 'g'))
endfunction

function! plan#MarkCanceled()
  call setline(line('.'), substitute(getline('.'), '- \[ \]', '- [-]', 'g'))
endfunction

function! plan#MigrateToToday()
  let today = strftime("%Y%m%d")
  let todayplan = s:dailiesDirectory . "/" . today . ".md"
  let current_daily =  expand("%:t:r")
  let moved_todo = getline('.') . ' <[[' . current_daily . ']]'
  call writefile([moved_todo], todayplan, "a")
  call setline(line('.'), substitute(getline('.'), '- \[ \]', '- [>]', 'g'))
  execute "normal! A" . ' >[[' . today . ']]'
endfunction

function! plan#replaceTemplateVariables()
  " replace occurrences of DATE with the actual date
  let thedate = strftime("%m\\/%d\\/%Y")
  silent exe "1,$g/%%DATE%%/s/%%DATE%%/" . thedate

  " replace occurrences of DATE_8601 with the actual date
  let thedate8601 = strftime("%Y\\/%m\\/%d")
  silent exe "1,$g/%%DATE_8601%%/s/%%DATE_8601%%/" . thedate8601

  " replace occurrences of WEEKDAY with the current weekday
  let weekday = strftime("%A")
  silent exe "1,$g/%%WEEKDAY%%/s/%%WEEKDAY%%/" . weekday

  " replace occurrences of MONTH with the current month
  let month = strftime("%B")
  silent exe "1,$g/%%MONTH%%/s/%%MONTH%%/" . month

  " replace occurrences of YEAR with the current year
  let year = strftime("%Y")
  silent exe "1,$g/%%YEAR%%/s/%%YEAR%%/" . year

  " replace occurrences of WEEKNUMBER with the current weeknumber
  let weeknumber = strftime("%V")
  silent exe "1,$g/%%WEEKNUMBER%%/s/%%WEEKNUMBER%%/" . weeknumber

  "if the cursor was previously on a blank line, delete it
  if getline(line(".")-1) =~ '^\s*$'
      exec line(".")-1 . 'd'
  endif
endfunction

function! plan#EnsureDirectoryExists(dir)
  if !isdirectory(a:dir)
    call mkdir(a:dir, "p")
  endif
endfunction

function! plan#setupBuffer()
  execute 'lcd' g:PlanBaseDir
endfunction

function! plan#FindTodos()
  call plan#setupBuffer()
  execute ':silent lgrep! "\- \[ \]" ' . s:dailiesDirectory . ' ' . s:notesDirectory
  execute ':redraw!'
endfunction
