" define some basic variables
let g:PlanBaseDir = get(g:, 'PlanBaseDir', $HOME . "/.plan")
let g:PlanTemplateDir = get(g:, 'PlanTemplatePath', "templates")
let g:PlanDailiesDir = get(g:, 'PlanTemplatePath', "dailies")
let g:PlanNotesDir = get(g:, 'PlanTemplatePath', "notes")


command! PlanDaily :call plan#OpenDailyNote()
command! PlanNote :call plan#OpenNote()
command! PlanMarkDone :call plan#MarkDone()
command! PlanMarkCanceled :call plan#MarkCanceled()
command! PlanMigrateToToday :call plan#MigrateToToday()


augroup PluginPlan
  autocmd!
  " source syntax files for all notes files
  execute 'autocmd BufEnter */'.g:PlanDailiesDir.'/*.md runtime syntax/plan.vim'
  execute 'autocmd BufEnter */'.g:PlanNotesDir.'/*.md runtime syntax/plan.vim'

  " make sure idle notes are getting written to disk periodically
  execute 'autocmd CursorHold,CursorHoldI,BufLeave */'.g:PlanDailiesDir.'/*.md update'
  execute 'autocmd CursorHold,CursorHoldI,BufLeave */'.g:PlanNotesDir.'/*.md update'
augroup END
