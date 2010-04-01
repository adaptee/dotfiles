"--------------------------------------------------------------------------"
"                    created by adaptee@gmail.com                          "
"--------------------------------------------------------------------------"

" indent the public/private keywords more conventionally
set cino=g0

" OmniCppComplete initialization
call omni#cpp#complete#Init()

" because ./c.vim will also apply to .cpp files, we need
" to explicitly set equalprg to empty, because external command
" indent does not work well with .cpp files
setlocal equalprg=


setlocal makeprg=g++\ %
