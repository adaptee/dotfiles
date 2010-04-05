"setting for gVim

"choose font
if has("unix")
    set guifont=Monaco\ 13
    set guifontwide=DejaVu\ Sans\ YuanTi\ Mono\ 13
elseif has("win32")
    set guifont=Monaco:h11:cANSI
    set guifontwide=DejaVu_Sans_Mono:h11:cANSI
endif

"remove the toolbar, menubar
set guioptions-=T       "No toolbar
set guioptions-=m       "No menu

"make highlighted text yanked into global selection (*) automatically
set guioptions+=a

"don't show boring scroll-bar
set guioptions-=r
set guioptions-=l

"make the window where mouse pointer on become current ; enumerate X-window style
set mousefocus

"maximize when started ; only effective in windows
if has ("win32")
    autocmd GUIEnter * simalt ~x
endif

"Alt+xxx is not used for menu shortcut
"set winaltkeys=no

map <silent> <A-F1> :call ToggleGUIMenuBar()<CR>

"customize tabpage label
"set guitablabel=%{ShortGuiTabLabel()}
set guitablabel=%N.%t\ %m


"customize tabpage's tool-tip
set guitabtooltip=%!GuiTabToolTip()

" enable edit area tool-tip, after cursor staying for 800ms
" for example, on a folded area
set ballooneval
set balloondelay=800
set balloonexpr=MyBalloonExpr()

" use normal font in statusline in gvim
hi StatusLine gui=none

"--------------------------------------------------------------------------"
"                                   input method                           "
"--------------------------------------------------------------------------"

if ( has('multi_byte_ime') || has('xim') )

    "" disable IM anywhere ,totally
    "set imdisable

    " [X11 only] crontrol input method from vim
    " [NOTE], "space" , not "Space";
    "set imactivatekey=C-space

    "" whether activate IM automatically when entering into search line
    "" my choice : [NO], because you seldom search non-English chars by
    "" typing them manually . Use */# intensively!
    set imsearch=0

    "" whether activate IM automatically when entering into command line
    "" my choice : [NO], because you seldom input non-English chars in
    "" commandline
    set noimcmdline

    "" whether activate IM automatically when entering into insert mode
    "" [FIXME] current cause problem with ibus in X11
    "" everything is OK with win32, such as google pinyin, sogou pinyin
    set iminsert=0
    "inoremap <ESC> <ESC>:silent set iminsert=0<CR>

    "autocmd  InsertEnter * set iminsert=2
    "autocmd  InsertLeave * set iminsert=0

endif

