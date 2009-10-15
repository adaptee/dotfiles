" Note, this file serves as a centralized location for defining vim functions.


"-----------------------------------------------------------------------------
"                                problematic part
"-----------------------------------------------------------------------------

" toggle off search result highlighting only once.
let g:hlsearch_toggle_off_temporarily=0

function! TogglehlsearchTemporarily()
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
