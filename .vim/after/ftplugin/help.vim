" make navigating help system like web surfing

" jump and jump back, like surfing web
nmap <buffer> <CR> <C-]>
nmap <buffer> <BS> <C-T>

" jump to next/previous option item
nmap <buffer> o /'[a-z]\{2,\}'<CR>
nmap <buffer> O ?'[a-z]\{2,\}'<CR>

" jump to next/previous subject item
nmap <buffer> s /\|\S\+\|<CR>
nmap <buffer> S ?\|\S\+\|<CR>

" help file reads bettern without linenumber
setlocal nonumber

" help file do not need folding
setlocal foldcolumn=0

" ( and ) should be excluded when expanding <cword>
" with this setting, Ctrl-[  will fail on ('wrap'
" example  $VIMRUNTIME/doc/motion.txt :200
setlocal iskeyword+=^(,^)
