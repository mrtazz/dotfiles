" =============================================================================
" File:          ftplugin/indent.vim
" Description:   TaskJuggler indentation
" Author:        Jim Kalafut <github.com/kalafut>
" Credits:       Contents derived from the TaskJuggler distribution
" =============================================================================

setlocal softtabstop=2
setlocal cindent shiftwidth=2
setlocal tabstop=2
setlocal expandtab
setlocal cinoptions=g0,t0,+0,(0,c0,C1,n-2
setlocal cinwords=account,accountreport,allocate,booking,columns,dailymax,dailymin,date,depends,export,extend,icalreport,include,journalentry,limits,maximum,minimum,monthlymax,monthlymin,navigator,newtask,nikureport,number,precedes,project,reference,resource,resourcereport,richtext,scenario,shift,status,statussheet,statussheetreport,supplement,tagfile,task,taskreport,text,textreport,timesheet,timesheetreport,tracereport,weeklymax,weeklymin
setlocal cinkeys=0{,0},!^F,o,O
setlocal cindent
