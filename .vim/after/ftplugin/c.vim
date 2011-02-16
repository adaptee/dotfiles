"--------------------------------------------------------------------------"
"                    created by adaptee@gmail.com                          "
"--------------------------------------------------------------------------"

" this file is intended to serve both c and c++ files.

" for c/c++ programmer under *nix
setlocal path+=/usr/include/c++/4.3
setlocal path+=/usr/include/linux


"highlight trailing white space and spaces before a <Tab> in C/C++ files.
let c_space_errors = 1

" highlight strings and numbers within comments
let c_comment_strings = 1

setlocal equalprg=indent

" simplify inputting
iab <buffer> rt return true;
iab <buffer> rf return false;
iab <buffer> rn return NULL;
iab <buffer> r0 return 0;

" don't automatically insert leading // at the next line of
" current comment line.
"setlocal comments-=://

" allow % to jump between '='  and ';' in assignment
setlocal matchpairs+==:;

" show the definition in preview window
"nnoremap <buffer> <C-]> :execute "ptjump " . expand("<cword>")<Esc>
" similiar, but put focus on new window
nnoremap <buffer> <C-]> <C-w>g<C-]>

" in c/cpp code, somo characters are used much more frequencies then theri twins
inoremap <buffer> 5 %
inoremap <buffer> % 5

inoremap <buffer> 7 &
inoremap <buffer> & 7

inoremap <buffer> 8 *
inoremap <buffer> * 8

"inoremap <buffer> [ {
"inoremap <buffer> { [

"inoremap <buffer> ] }
"inoremap <buffer> } ]

" start or end comment
iab <buffer> #b /************************************************
iab <buffer> #e ************************************************/
iab <buffer> #l /*----------------------------------------------*/
