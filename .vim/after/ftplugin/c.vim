" added and modified by adaptee manually, not by any plugin.

" OmniCppComplete initialization
call omni#cpp#complete#Init()

" don't automatically insert leading // at next line of
" current comment line.
"setlocal comments-=://

"highlight trailing white space and spaces before a <Tab> in C/C++ files.
let c_space_errors=1

setlocal equalprg=indent

" use iab to simplify inputting
iab rt return true;
iab rf return false;
iab rn return NULL;
iab r0 return 0;
