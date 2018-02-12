command! OpenWeekPlan :call plan#OpenCurrentPlanByWeek()
command! OpenMonthPlan :call plan#OpenCurrentPlanByMonth()
command! OpenYearPlan :call plan#OpenCurrentPlanByYear()
command! Today :call plan#Today()

map <leader>pw :OpenWeekPlan<CR>
map <leader>pm :OpenMonthPlan<CR>
map <leader>py :OpenYearPlan<CR>
map <leader>pd :Today<CR>
