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


function! AdjustCommaRelatedSpacing()
    if ( &filetype == 'c' || &filetype == 'cpp' || &filetype == "")
        "memory current position
        "normal m`

        "remove extra white-spaces between comma and its previous word.
        silent! :%s/\>\s\+,/,/ge
        "remove extra white-spaces between comma and its next word.
        silent! :%s/,\s\+\</, /ge
        "if comma is directly followed by a word, insert one space
        silent! :%s/,\</, /ge

        "return to memorize position
        "normal ``
    endif
endfunction

" for parameter direction, 'b' means backword, 'f' means forward
function! SearchVisualSelectedText(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    else
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunc

function! DeleteTrailingWhiteSpaces()
        normal m`
        silent! :%s/\s\+$//e
        normal ``
endfunction

function! ToggleGUIMenuBar()
    if &guioptions =~# 'm'
        set guioptions-=m
    else
        set guioptions+=m
    endif
endfunction

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
