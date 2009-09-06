"------------------------------------------------------------------------------------------------------
" A.vim( switch quickly between .cpp and .h )
"------------------------------------------------------------------------------------------------------
"
nnoremap <silent><F4> :A<CR>

"------------------------------------------------------------------------------------------------------
" AlignPlugin.vim( align sentences with specified separator)
"------------------------------------------------------------------------------------------------------
vmap <silent> <Leader>a= <ESC>:AlignPush<CR>:AlignCtrl lp1P1<CR>:'<,'>Align =<CR>:AlignPop<CR>
vmap <silent> <Leader>a, <ESC>:AlignPush<CR>:AlignCtrl lp0P1<CR>:'<,'>Align ,<CR>:AlignPop<CR>
vmap <silent> <Leader>a( <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align (<CR>:AlignPop<CR>
vmap <silent> <Leader>a) <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align )<CR>:AlignPop<CR>
vmap <silent> <Leader>a* <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align *<CR>:AlignPop<CR>
vmap <silent> <Leader>a' <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align '<CR>:AlignPop<CR>
vmap <silent> <Leader>a" <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align "<CR>:AlignPop<CR>
vmap <silent> <Leader>a/ <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align //<CR>:AlignPop<CR>

"------------------------------------------------------------------------------------------------------
" bash-support.vim( BASH IDE -- Write and run BASH-scripts using menus and hotkeys. )
"------------------------------------------------------------------------------------------------------
let g:BASH_AuthorName = 'adaptee'
let g:BASH_Email      = 'adaptee@gmail.com'
let g:BASH_Company    = 'Open Source Corporation'

"------------------------------------------------------------------------------------------------------
" bufexplorer.vim( Buffer Explorer / Browser )
"------------------------------------------------------------------------------------------------------
nnoremap <Leader>u :BufExplorer<CR>
"nnoremap <Leader>u :HSBufExplorer<CR>
"nnoremap <Leader>u :HSBufExplorer<CR>
"
" use <ENTER> to open specified buffer in current window
" use <Shift-Enter> to open specified buffer in new tab

"------------------------------------------------------------------------------------------------------
" camelcasemotion.vim(move cursor , using camel style word as unit)
"------------------------------------------------------------------------------------------------------
" usage :   <Leader>w
"           <Leader>e
"           <Leader>b

"------------------------------------------------------------------------------------------------------
" code_complete.vim( prompt function prototype in the fly)
"------------------------------------------------------------------------------------------------------
"the defaut hotkey <tab> will make plugin supertab does not work.
"let g:completekey = "<tab>"   "hotkey

"below are some candicate hotkeys.
let g:completekey = "<Leader><tab>"
"let g:completekey = "<F8>"


"------------------------------------------------------------------------------------------------------
" csapprox.vim( simulate gvim-only colorschemes work transparently in terminal mode )
"------------------------------------------------------------------------------------------------------
" suprres the warning messages outputed when vim is compile without 'gui' support.
let CSApprox_verbose_level=0

"------------------------------------------------------------------------------------------------------
" cmdline-complete.vim( press Ctrl-P or Ctrl-N to complete the word within command-line )
"------------------------------------------------------------------------------------------------------

"------------------------------------------------------------------------------------------------------
" crefvim.vim( a C-reference manual especially designed for Vim  )
"------------------------------------------------------------------------------------------------------
" nmap <Leader>cw <Plug>CRV_CRefVimAsk    ---- interactive
" nmap <Leader>cr <Plug>CRV_CRefVimNormal ---- query current word
" vmap <Leader>cr <Plug>CRV_CRefVimVisual ---- query selected word

"------------------------------------------------------------------------------------------------------
" cscope_macros.vim( basic cscope settings and key mappings)
"------------------------------------------------------------------------------------------------------
" Use <C-C>s to query current word

"------------------------------------------------------------------------------------------------------
" echofunc.vim( Echo the function declaration in the command line for C/C++ )
"------------------------------------------------------------------------------------------------------

"------------------------------------------------------------------------------------------------------
" fencview.vim( Autodetect multiple encodings )
"------------------------------------------------------------------------------------------------------
"Always detect the encoding automaticlly
"However, this require iconv feature is enabled and iconv.dll available in $PATH
"if has("iconv")
    "autocmd BufReadPost * :FencAutoDetect
"endif

"------------------------------------------------------------------------------------------------------
" genutils.vim ( Useful buffer, file and window related functions, mainly used  by other plugins.
"------------------------------------------------------------------------------------------------------

"------------------------------------------------------------------------------------------------------
" grep.vim ( integration with external tools: grep, egrep, fgrep, find, xargs.)
"------------------------------------------------------------------------------------------------------

nnoremap <F5> :Grep<Space>
nnoremap <S-F5> :Rgrep<Space>
nnoremap <C-F5> :Bgrep<Space>

" set the location of grep
"let Grep_Path = 'd:\tools\grep.exe'

" set the default grep options
"let Grep_Default_Options = '-i'

"disable opening the quickfix window by default
let Grep_OpenQuickfixWindow = 0

" set which folders should always be skipped
let Grep_Skip_Dirs = '.svn .git'

" set which files should always be skipped
let Grep_Skip_Files = '*.bak *.o *.obj *.pdb *.exe *.dll'

" should be set when using the find provided by cygwin
"let Grep_Cygwin_Find = 1

"------------------------------------------------------------------------------------------------------
" lookupfile.vim ( locate file by various means, and providing auto-completion feature )
"------------------------------------------------------------------------------------------------------
" orverrid the default mapping of <F5>
nmap <silent> <leader>l <Plug>LookupFile<cr>

let g:LookupFile_TagExpr                = string('/home/whodare/mplayer-1.0~rc2/filenametags')
let g:LookupFile_EnableRemapCmd         = 0 " Always map to the same command
let g:LookupFile_MinPatLength           = 3 " completion is trigger only after you input at least 3 chars
let g:LookupFile_PreserveLastPattern    = 0 " clear last pattern when invoked again
let g:LookupFile_PreservePatternHistory = 1 " save seaching history
let g:LookupFile_AlwaysAcceptFirst      = 1 " <CR> will open the first matched item
let g:LookupFile_AllowNewFiles          = 0 " Read-only;Never create new files
let g:LookupFile_SearchForBufsInTabs    = 1

" ignore binary files
let g:LookupFile_FileFilter             = '\.class$\|\.o$\|\.obj$\|\.exe$\|\.jar$\|\.zip$\|\.rar$\|\.ear$'


"------------------------------------------------------------------------------------------------------
" LargeFile.vim ( automatically disable some vim feature when opening large files) "------------------------------------------------------------------------------------------------------

" file bigger than 50MB will be seen as large file.
let g:LargeFild = 50

"------------------------------------------------------------------------------------------------------
" manpaveviewPlugin.vim ( Viewer for manpages, gnu info, perldoc, and php)
"------------------------------------------------------------------------------------------------------
" you can use the universal interface 'K' to view various documents.


"------------------------------------------------------------------------------------------------------
" mark.vim ( highlight several words in different colors simultaneously )
"------------------------------------------------------------------------------------------------------
" <Leader>j   highlight current word


"------------------------------------------------------------------------------------------------------
" matrix.vim ( Matrix screen-saver for VIM)
"------------------------------------------------------------------------------------------------------
" Use command ':Matrix'

"-------------------------------------------------------------------------------------------------------
" mru.vim ( show most-recent-used files )
"------------------------------------------------------------------------------------------------------
nnoremap <Leader>r :MRU<CR>
if has('unix')
    let MRU_File = $HOME.'/.vim_mru'
elseif has ('win32')
    let MRU_File = $VIM.'/_vim_mru'
endif
let MRU_Max_Entries = 80
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix

"------------------------------------------------------------------------------------------------------
" NERD_commenter.vim ( A plugin that allows for easy commenting of code for many filetypes. )
"------------------------------------------------------------------------------------------------------

"------------------------------------------------------------------------------------------------------
" NERD_Tree.vim( A tree explorer plugin for navigating the file-system)
"------------------------------------------------------------------------------------------------------
" use <F3> to start NERD_Tree; using current file's location as root node
nnoremap <silent> <F3> :NERDTreeToggle .<CR>

let NERDTreeCaseSensitiveSort = 1           " make name case-sensitive
let NERDTreeIgnore            = ['\~$']     " innore auto-backup file
let NERDTreeShowBookmarks     = 1           " set showing bookmark as default behaviror
let NERDTreeShowLineNumbers   = 1           " show number as prefix
let NERDTreeIgnore            = ['\.swp$', '\~$','\.vcproj$','\.ncb$','\.sln$','\.suo$']

"------------------------------------------------------------------------------------------------------
" omniCPPComplete.vim
"------------------------------------------------------------------------------------------------------
" generate ctags for current folder:
map <F7> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>

" No annoying preview window!
set completeopt=menu

" auto close options when exiting insert mode
autocmd InsertLeave  * if pumvisible() == 0|pclose|endif
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

let OmniCpp_GlobalScopeSearch   = 1  " 0 or 1
let OmniCpp_NamespaceSearch     = 2  "search namespaces in this and included files
let OmniCpp_DisplayMode         = 1
let OmniCpp_SelectFirstItem     = 2  "select first item (but don't insert)
let OmniCpp_ShowScopeInAbbr     = 0
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess          = 1
let OmniCpp_MayCompleteDot      = 1
let OmniCpp_MayCompleteArrow    = 1
let OmniCpp_MayCompleteScope    = 1

"------------------------------------------------------------------------------------------------------
" qfixtoggle.vim( toggle the quickfix window)
"------------------------------------------------------------------------------------------------------
nmap <F6> :QFix<CR>

"------------------------------------------------------------------------------------------------------
" snipmate.vim ( TextMate-style snippets for Vim )
"------------------------------------------------------------------------------------------------------
" Note, I did extensive customization to the default bundles.DO NOT UPDATE EAGERLY!!

"------------------------------------------------------------------------------------------------------
" supertab.vim ( Do all your insert-mode completion with Tab )
"------------------------------------------------------------------------------------------------------

"------------------------------------------------------------------------------------------------------
" surround.vim ( Delete/change/add parentheses/quotes/XML-tags/much more with ease )
"------------------------------------------------------------------------------------------------------
" cs   change surrounding symbol
" ds   delete surrounding symbol
" ys   create surrounding symbol
" vmap s ---- create surrounding symbol for selected text

"------------------------------------------------------------------------------------------------------
" switch.vim ( switch boolean options easily)
"------------------------------------------------------------------------------------------------------
" usage: prese <C-Q>, then press F1 or TAB

"------------------------------------------------------------------------------------------------------
" Taglist.vim ( Source code browser for C/C++, java, perl, python, tcl, sql, php, etc )
"------------------------------------------------------------------------------------------------------
" open taglist;
nnoremap <silent> <F2> :TlistToggle<CR>
set updatetime=2000    " update showing every 2 seconds. May cause problem.

let Tlist_Sort_Type               = "name"  " sort tags by name, not appearing order
let Tlist_GainFocus_On_ToggleOpen = 1       " when opening taglist window, switch the focus to it
let Tlist_Process_File_Always     = 1       " keep processing even when taglist window is closed.
let Tlist_File_Fold_Auto_Close    = 1       " automatically close folding for in-active files
let Tlist_Show_One_File           = 1       " only show current file's tags
"let Tlist_Auto_Open              = 1       " open taglist on vim start-up
"autocmd FileType taglist map <buffer> <Leader>t t

"------------------------------------------------------------------------------------------------------
" ToggleWord.vim ( oggle words like:'true'=>'false', 'True'=>'False' etc )
"------------------------------------------------------------------------------------------------------
"toggle "true" to "false", "left right"
nmap T :ToggleWord<CR>

"------------------------------------------------------------------------------------------------------
" vimim.vim ( Chinese input method embedded within VIM )
"------------------------------------------------------------------------------------------------------
"In insert mode, press C-\ to switch input method on/off
let g:vimim_enable_smart_space  = 1
let g:vimim_enable_dynamic_menu = 1
let g:vimim_enable_fuzzy_search = 1
let g:vimim_enable_fuzzy_pinyin = 1
let g:vimim_enable_menu_label   = 1

"------------------------------------------------------------------------------------------------------
" visualmark.vim ( Visual mark, similar to UltraEdit's bookmark )
"------------------------------------------------------------------------------------------------------


"------------------------------------------------------------------------------------------------------
" vimballPlugin.vim ( vim-based archiver: builds, extracts, and preview )
"------------------------------------------------------------------------------------------------------
" Just run ':so %'

"------------------------------------------------------------------------------------------------------
" word_complete.vim ( automatically offers word completion as you type )
"------------------------------------------------------------------------------------------------------
" enable/disable word-complete
nmap <silent><F12> :call DoWordComplete()<CR>
nmap <silent><C-F12> :call EndWordComplete()<CR>

"------------------------------------------------------------------------------------------------------
" Zoomwin.vim ( Zoom in/out of windows)
"------------------------------------------------------------------------------------------------------
"Press <C-w>o :         zoom current window into full screen
"Press <C-w>o again:    restore window to previous state
