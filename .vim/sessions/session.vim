let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
imap <S-Tab> 
inoremap <C-Tab> 	
imap <silent> <expr> <F5> (pumvisible() ? "\<Plug>LookupFileCE" : "")."\\<Plug>LookupFile"
inoremap <Plug>LookupFileCE 
inoremap <silent> <Plug>NERDCommenterInInsert  <BS>:call NERDComment(0, "insert")
inoremap <silent> <F2> :TlistToggle
inoremap <silent> <F3> :NERDTreeToggle %:p:h
imap <F1> :exec "help ".expand("<cword>")
imap <Up> gka
imap <Down> gja
map! <S-Insert> <MiddleMouse>
nmap d :cs find d =expand("<cword>")
nmap i :cs find i ^=expand("<cfile>")$
nmap f :cs find f =expand("<cfile>")
nmap e :cs find e =expand("<cword>")
nmap t :cs find t =expand("<cword>")
nmap c :cs find c =expand("<cword>")
nmap g :cs find g =expand("<cword>")
nmap s :cs find s =expand("<cword>")
nmap  <Nop>
nnoremap  3
nnoremap  ^
snoremap <silent> 	 i<Right>=TriggerSnippet()
xmap 	 >
vnoremap <NL> 3j
nnoremap <NL> 3j
vnoremap  3k
nnoremap  3k
nnoremap  $
nnoremap  g
nmap o <Plug>ZoomWin
nnoremap  3
nnoremap   
vnoremap   "*ymzqqq:silent g/*/y Q'z:tabnew"Qpdgg
vmap # :call VisualSearch('b')
snoremap ' b<BS>'
nnoremap ' `
vmap * :call VisualSearch('f')
map <silent> ,cw <Plug>CRV_CRefVimAsk
nmap <silent> ,cr <Plug>CRV_CRefVimNormal
vmap <silent> ,cr <Plug>CRV_CRefVimVisual
nmap ,caL <Plug>CalendarH
nmap ,cal <Plug>CalendarV
nmap <silent> ,bv :VSBufExplorer
nmap <silent> ,bs :HSBufExplorer
nmap <silent> ,be :BufExplorer
nmap <silent> ,ubs :call BASH_RemoveGuiMenus()
nmap <silent> ,lbs :call BASH_CreateGuiMenus()
nmap ,ihn :IHN
nmap ,is :IHS:A
nmap ,ih :IHS
nmap ,ca <Plug>NERDCommenterAltDelims
vmap ,cA <Plug>NERDCommenterAppend
nmap ,cA <Plug>NERDCommenterAppend
vmap ,c$ <Plug>NERDCommenterToEOL
nmap ,c$ <Plug>NERDCommenterToEOL
vmap ,cu <Plug>NERDCommenterUncomment
nmap ,cu <Plug>NERDCommenterUncomment
vmap ,cn <Plug>NERDCommenterNest
nmap ,cn <Plug>NERDCommenterNest
vmap ,cb <Plug>NERDCommenterAlignBoth
nmap ,cb <Plug>NERDCommenterAlignBoth
vmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cl <Plug>NERDCommenterAlignLeft
vmap ,cy <Plug>NERDCommenterYank
nmap ,cy <Plug>NERDCommenterYank
vmap ,ci <Plug>NERDCommenterInvert
nmap ,ci <Plug>NERDCommenterInvert
vmap ,cs <Plug>NERDCommenterSexy
nmap ,cs <Plug>NERDCommenterSexy
vmap ,cm <Plug>NERDCommenterMinimal
nmap ,cm <Plug>NERDCommenterMinimal
vmap ,c  <Plug>NERDCommenterToggle
nmap ,c  <Plug>NERDCommenterToggle
vmap ,cc <Plug>NERDCommenterComment
nmap ,cc <Plug>NERDCommenterComment
nmap <silent> ,l <Plug>LookupFile
vmap <silent> ,a( :AlignPush:AlignCtrl lp0P0:'<,'>Align (:AlignPop
vmap <silent> ,a, :AlignPush:AlignCtrl lp0P1:'<,'>Align ,:AlignPop
vmap <silent> ,a= :AlignPush:AlignCtrl lp1P1:'<,'>Align =:AlignPop
nnoremap <silent> ,9 9gt
nnoremap <silent> ,8 8gt
nnoremap <silent> ,7 7gt
nnoremap <silent> ,6 6gt
nnoremap <silent> ,5 5gt
nnoremap <silent> ,4 4gt
nnoremap <silent> ,3 3gt
nnoremap <silent> ,2 2gt
nnoremap <silent> ,1 1gt
nmap <silent> ,p :tabprevious
nmap <silent> ,n :tabnext
nmap ,T :tabedit %:p:h
nmap <silent> ,t :tabnew
nmap ,f 
nmap ,v :vsplit
nmap ,s :split
nmap <silent> ,u :source ~/.vimrc
nmap <silent> ,r :call SwitchToBuf("~/.vimrc")
nmap ,e :e =expand("%:p:h") . "/" 
nmap ,A :qa!
nmap ,a :qa
nmap ,Q :q!
nmap ,q :q
nmap ,W :w!
nmap ,w mz:w'z
nnoremap ,z :%s/\s*$//g:noh''
nnoremap ,m :%s/\r//g
nmap ,k :!clear;sdcv "<cword>"
nmap ,x 
nmap ,d 
vmap ,S y:s/=substitute(escape(@", '\\/.*$^~[]'), '\n', '', 'g')/
vmap ,s y:%s/=substitute(escape(@", '\\/.*$^~[]'), '\n', '', 'g')/
vnoremap < <gv
vnoremap > >gv
nnoremap F gg=G''
nmap K <Plug>ManPageView
map Q gq
xmap S <Plug>VSurround
nmap T :ToggleWord
nnoremap Y y$
vmap [% [%m'gv``
nmap <silent> \ :nohlsearch
nnoremap ][ ]]
nnoremap ]] ][
vmap ]% ]%m'gv``
nnoremap ` '
vmap a% [%v]%
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
nmap gx <Plug>NetrwBrowseX
map gf :tabnew <cfile>
map <silent> mm <Plug>Vm_toggle_sign
vnoremap p :let current_reg = @"gvs=current_reg
nnoremap q? <Nop>
nnoremap q/ <Nop>
nnoremap q: <Nop>
xmap s <Plug>Vsurround
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
nmap | [I:let temp_nr=input("Which line:") | exec "normal " . temp_nr . "[\t"
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
map <S-F9> <Plug>Vm_goto_prev_sign
map <F9> <Plug>Vm_goto_next_sign
map <M-F2> <Plug>Vm_toggle_sign
nmap <silent> <Plug>CalendarH :cal Calendar(1)
nmap <silent> <Plug>CalendarV :cal Calendar(0)
nmap <silent> <Plug>NERDCommenterAppend :call NERDComment(0, "append")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment(0, "toEOL")
vnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment(1, "uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment(0, "uncomment")
vnoremap <silent> <Plug>NERDCommenterNest :call NERDComment(1, "nested")
nnoremap <silent> <Plug>NERDCommenterNest :call NERDComment(0, "nested")
vnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment(1, "alignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment(0, "alignBoth")
vnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment(1, "alignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment(0, "alignLeft")
vmap <silent> <Plug>NERDCommenterYank :call NERDComment(1, "yank")
nmap <silent> <Plug>NERDCommenterYank :call NERDComment(0, "yank")
vnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment(1, "invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment(0, "invert")
vnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment(1, "sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment(0, "sexy")
vnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment(1, "minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment(0, "minimal")
vnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment(1, "toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment(0, "toggle")
vnoremap <silent> <Plug>NERDCommenterComment :call NERDComment(1, "norm")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment(0, "norm")
nmap <F7> :call DiffWithFileFromDisk()
nnoremap <BS> 
nmap <silent> <C-F12> :call EndWordComplete()
nmap <silent> <F12> :call DoWordComplete()
nnoremap <silent> <F2> :TlistToggle
nnoremap <silent> <F3> :NERDTreeToggle .
nmap <silent> <F4> :A
map <silent> <M-F1> :call Togglemenu()
nmap <silent> <Right> :cnext
nmap <silent> <Left> :cprevious
nmap <C-Left> :bp
nmap <C-Right> :bn
vmap <S-Tab> <
nmap <F1> :exec "help ".expand("<cword>")
nmap <Up> gk
nmap <Down> gj
nnoremap <S-Space> 
map <S-Insert> <MiddleMouse>
cnoremap  <Home>
inoremap  <Home>
cnoremap  <End>
inoremap  <End>
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap <silent> 	 =TriggerSnippet()
cmap <silent>  <Plug>CmdlineCompleteForward
cmap <silent>  <Plug>CmdlineCompleteBackward
inoremap <silent> 	 =ShowAvailableSnips()
imap  <Plug>Isurround
inoremap  :set pastemua*:set nopastea
imap  =CtrlXPP()
inoremap " ""i
inoremap < <>i
inoremap > =ClosePair('>')
vmap ë :m'<-2`>my`<mzgv`yo`z
vmap ê :m'>+`<my`>mzgv`yo`z
nmap ë mz:m-2`z
nmap ê mz:m+`z
inoremap [ []i
inoremap ] =ClosePair(']')
inoremap { {}i
inoremap } =ClosePair('}')
iabbr attri attributes
iabbr kath Katherine
iabbr autom automaticaly
iabbr xtime =strftime("%Y-%m-%d %H:%M:%S")
iabbr xdate =strftime("%d/%m/%y %H:%M:%S")
iabbr misc miscellaneous
iabbr scd second
iabbr fst first
iabbr posix POSIX
iabbr l10n Localization
iabbr i18 Internationalization
iabbr partion partition
iabbr envir environment
iabbr toogle toggle
iabbr cosnt const
iabbr serach search
iabbr prot port
iabbr evla eval
iabbr itme item
iabbr sned send
iabbr taht that
iabbr scr src
iabbr teh the
let &cpo=s:cpo_save
unlet s:cpo_save
set autochdir
set autoread
set background=dark
set backspace=indent,eol,start
set balloondelay=800
set balloonexpr=FoldSpellBalloon()
set browsedir=buffer
set cindent
set clipboard=unnamed
set completefunc=b:VimIM
set completeopt=menu
set cscopetag
set cscopeverbose
set diffopt=filler,iwhite
set directory=.,/var/tmp,/tmp
set expandtab
set fileencodings=utf-8,chinese,ucs-bom,taiwan,japan
set fileformats=unix,dos,mac
set fillchars=vert:\ ,stl:\ ,stlnc:\\
set formatoptions=tcqmM
set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
set guioptions=egiLtal
set guitabtooltip=%!InfoGuiTooltip()
set helplang=en
set history=1000
set hlsearch
set ignorecase
set incsearch
set langmenu=en_US.utf-8
set laststatus=2
set lazyredraw
set listchars=tab:>-,eol:$,trail:~
set modelines=20
set mouse=a
set mousefocus
set pastetoggle=<F8>
set path=.,/usr/include,,,/usr/include/c++/4.3,/usr/include/linux
set printoptions=paper:letter
set report=0
set ruler
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set scrolloff=5
set sessionoptions=buffers,folds,globals,options,resize,winpos,tabpages,unix,slash
set shiftwidth=4
set showcmd
set showmatch
set showtabline=2
set smartcase
set softtabstop=4
set statusline=%2*[%-1.3n]%0*\ %F%m%r%h%w\ [FMT=%{&ff}]\ [TYPE=%Y]\ [ENC=%{&fenc}]\ [ASCII=%03.3b]\ [HEX=%02.2B]\ [POS=%04l,%04v]\ [LEN=%L]\ [%p%%]
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set switchbuf=usetab
set tabline=%!ShortTabLine()
set tags=tags;
set termencoding=utf-8
set tildeop
set timeoutlen=2000
set ttimeout
set ttimeoutlen=100
set updatetime=2000
set virtualedit=insert
set visualbell
set whichwrap=b,s,<,>,[,]
set wildignore=*.o,*.out,*.exe,*.dll,*.lib,*.info,*.swp,*.exp,*.
set wildmenu
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
let NERDTreeMapPreviewSplit = "gi"
let NERDTreeMapCloseChildren = "X"
let BASH_Company = "Open Source Corporation"
let NERDTreeShowHidden = "0"
let MRU_Include_Files = ""
let SuperTabDefaultCompletionType = "<c-p>"
let MRU_Add_Menu =  1 
let NERDSpaceDelims = "0"
let LookupFile_ShowFiller =  1 
let SuperTabLongestHighlight =  0 
let NERDTreeMapCloseDir = "x"
let Tlist_Display_Prototype =  0 
let LookupFile_SearchForBufsInTabs =  1 
let Tlist_Show_One_File =  1 
let SuperTabMappingTabLiteral = "<c-tab>"
let NERDUsePlaceHolders = "1"
let NERDTreeShowLineNumbers =  1 
let LookupFile_EnableRemapCmd =  0 
let Tlist_Compact_Format =  0 
let LookupFile_DefaultCmd = ":LUTags"
let LookupFile_AllowNewFiles =  0 
let Tlist_Sort_Type = "name"
let Tlist_Use_Horiz_Window =  0 
let LookupFile_PreserveLastPattern =  0 
let NERDTreeBookmarksFile = "/home/whodare/.NERDTreeBookmarks"
let LookupFile_RecentFileListSize =  20 
let NERDTreeMapToggleHidden = "I"
let NERDTreeWinSize = "31"
let FencCustom = "Examples:\n------------------\niso-8859-n    ISO_8859 variant (n=2 to 15)\n8bit-{name}   any 8-bit encoding (Vim specific name)\ncp{number}    MS-Windows: any installed single-byte codepage\ncp{number}    MS-Windows: any installed double-byte codepage\n2byte-{name}  Unix: any double-byte encoding (Vim specific name)"
let CSApprox_loaded =  1 
let LookupFile_Bufs_SkipUnlisted =  1 
let MRU_Exclude_Files = "^/tmp/.*\\|^/var/tmp/.*"
let Tlist_Ctags_Cmd = "ctags"
let OmniCpp_ShowPrototypeInAbbr =  1 
let Tlist_Enable_Fold_Column =  1 
let NERDRemoveExtraSpaces = "1"
let Tlist_Process_File_Always =  1 
let OmniCpp_MayCompleteScope =  1 
let NERDTreeMapPreview = "go"
let Tlist_Use_SingleClick =  0 
let MRU_Max_Entries =  20 
let NERDTreeNotificationThreshold = "100"
let NERDTreeMapActivateNode = "o"
let LookupFile_DisableDefaultMap =  0 
let LookupFile_LookupAcceptFunc = ""
let NERDTreeWinPos = "left"
let TagList_title = "__Tag_List__"
let LookupFile_OnCursorMovedI =  0 
let LookupFile_PreservePatternHistory =  1 
let LookupFile_LookupNotifyFunc = ""
let OmniCpp_GlobalScopeSearch =  1 
let NERDTreeStatusline = "%{b:NERDTreeRoot.path.strForOS(0)}"
let Tlist_Display_Tag_Scope =  1 
let NERDTreeMapOpenInTabSilent = "T"
let NERDTreeMapHelp = "?"
let NERDTreeMapJumpParent = "p"
let NERDTreeMapToggleFilters = "f"
let SuperTabMappingForward = "<tab>"
let EchoFuncMaxBalloonDeclarations =  20 
let NERDTreeMapJumpLastChild = "J"
let SuperTabContextDefaultCompletionType = "<c-p>"
let SuperTabRetainCompletionType =  1 
let NERDTreeMapJumpPrevSibling = "<C-k>"
let NERDTreeShowBookmarks =  1 
let NERDMenuMode = "3"
let NERDTreeMapOpenExpl = "e"
let NERDDefaultNesting = "1"
let EchoFuncKeyNext = "<M-=>"
let NERDTreeMapOpenInTab = "t"
let NERDTreeRemoveDirCmd = "rm -rf "
let NERDTreeChDirMode = "0"
let OmniCpp_NamespaceSearch =  1 
let LookupFile_TagExpr = "'/home/whodare/mplayer-1.0~rc2/filenametags'"
let Tlist_Highlight_Tag_On_BufEnter =  1 
let Tlist_Auto_Highlight_Tag =  1 
let NERDTreeAutoCenterThreshold = "3"
let NERDTreeShowFiles = "1"
let OmniCpp_ShowScopeInAbbr =  0 
let NERDTreeMapOpenSplit = "i"
let LookupFile_MinPatLength =  3 
let NERDTreeCaseSensitiveSort =  1 
let NERDTreeHijackNetrw = "1"
let NERDTreeMapFilesystemMenu = "m"
let NERDTreeMapRefresh = "r"
let LookupFile_SortMethod = "alpha"
let NERDTreeHighlightCursorline = "1"
let LookupFile_AlwaysAcceptFirst =  1 
let NERDDelimiterRequests = "1"
let Tlist_GainFocus_On_ToggleOpen =  1 
let NERDLPlace = "[>"
let NERDTreeMouseMode = "1"
let Tlist_WinHeight =  10 
let LookupFile_FileFilter = "\\.class$\\|\\.o$\\|\\.obj$\\|\\.exe$\\|\\.jar$\\|\\.zip$\\|\\.rar$\\|\\.ear$"
let NERDCreateDefaultMappings = "1"
let Tlist_Inc_Winwidth =  1 
let Tlist_Auto_Update =  1 
let MRU_File = "/home/whodare/.vim/vimdata/vim_mru_files"
let Tlist_WinWidth =  30 
let OmniCpp_MayCompleteArrow =  1 
let NERDTreeMapPreviewVSplit = "gs"
let NERDChristmasTree = "1"
let NERDShutUp = "0"
let NERDTreeMapUpdir = "u"
let NERDTreeMapJumpRoot = "P"
let NERDCommentWholeLinesInVMode = "0"
let BASH_Email = "adaptee@gmail.com"
let BufExplorer_title = "[Buf List]"
let NERDTreeMapChdir = "cd"
let LookupFile_LookupFunc = ""
let NERDRPlace = "<]"
let Tlist_Exit_OnlyWindow =  0 
let NERDTreeMapExecute = "!"
let LookupFile_Bufs_LikeBufCmd =  1 
let OmniCpp_DisplayMode =  1 
let NERDTreeMapRefreshRoot = "R"
let MRU_Window_Height =  8 
let Tlist_Max_Tag_Length =  10 
let NERDRemoveAltComs = "1"
let NERDTreeAutoCenter = "1"
let OmniCpp_ShowAccess =  1 
let Tlist_Close_On_Select =  0 
let NERDTreeMapOpenVSplit = "s"
let LookupFile_UsingSpecializedTags =  0 
let LookupFile_EscCancelsPopup =  1 
let EchoFuncKeyPrev = "<M-->"
let LookupFile_UpdateTime =  300 
let NERDTreeMapDeleteBookmark = "D"
let BASH_AuthorName = "adaptee"
let MRU_Auto_Close =  1 
let NERDBlockComIgnoreEmpty = "0"
let LookupFile_Bufs_BufListExpr = ""
let NERDTreeMapJumpNextSibling = "<C-j>"
let Tlist_File_Fold_Auto_Close =  1 
let Tlist_Auto_Open =  0 
let LookupFile_TagsExpandCamelCase =  1 
let NERDTreeCopyCmd = "cp -r "
let BASH_Version = "2.10"
let NERDTreeMapQuit = "q"
let NERDTreeMapChangeRoot = "C"
let NERDCompactSexyComs = "0"
let MRU_Use_Current_Window =  0 
let NERDTreeSortDirs = "1"
let NERDTreeMapToggleFiles = "F"
let NERDAllowAnyVisualDelims = "1"
let OmniCpp_MayCompleteDot =  1 
let SuperTabMidWordCompletion =  1 
let Tlist_Max_Submenu_Items =  20 
let BASH_Dictionary_File = "/home/whodare/.vim/bash-support/wordlists/bash.list"
let NERDTreeMapJumpFirstChild = "K"
let NERDTreeMapOpenRecursively = "O"
let NERDTreeMapToggleBookmarks = "B"
let SuperTabMappingBackward = "<s-tab>"
let NERDTreeMapUpdirKeepOpen = "U"
let NERDTreeQuitOnOpen = "0"
let Tlist_Show_Menu =  0 
let Tlist_Use_Right_Window =  0 
silent only
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
silent! argdel *
set lines=24 columns=80
winpos 0 26
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
