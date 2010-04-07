"--------------------------------------------------------------------------"
"                    created by adaptee@gmail.com                          "
"--------------------------------------------------------------------------"

" indent the public/private keywords more conventionally
setlocal cino+=g0

" OmniCppComplete initialization
call omni#cpp#complete#Init()

" because ./c.vim will also apply to .cpp files, we need
" to explicitly set equalprg to empty, because external command
" indent does not work well with .cpp files
setlocal equalprg=


" the pattern used to find macro definition
" stolen from :help 'debug''
setlocal define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)

