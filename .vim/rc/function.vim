" this file serves as a centralized location for user-defined functions.

"--------------------------------------------------------------------------"
"                                   for status line                        "
"--------------------------------------------------------------------------"

" the syntax group of current word
function! SyntaxGroup()
    return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" the highlight group of current word
function! HighlightGroup()
    return synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
endfunction

" offset percentage by byte, instead of by line
function! BytePercent()
    let CurByte = line2byte (line ( "." ) ) + col ( "." ) - 1
    let TotBytes = line2byte( line( "$" ) + 1) - 1
    return ( CurByte * 100 ) / TotBytes
endfunction

" current line's indent level
function! IndentLevel()
    let l:indentlevel = (indent('.') / &shiftwidth )
    if l:indentlevel == 0
        let l:indentlevel='*'
    endif
    return l:indentlevel
endfunction

"set statusline+=\ [Syn=%{SyntaxGroup()}]
"set statusline+=\ [HI=%{HighlightGroup()}]
"set statusline+=\ [%{IndentLevel()}]
"set statusline+=\ [%{BytePercent()}%%]


function! CopyCurrentFileName()
    " Without the clipboard feature, these 2 operation is invalid
    if has('clipboard')
        let @+ = expand('%:p')
        let @* = expand('%:p')
    endif
    " this operation is always safe
    let @" = expand('%:p')
endfunction

function! DeleteTrailingWhiteSpaces()
    normal mt
    silent! :%s/\s\+$//e
    normal 't
endfunction

function! ToggleGUIMenuBar()

    " dealy menu loading to the last momoent
    "if g:did_install_default_menus == 0
    "source $VIMRUNTIME/delmenu.vim
    "source $VIMRUNTIME/menu.vim
    "let did_install_default_menus=1
    "set guioptions-=M
    "endif

    if &guioptions =~# 'm'
        set guioptions-=m
    else
        set guioptions+=m
    endif

endfunction

function! AdjustCommaRelatedSpacing()
    if ( &filetype == 'c' || &filetype == 'cpp' || &filetype == "")
        "memory current position
        normal mc

        "remove extra white-spaces between comma and its previous word.
        silent! :%s/\>\s\+,/,/ge
        "remove extra white-spaces between comma and its next word.
        silent! :%s/,\s\+\</, /ge
        "if comma is directly followed by a word, insert one space
        silent! :%s/,\</, /ge

        "return to memorize position
        normal 'c
    endif
endfunction

function! MergeBlankLinesIntoSingleLine()

    " remember current position
    normal mb

    " first, delete all trailing white spaces in each line
    silent! :%s/\s\+$//e

    " second, empty lines containing only white spaces.
    silent! :%s/^\s*$//g

    " finally, squeeze contiguous blank lines into single line
    silent! :%s/^\s*\n\{2,}/\r/

    " return to original position
    silent! normal 'b

    " disable highlighting search result temporarily.
    nohlsearch

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

function! SwitchToBuffer(filename)
    let l:fullname = expand(a:filename)
    let l:exist = bufexists(l:fullname)
    if l:exist
        echo l:fullname . " is already loaded !"
    endif
    " find in current tab
    "echo a:filename
    let bufwinnr = bufwinnr(a:filename)
    echo "bufwinnr: " . bufwinnr
    if bufwinnr != -1
        "echo "#if branch"
        "execute bufwinnr . "wincmd w"
        return
    else
        "echo "#else branch"
        "return
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

function! MyTabLine()
    let ret = ''
    for i in range(tabpagenr('$'))
        " select the highlighting of active tabpage
        if i + 1 == tabpagenr()
            let ret .= '%#TabLineSel#'
        else
            let ret .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let ret .= '%' . (i + 1) . 'T'

        "" buffers modified or not ;
        let ret .= '%{MyTabModified(' . (i + 1) . ')}'

        " current buffer short name()
        let ret .= ' %{MyTabLabel(' . (i + 1) . ')} '

    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let ret .= '%#TabLineFill#%T'
    return ret

endfunction

function! MyTabLabel(n)
    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
    let l:bufname = bufname(l:buflist[l:winnr - 1])
    " we are only instrested with the tail component
    let l:bufname = fnamemodify(l:bufname,':t')

    " make empty tabpage do not looks that weired
    if l:bufname == ""
        let l:bufname="NoName"
    endif

    "" only show the first 10 letters of filename whne
    if strlen(bufname) >=10
        let bufname = bufname[0:9]
    endif

    return l:bufname

endfunction


function! MyTabModified(n)

    let buflist = tabpagebuflist(a:n)

    " if any buffer is modified
    for bufnr in buflist
        if getbufvar(bufnr, '&modified')
            return ' +'
        endif
    endfor

    return ""

endfunction


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

" calculate word frequency
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



" diff between buffer and the file on the filesystem
" idea stolen from help :DiffOrig
function! DiffOrig()
    let filetype=&ft
    diffthis

    " new window
    vert new | r # | normal! 1Gdd
    diffthis
    execute "setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile readonly filetype=" . filetype

    " back to previous window
    wincmd p
endfunction

command! -nargs=0 DiffOrig :call DiffOrig()


" delete corresponding swap file
command! DeleteSwp silent !rm .%.sw*

" show simple regex reference
command! Regex tabnew ~/.vim/doc/regexpref.txt

" quick way ot open some official doc
command! Quick  :tab help quickref.txt
command! Index  :tab help index.txt
command! Howto  :tab help howto.txt
command! Tips   :tab help tips.txt
" open the colortest script in new tabpage
command! ColorTest  tabnew | runtime syntax/colortest.vim | normal gg


" reverse lines orders ; stolen from usr_12.txt
command! -range=% Reverse :<line1>,<line2> global/^/m <line1>-1 | nohlsearch

" convert paragraph to single line
" stolen from usr_25.txt
command! -range=% Para2Line g/\S/,/^\s*$/join

" fill previously visual selected chars with SPACEs
" BUG: fail on multilines
function! FillWithSpace()

    " implicit argl:
    " previously visual selceted characters, stored in register @s

    " remember original position
    normal ms

    let l:visual_selected_chars = @s
    "echo l:visual_selected_chars

    let l:char_num = len(l:visual_selected_chars)

    "let l:commands = l:char_num . 'r ' . '\e'
    let l:commands = l:char_num . 'r '

    execute "normal" . l:commands

    " restore original position
    normal 's

endfunction

vnoremap <silent><Space> "sy<Esc>:call FillWithSpace()<CR>


" variant of getcwd(): un-expand $HOME to ~
function! GetCWD()
    "return expand("%:p:h")
    return substitute(getcwd(), $HOME,'~','' )
endfunction


" record and show the output of Ex commands
function! CaptureExOutput(cmd)
    " got you !
    redir  @x
    silent execute a:cmd
    redir END

    tabnew
    setlocal buftype=nofile
    normal "xp
    normal gg
    "nohlsearch
endfunction

command! -nargs=+ -complete=command CaptureExOutput call CaptureExOutput(<q-args>)



" when current window lost focus, save the buffer
function! SaveOnFocusLost()
    execute ":autocmd FocusLost" expand("%") ":w"
endfunction

command! -nargs=0 SaveOnFocusLost call SaveOnFocusLost()


" prepend line numbers for ranges
" [range]Nl [width=4]
command! -range=% -nargs=? Nl <line1>,<line2>s/^/\=printf("%" . eval( "GetNiceWidth(<args>)" ) . "d  ", line(".") - <line1> + 1)/ | nohlsearch

function! GetNiceWidth(...)
    " use 4 asthe default linenumber width
    " this witdh will be good for most files
    if a:0 == 0
        return 4
    else
        return a:1
    endif
endfunction

" duplicate each line in ranges
command! -range=% -nargs=0 Duplicate <line1>,<line2> g/^/copy . | nohlsearch

" append a Newline for each line in range
command! -range=% -nargs=0 Newline <line1>,<line2> g/^/put _ | nohlsearch


" stole from vimtip #27
" can apply to arguement, or all digit in the region
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
    if empty(a:arg)
        if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
            let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
        else
            let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
        endif
        try
            execute a:line1 . ',' . a:line2 . cmd
        catch
            echo 'Error: No decimal number found'
        endtry
    else
        echo printf('%x', a:arg + 0)
    endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
    if empty(a:arg)
        if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
            let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
        else
            let cmd = 's/0x\x\+/\=submatch(0)+0/g'
        endif
        try
            execute a:line1 . ',' . a:line2 . cmd
        catch
            echo 'Error: No hex number starting "0x" found'
        endtry
    else
        echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
    endif
endfunction


" vimtip #659
" view folder hierarchical in flat mode
function! FlatView(dir)
    new
    set buftype=nofile
    set bufhidden=hide
    set noswapfile
    normal i.
    while 1
        let file = getline(".")
        if (file == '')
            normal dd
        elseif (isdirectory(file))
            normal dd
            let @" = glob(file . "/*")
            normal O
            normal P
            let @" = glob(file . "/.[^.]*")
            if (@" != '')
                normal O
                normal P
            endif
        else
            if (line('.') == line('$'))
                return
            else
                normal j
            endif
        endif
    endwhile
endfunction

" vimtip #913
function! Rm(...)
    " when no args are given, delete current file
    if(exists('a:1'))
        let theFile = expand(a:1)
    else
        let theFile = expand('%:p')
    endif

    " builtin function delete() works on all OSs
    let delStatus = delete(theFile)
    if(delStatus == 0)
        echo "Deleted " . theFile
    else
        echohl WarningMsg
        echo "Failed to delete " . theFile
        echohl None
    endif
endfunction

" delete file on the disk
command! -complete=file -nargs=? Rm call Rm(<f-args>)


" techinally, ASCII is only 00-ff
command! HighlightNonASCII normal /[^\x00-\xff]<CR>
command! DeleteNonASCII %s/[^\x00-\xff]//g


" close window
" when current tabpage is also close , switch to the on on the left
" instead of the default right one
function! Quit(quitcmd)

    let l:prev_tabpageamount = tabpagenr('$')
    let l:prev_tabpagenr = tabpagenr()

    execute a:quitcmd

    let l:curr_tabpageamount = tabpagenr('$')
    let l:curr_tabpagenr = tabpagenr()

    if ( l:curr_tabpageamount < l:prev_tabpageamount  && l:curr_tabpagenr == l:prev_tabpagenr)
        tabprev
    endif
endfunction

command! -nargs=1  Quit call Quit(<args>)


" add execution permission for current file
function! XBit()
    let fname = expand("%:p")
    checktime
    silent !chmod u+x %
    checktime
endfunction
command! -nargs=0 Xbit call XBit()



" first consider global variable
" if not found ,consider local variable
function! GotoDefinition(identifier)
    "echo "a:identifier " . a:identifier
    let pos = getpos(".")

    "silent! execute "tag " . a:identifier
    silent! execute "normal \<C-]>"

    " staying at same line means not found
    if getpos(".") == pos
        normal gd
    endif
endfunction


function! TabMoveLeft()
    let l:current_nr = tabpagenr()

    if l:current_nr == 1
        return
    else
        execute "tabmove "  . (l:current_nr - 2)
    endif
endfunction

function! TabMoveRight()
    let l:current_nr = tabpagenr()
    let l:last_nr = tabpagenr('$')

    if l:current_nr == l:last_nr
        return
    else
        execute "tabmove "  . (l:current_nr )
    endif
endfunction


" vimtip #131
function! ScrollOtherWindow(dir)
    if a:dir == "down"
        let move = "\<C-E>"
    elseif a:dir == "up"
        let move = "\<C-Y>"
    endif
    exec "normal \<C-W>p" . move . "\<C-W>p"
endfunction

" vimtip #576
function! GenerateUnicode(first, last)
    let i = a:first
    while i <= a:last
        if (i%256 == 0)
            silent $put ='----------------------------------------------------'
            silent $put ='     0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F '
            silent $put ='----------------------------------------------------'
        endif
        let c = printf('%04X ', i)
        for j in range(16)
            let c = c . nr2char(i) . ' '
            let i += 1
        endfor
        silent $put =c
    endwhile
endfunction

" convert \uXXXX to corresponding Unicode character
command! -range=% ToUnicode <line1>,<line2> :s/\\u\x\{4\}/\=eval('"' . submatch(0) . '"')/g


" vimtip #734
" when at somewhere past EOL, 'x' will bring you back to EOL
function! BetterXinVirtualEdit()
    if &ve != "" && col('.') >= col('$')
        normal $
    endif
endfunction


" make contiguous duplicate lines uniq, without sorting
" sort -u works similarly, but sort before deleting
command! -range=%  -nargs=0 Uniq <line1>,<line2> global/^\(.*\)$\n\1$/d | nohlsearch

