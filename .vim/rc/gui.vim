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
set guitabtooltip=%!GuiTabToolTip()


"enable edit area tooltip, after cursor staying for 800ms;for example, on a folded area
set ballooneval
set balloondelay=800
set balloonexpr=MyBalloonExpr()




