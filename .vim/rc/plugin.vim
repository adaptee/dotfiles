"------------------------------------------------------------------------------------------------------
" plugins----A.vim
"------------------------------------------------------------------------------------------------------
"quick switching between .cpp and .h
nmap <silent><F4> :A<CR>

"------------------------------------------------------------------------------------------------------
" plugins----AlignPlugin.vim
"------------------------------------------------------------------------------------------------------
vmap <silent> <Leader>a= <ESC>:AlignPush<CR>:AlignCtrl lp1P1<CR>:'<,'>Align =<CR>:AlignPop<CR>
vmap <silent> <Leader>a, <ESC>:AlignPush<CR>:AlignCtrl lp0P1<CR>:'<,'>Align,<CR>:AlignPop<CR>
vmap <silent> <Leader>a( <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align (<CR>:AlignPop<CR>

"------------------------------------------------------------------------------------------------------
" plugins----bash-support.vim
"------------------------------------------------------------------------------------------------------
let g:BASH_AuthorName = 'adaptee'
let g:BASH_Email      = 'adaptee@gmail.com'
let g:BASH_Company    = 'Open Source Corporation'

"------------------------------------------------------------------------------------------------------
" plugins----bufexplorer.vim
"------------------------------------------------------------------------------------------------------
nnoremap <Leader>g :BufExplorer<CR>

"------------------------------------------------------------------------------------------------------
" plugins----FavMenu.vim
"------------------------------------------------------------------------------------------------------
"let $FAVOURITES=$HOME.'/.vim_favourites'

"------------------------------------------------------------------------------------------------------
" plugins----fencview.vim
"------------------------------------------------------------------------------------------------------
"Always detect the encoding automaticlly
"autocmd BufReadPost * :FencAutoDetect

"------------------------------------------------------------------------------------------------------
" plugins----lookupfile.vim
"------------------------------------------------------------------------------------------------------
" orverrid the default mapping of <F5>
nmap <silent> <leader>l <Plug>LookupFile<cr>

let g:LookupFile_TagExpr                = string('/home/whodare/mplayer-1.0~rc2/filenametags')
let g:LookupFile_EnableRemapCmd         = 0 " Always map to the same command
let g:LookupFile_MinPatLength           = 3 " completion is trigger after you input at least 3 chars
let g:LookupFile_PreserveLastPattern    = 0 " clear last pattern when invoked again
let g:LookupFile_PreservePatternHistory = 1 " save seaching history
let g:LookupFile_AlwaysAcceptFirst      = 1 " <CR> will open the first matched item
let g:LookupFile_AllowNewFiles          = 0 " Read-only;Never create new files
let g:LookupFile_SearchForBufsInTabs    = 1
" ignore binary files
let g:LookupFile_FileFilter             = '\.class$\|\.o$\|\.obj$\|\.exe$\|\.jar$\|\.zip$\|\.rar$\|\.ear$'

"-------------------------------------------------------------------------------------------------------
" plugins----mru.vim
"------------------------------------------------------------------------------------------------------
if has('unix')
    let MRU_File = $HOME.'/.vim_mru'
elseif has ('win32')
    let MRU_File = $VIM.'/_vim_mru'
endif
let MRU_Max_Entries = 40
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
nnoremap <Leader>u :MRU<CR>

"------------------------------------------------------------------------------------------------------
" plugins----NERD_Tree.vim
"------------------------------------------------------------------------------------------------------
" use <F3> to start NERD_Tree; using current file's location as root node
nnoremap <silent> <F3> :NERDTreeToggle .<CR>
inoremap <silent> <F3> <C-O>:NERDTreeToggle %:p:h<CR><Esc>

let NERDTreeCaseSensitiveSort = 1           " make name case-sensitive
let NERDTreeIgnore            = ['\~$']     " innore auto-backup file
let NERDTreeShowBookmarks     = 1           " set showing bookmark as default behaviror
let NERDTreeShowLineNumbers   = 1           " show number as prefix
let NERDTreeIgnore            = ['\.swp$', '\~$','\.vcproj$','\.ncb$','\.sln$','\.suo$']

"------------------------------------------------------------------------------------------------------
" plugins----omniCPPComplete.vim
"------------------------------------------------------------------------------------------------------

" No annoying preview window!
set completeopt=menu

let OmniCpp_GlobalScopeSearch   = 1  " 0 or 1
let OmniCpp_NamespaceSearch     = 1   " 0, 1 or 2
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 0
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess          = 1
let OmniCpp_MayCompleteDot      = 1
let OmniCpp_MayCompleteArrow    = 1
let OmniCpp_MayCompleteScope    = 1

"------------------------------------------------------------------------------------------------------
" plugins----Taglist.vim
"------------------------------------------------------------------------------------------------------
" open taglist;
nnoremap <silent> <F2> :TlistToggle<CR>
inoremap <silent> <F2> <C-O>:TlistToggle<CR><Esc>
set updatetime=2000    " update showing every 2 seconds. May cause problem.

let Tlist_Sort_Type               = "name"  " sort tags by name, not appearing order
let Tlist_GainFocus_On_ToggleOpen = 1       " when opening taglist window, switch the focus to it
let Tlist_Process_File_Always     = 1       " keep processing even when taglist window is closed.
let Tlist_File_Fold_Auto_Close    = 1       " automaticlly close folding for in-active files
let Tlist_Show_One_File           = 1       " only show current file's tags
"let Tlist_Auto_Open              = 1       " open taglist on vim start-up
"autocmd FileType taglist map <buffer> <Leader>t t

"------------------------------------------------------------------------------------------------------
" plugins----ToggleWord.vim
"------------------------------------------------------------------------------------------------------
"toggle "true" to "false", "left right"
nmap T :ToggleWord<CR>

"------------------------------------------------------------------------------------------------------
" plugins----vimim.vim
"------------------------------------------------------------------------------------------------------
"In insert mode, input pinyin for the word, and presss C-x C-u"
"Or press C-\ to switch input method on/off"
let g:vimim_enable_smart_space  = 1
let g:vimim_enable_dynamic_menu = 1
let g:vimim_enable_fuzzy_search = 1
let g:vimim_enable_fuzzy_pinyin = 1
let g:vimim_enable_menu_label   = 1

"------------------------------------------------------------------------------------------------------
" plugins----word_complete.vim
"------------------------------------------------------------------------------------------------------
" enable/disbale word-complete
nmap <silent><F12> :call DoWordComplete()<CR>
nmap <silent><C-F12> :call EndWordComplete()<CR>


"------------------------------------------------------------------------------------------------------
" plugins----Zoomwin.vim
"------------------------------------------------------------------------------------------------------
"Press <C-w>o :         the current window zooms into a full screen
"Press <C-w>o again:    the previous set of windows is restored
