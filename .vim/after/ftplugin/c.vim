"--------------------------------------------------------------------------"
"                    created by adaptee@gmail.com                          "
"--------------------------------------------------------------------------"

" this file is intended to serve both c and c++ files.

" OmniCppComplete initialization
call omni#cpp#complete#Init()

" for c/c++ programmer under *nix
setlocal path+=/usr/include/c++/4.3
setlocal path+=/usr/include/linux

" make tag jumping more user-friendly
nnoremap <CR> g<C-]>
nnoremap <BS> <C-T>

"highlight trailing white space and spaces before a <Tab> in C/C++ files.
let c_space_errors = 1

" highlight strings and numbers within comments
let c_comment_strings = 1

setlocal equalprg=indent

" simplify inputting
iab rt return true;
iab rf return false;
iab rn return NULL;
iab r0 return 0;

" don't automatically insert leading // at the next line of
" current comment line.
"setlocal comments-=://

" allow % to jump between '='  and ';' in assignment
setlocal matchpairs+==:;
