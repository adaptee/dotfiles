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

