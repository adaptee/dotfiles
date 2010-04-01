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

"maximize the window when started
if has ("win32")
    autocmd GUIEnter * simalt ~x
elseif has ("unix")
    "set lines=40
    "set columns=160
endif

" prevent showing corrupted  character in menu
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
autocmd EncodingChanged * if &encoding == "utf-8" | nmap <M-Space> :simalt ~<CR> | so $VIMRUNTIME/delmenu.vim | so $VIMRUNTIME/menu.vim | language message zh_CN.UTF-8 | endif
autocmd EncodingChanged * if &encoding == "cp936" | nmap <M-Space> :simalt ~<CR> | so $VIMRUNTIME/delmenu.vim | so $VIMRUNTIME/menu.vim | language message zh_CN | endif

"Alt+xxx is not used for menu shortcut
"set winaltkeys=no

map <silent> <A-F1> :call ToggleGUIMenuBar()<CR>

"customize tab label
"set guitablabel=%{ShortGuiTabLabel()}
set guitablabel=%N.%t\ %m


"customize tab's tool-tip
set guitabtooltip=%!GuiTabToolTip()


"enable edit area tool-tip, after cursor staying for 800ms;for example, on a folded area
set ballooneval
set balloondelay=800
set balloonexpr=MyBalloonExpr()




