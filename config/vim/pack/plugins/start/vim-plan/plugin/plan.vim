" define some basic variables
" base dir
let g:PlanBaseDir = get(g:, 'PlanBaseDir', $HOME . "/.plan")
" template related configs
let g:PlanTemplateDir = get(g:, 'PlanTemplateDir', "templates")
let g:PlanDailyTemplate = get(g:, 'PlanDailyTemplate', "daily.md")
let g:PlanWeeklyTemplate = get(g:, 'PlanWeeklyTemplate', "weekly.md")
let g:PlanNoteTemplate = get(g:, 'PlanNoteTemplate', "note.md")
" directory definitions
let g:PlanDailiesDir = get(g:, 'PlanDailiesDir', "dailies")
let g:PlanWeekliesDir = get(g:, 'PlanWeekliesDir', "weeklies")
let g:PlanNotesDir = get(g:, 'PlanNotesDir', "notes")
" asset directory
let g:PlanAssetsDirectory = get(g:, 'PlanAssetsDirectory', "assets")

let g:PlanPromptForTitle = get(g:, 'PlanPromptForTitle', 0)
let g:PlanNoteTimestampPrefix = get(g:, 'PlanNoteTimestampPrefix', "%Y%m%d-%H%M%S")


" command definitions
command! PlanDaily :call plan#OpenDailyNote()
command! PlanWeekly :call plan#OpenWeeklyNote()
command! PlanNote :call plan#OpenNote()
command! PlanMarkDone :call plan#MarkDone()
command! PlanMarkCanceled :call plan#MarkCanceled()
command! PlanMigrateToToday :call plan#MigrateToToday()
command! PlanFindTodos :call plan#FindTodos()
command! -nargs=1 PlanImportAsset :call plan#ImportAsset(<q-args>)

" set up file navigation for notes
execute 'set path+='.g:PlanDailiesDir.','.g:PlanNotesDir
set suffixesadd+=.md


augroup PluginPlan
  autocmd!
  " source syntax files for all notes files
  execute 'autocmd BufEnter,BufRead */'.g:PlanDailiesDir.'/*.md runtime syntax/plan.vim'
  execute 'autocmd BufEnter,BufRead */'.g:PlanNotesDir.'/*.md runtime syntax/plan.vim'

  " make sure idle notes are getting written to disk periodically
  execute 'autocmd CursorHold,CursorHoldI,BufLeave */'.g:PlanDailiesDir.'/*.md update'
  execute 'autocmd CursorHold,CursorHoldI,BufLeave */'.g:PlanNotesDir.'/*.md update'

  " automatically open location/quickfix window after grep
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END
