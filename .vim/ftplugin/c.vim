"--------------------------------------------------------------------------"
"                    created by adaptee@gmail.com                          "
"--------------------------------------------------------------------------"

"Note, this file is intended to serve both c and c++ files.

" for c/c++ programmer under *nix
set path+=/usr/include/c++/4.3
set path+=/usr/include/linux

" In C/C++ file, press ',;' to append ';' to the end of the line, when it is missing.
"autocmd FileType *.c,*.cpp  nnoremap <leader>; :s/\([^;]\)$/\1;/<CR>:let @/=""<CR><esc>
nnoremap <leader>; :s/\([^;]\)$/\1;/<CR>:let @/=""<CR><esc>

