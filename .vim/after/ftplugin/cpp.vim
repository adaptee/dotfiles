" added and modifyed by adaptee manually, but by any plugin.

" OmniCppComplete initialization
call omni#cpp#complete#Init()

" because ./c.vim will also apply to .cpp files, we need
" to explict set equalprg to empty, because external command
" indent does not work well with .cpp files
setlocal equalprg=
