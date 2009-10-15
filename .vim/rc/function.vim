" Note, this file serves as a centralized location for defining vim functions.

function! MakeHelpSystemNavigationWebStyle()
    " jump and jump back, like surfing web
    nmap <buffer> <CR> <C-]>
    nmap <buffer> <BS> <C-T>
    " jump to next/previous option item
    nmap <buffer> o /'[a-z]\{2,\}'<CR>
    nmap <buffer> O ?'[a-z]\{2,\}'<CR>
    " jump to next/previous subject item
    nmap <buffer> s /\|\S\+\|<CR>
    nmap <buffer> S ?\|\S\+\|<CR>
endfunction

function! CopyCurrentFileName()
    let @+ = expand('%:p')
    let @* = expand('%:p')
    let @" = expand('%:p')
endfunc

"-----------------------------------------------------------------------------
"                                problematic part
"-----------------------------------------------------------------------------

" toggle off search result highlighting only once.
let g:hlsearch_toggle_off_temporarily=0

function! TogglehlsearchOffOnlyOnce()
    if g:hlsearch_toggle_off_temporarily == 0
        let g:hlsearch_toggle_off_temporarily = 1
        exec "nohlsearch"
        " this forcing redrawing should not be omitted here.
        echo " hlsearch is disabled temporarily."
        redraw
    else
        let g:hlsearch_toggle_off_temporarily = 0
        set hlsearch
        echo " "
    endif
endfunction
