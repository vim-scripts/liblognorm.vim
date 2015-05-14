" Vim syntax file
" Language:	liblognorm: log normalization library
" Maintainer: Stanislaw Klekot <vim@jarowit.net>
" Last Change: 2012-03-01
" Version: 0.1

"-----------------------------------------------------------------------------
" setup {{{

if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif

syn case match
setlocal iskeyword=a-z,A-Z,48-57,_

" }}}
"-----------------------------------------------------------------------------
" the grammar {{{

" line types
syn match   llnComment    /^\s*#.*/
syn match   llnPrefix     /^prefix=/he=e-1   nextgroup=llnMatchDef
syn match   llnRule       /^rule=/he=e-1     nextgroup=llnRuleTag
syn match   llnAnnotate   /^annotate=/he=e-1 nextgroup=llnAnnTag

" common patterns
syn match   llnTag        contained  /[^ ,:]\+/
syn match   llnHexChar    contained  /\\x[[:xdigit:]][[:xdigit:]]/

" rules
syn match   llnRuleTag    contained  /[^:]\+/  contains=llnTag nextgroup=llnRuleStart
syn match   llnRuleStart  contained  /:/                       nextgroup=llnMatchDef

" rule or prefix
syn match   llnMatchDef   contained  /.*/  contains=llnHexChar,llnField
syn match   llnField      contained  /%[^%:]\+:[a-zA-Z0-9_-]\+\(:[^%]\+\)\?%/ contains=llnFieldName
syn match   llnFieldName  contained  /[^%:]\+:/he=e-1   nextgroup=llnFieldType
syn match   llnFieldType  contained  /[a-zA-Z0-9_-]\+/  nextgroup=llnFieldArg
syn match   llnFieldArg   contained  /:[^%]\+/hs=s+1    contains=llnHexChar

" annotation
syn match   llnAnnTag      contained  /[^:]\+/   contains=llnTag        nextgroup=llnAnnField
syn match   llnAnnField    contained  /:+[a-zA-Z0-9_]\+=/hs=s+2,he=e-1  nextgroup=llnAnnValue
syn match   llnAnnValue    contained  /"[^"]*"/  contains=llnHexChar

" }}}
"-----------------------------------------------------------------------------
" colour binding {{{

hi def link llnComment      Comment

hi def link llnTag          Constant
hi def link llnHexChar      Special

hi def link llnPrefix       Keyword

hi def link llnRule         Keyword
hi def link llnRuleStart    Special

hi def link llnAnnotate     Keyword
hi def link llnAnnField     Identifier
hi def link llnAnnValue     Constant

hi def link llnField        Macro
hi def link llnFieldName    Identifier
hi def link llnFieldType    Type
hi def link llnFieldArg     Constant

" Special

" }}}
"-----------------------------------------------------------------------------

let b:current_syntax = "liblognorm"

"-----------------------------------------------------------------------------
" vim:foldmethod=marker:nowrap
