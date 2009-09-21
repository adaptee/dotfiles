" added and modified by adaptee manually, not by any plugin.

" OmniCppComplete initialization
call omni#cpp#complete#Init()

" because ./c.vim will also apply to .cpp files, we need
" to explicitly set equalprg to empty, because external command
" indent does not work well with .cpp files
setlocal equalprg=
