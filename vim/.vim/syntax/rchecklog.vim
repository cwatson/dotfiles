" Vim syntax file
" Language:         R check log file
" Maintainer:       Chris Watson
" Latest Revision:  2019-03-05

if exists("b:current_syntax")
    finish
endif

syn match   rCheckAsterisk  '^*'
syn region  rCheckString    start='`' end="[`']"
syn match   rCheckVersion   'R\sversion\s\d\.\d\.\d\s(\d\d\d\d\-\d\d\-\d\d)'
syn keyword rCheckOK        OK DONE Status
syn region  rCheckNoteText  start=/NOTE/ end=/^\*/me=s-1 nextgroup=rCheckAsterisk
syn region  rCheckWarnText  start=/[0-9]*\sWARNING/ end=/^\*/me=s-1 nextgroup=rCheckAsterisk
syn region  rCheckErrorText start=/ERROR/ end=/^\*/me=s-1
"syn match   rCheckNoteEnd    '[0-9]*\sNOTE[,$]*'
"syn match   rCheckWarnEnd    '[0-9]*\sWARNING[,$]*'

hi def link rCheckNoteText  Conditional
hi def link rCheckNoteEnd   Conditional
hi def link rCheckWarnText  Special
hi def link rCheckWarnEnd   Special
hi def link rCheckErrorText Error
hi def link rCheckString    String
hi def link rCheckAsterisk  Identifier
hi def link rCheckVersion   Function
hi def link rCheckOK        Type

let b:current_syntax = "rchecklog"
