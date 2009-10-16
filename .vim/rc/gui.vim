"setting for gVim

"choose font
if has("unix")
    set guifont=DejaVu\ Sans\ Mono\ 14
    set guifontwide=Vera\ Sans\ YuanTi\ Mono\ 14
elseif has("win32")
    set guifont=DejaVu_Sans_Mono:h11:cDEFAULT
    set guifontwide=Vera_Sans_YuanTi_Mono:h11:cDEFAULT
endif

"remove the toolbar, menubar
set guioptions-=T       "No toolbar
set guioptions-=m       "No menu

"make highlighted text yanked into global selection automatically
set guioptions+=a

"don't show boring scrollbar
set guioptions-=r
set guioptions-=l

"make the window where mouse pointer on become current ; enumerate X-window style
set mousefocus

"maxmize the window when started
if has ("win32")
    autocmd GUIEnter * simalt ~x
elseif has ("unix")
    "set lines=40
    "set columns=160
endif

"Alt+xxx is not used for menu shortcut
"set winaltkeys=no

map <silent> <A-F1> :call ToggleGUIMenuBar()<CR>

"customize tab label
"set guitablabel=%{ShortGuiTabLabel()}
set guitablabel=%N.%t\ %m


"customize tab's tooltip
set guitabtooltip=%!InfoGuiTooltip()


"enable edit area tooltip, after cursor staying for 800ms;for example, on a folded area
set ballooneval
set balloondelay=800
set balloonexpr=FoldSpellBalloon()

function! FoldSpellBalloon()
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



