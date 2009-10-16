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

function! MergeBlankLinesIntoSingleLine()

    " remember current position
    normal mt

    " first, delete all trailing white spaces in each line
    silent! :%s/\s\+$//e

    " second, empty lines containing only white spaces.
    silent! :%s/^\s*$//g

    " finally, squeeze contiguous blank lines into single line
    silent! :%s/^\s*\n\{2,}/\r/

    " retrun to original position
    silent! normal 't

    " disable highlighting search result temporarily.
    nohlsearch

endfunc


function! CompileCurrentFile()
    exec "w"
    exec "!clear"
    if &filetype == 'c'
        exec "!gcc % -g -o %<"
        exec "!./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    endif
endfunction

function! DebugCurrentFile()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -g -o %<"
        exec "!gdb %<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!jdb %<"
    endif
endfunction

function! InsertHeaderForBashScript()
        call setline(1, "#!/bin/bash")
        call setline(2, "")
        call setline(1, "/*************************************************************************")
        call append(line("."), " Author: Jekyll.Wu")
        call append(line(".")+1, " Created Time: ".strftime("%c"))
        call append(line(".")+2, " File Name: ".expand("%"))
        call append(line(".")+3, " Description: ")
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
endfunction

function! InsertClosingPair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function! ShowDiffSinceLastSave()
    let filename=expand('%')
    let diffname = filename.'.fileFromBuffer'
    exec 'saveas! '.diffname
    diffthis
    vsplit
    exec 'edit '.filename
    diffthis
endfunction

function! SwitchToBuffer(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

function! ShortTabLine()
    let ret = ''
    for i in range(tabpagenr('$'))
        " select the color group for highlighting active tab
        if i + 1 == tabpagenr()
            let ret .= '%#errorMsg#'
        else
            let ret .= '%#TabLine#'
        endif

        " find the buffername for the tablabel
        let buflist = tabpagebuflist(i+1)
        let winnr = tabpagewinnr(i+1)
        let buffername = bufname(buflist[winnr-1])
        let filename = fnamemodify(buffername,':t')
        " check if there is no name
        if filename == ''
            let filename = 'noname'
        endif
        " only show the first 6 letters of the name and
        " .. if the filename is more than 8 letters long
        if strlen(filename) >=8
            let ret .= '['. filename[0:5].'..]'
        else
            let ret .= '['.filename.']'
        endif
    endfor

    " after the last tab fill with TabLineFill and reset tab page #
    let ret .= '%#TabLineFill#%T'
    return ret
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
