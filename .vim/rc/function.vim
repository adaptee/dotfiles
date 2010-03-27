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
    " Without the clipboard feature, these 2 operation is invalid
    if has('clipboard')
        let @+ = expand('%:p')
        let @* = expand('%:p')
    endif
    " this operation is always safe
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
    "make sure it have like in normal mode, I.e, matching exactly the word.
    "let l:pattern = '\<' . l:pattern . '\>'

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
    execute "w"
    execute "!clear"
    if &filetype == 'c'
        execute "!gcc % -g -o %<"
        execute "!./%<"
    elseif &filetype == 'java'
        execute "!javac %"
        execute "!java %<"
    endif
endfunction

function! DebugCurrentFile()
    execute "w"
    if &filetype == 'c'
        execute "!gcc % -g -o %<"
        execute "!gdb %<"
    elseif &filetype == 'java'
        execute "!javac %"
        execute "!jdb %<"
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

function! InsertHeaderForPythonScript()
        call setline(1, "#!/usr/bin/env python")
        call setline(2, "")
        call setline(3, "")
        normal G
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
    execute 'saveas! '.diffname
    diffthis
    vsplit
    execute 'edit '.filename
    diffthis
endfunction

function! SwitchToBuffer(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        execute bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                execute "normal " . tab . "gt"
                execute bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        execute "tabnew " . a:filename
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

"only show filename in the tab label; path is not included
function! ShortGuiTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction

function! GuiTabToolTip()
    "get window count
    let wincount = tabpagewinnr(tabpagenr(),"$")
    let bufferlist=""
    "get name of active buffers in windows
    for i in tabpagebuflist()
        let bufferlist .= "[".fnamemodify(bufname(i),":t")."] "
    endfor
    return bufname($)."\n windows: ".wincount." " .bufferlist. " "
endfunction

function! MyBalloonExpr()
    let foldStart = foldclosed(v:beval_lnum )
    let foldEnd = foldclosedend(v:beval_lnum)
    let lines = []
    " Detect if we are in a fold
    if foldStart < 0
        " Detect if we are on a misspelled word
        let lines = spellsuggest( spellbadword(v:beval_text)[ 0 ], 5, 0 )
    else
        " we are in a fold
        let numLines = foldEnd - foldStart + 1
        " if we have too many lines in fold, show only the first 14
        " and the last 14 lines
        if ( numLines > 31 )
            let lines = getline( foldStart, foldStart + 14 )
            let lines += [ '-- Snipped ' . ( numLines - 30 ) . ' lines --' ]
            let lines += getline( foldEnd - 14, foldEnd )
        else
            "less than 30 lines, lets show all of them
            let lines = getline( foldStart, foldEnd )
        endif
    endif
    " return result
    return join( lines, has( "balloon_multiline" ) ? "\n" : " " )
endfunction

"-----------------------------------------------------------------------------
"                                problematic part
"-----------------------------------------------------------------------------

" toggle off search result highlighting only once.
let g:hlsearch_toggle_off_temporarily=0

function! TogglehlsearchOffOnlyOnce()
    if g:hlsearch_toggle_off_temporarily == 0
        let g:hlsearch_toggle_off_temporarily = 1
        execute "nohlsearch"
        " this forcing redrawing should not be omitted here.
        echo " hlsearch is disabled temporarily."
        redraw
    else
        let g:hlsearch_toggle_off_temporarily = 0
        set hlsearch
        echo " "
    endif
endfunction

"calc word frequency
function! WordFrequency() range
  let all = split(join(getline(a:firstline, a:lastline)), '\A\+')
  let frequencies = {}
  for word in all
    let frequencies[word] = get(frequencies, word, 0) + 1
  endfor
  new
  setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20
  for [key,value] in items(frequencies)
    call append('$', key."\t".value)
  endfor
  sort i
endfunction

command! -range=% WordFrequency <line1>,<line2>call WordFrequency()

" convert \uXXXX to corresponding unicode character
command! -range=% ToUnicode <line1>,<line2> :s/\\u\x\{4\}/\=eval('"' . submatch(0) . '"')/g


" show the modificatioin made to the buffer since loading the file
" stolen from help :DiffOrig, and add minor improvement : <silent>
command! DiffOrig vert new | set bt=nofile | r # | silent 0d_ | diffthis
        \ | wincmd p | diffthis

" delete correspoding swap file
command! DeleteSwp silent !rm .%.swp

