"------------------------------------------------------------------------------------------------------
" general
"------------------------------------------------------------------------------------------------------
"disable vi-compatible mode
set nocompatible

"now <Leader> means ','
let g:mapleader =","

"cmdline history limitation
set history=1000

"enable spell checking feature;English default;limit the suggestion as 5
"set spell
"set spelllang=en
"set spellsuggest=5

" none of these should be word dividers
"set isk+=$,%,#

" Time to wait for a key mapping (default value causes an annoying delay)
set timeout
set timeoutlen=2000

" Time to wait for key codes
set ttimeout
set ttimeoutlen=100

"enable mouse support anywhere(even in console mdoe)
set mouse=a

"make the window where mouse pointer on become current ; enumerate X-window style
set mousefocus

"make '~' a full-featured operator, such as 'd','c',which can be combined with motion and text-object
set tildeop

" behaves well under both linux/windows/mac
set ffs=unix,dos,mac

"enable modeline feature;check the first and last 20 lines of files for vim-related setting
set modeline
set modelines=20

"make Backspace behave as expected anywhere and any time
set backspace=indent,eol,start

"Enable "filetype" "plugin" "indent"
filetype on                 " run $VIMRUNTIME/filetype.vim and $VIMRUNTIME/scripts.vim(conditionl)
filetype plugin on          " run $VIMRUNTIME/fyplugin.vim
filetype indent on          " run $VIMRUNTIME/indent.vim

"-----------------------------------------------------------------------------------------------------
" colors
"------------------------------------------------------------------------------------------------------

"enable syntax highlighting
syntax on

"the terminal support 256 colors
set t_Co=256

"choose color scheme
colo darkZ
"colo torte
"colo desert

"------------------------------------------------------------------------------------------------------
" visual cues
"------------------------------------------------------------------------------------------------------

"show line-number
set number

"highlight current line
set cursorline

"show TAB as '>-------',NEWLINE as '$', trailing whitespace as '~' when executing ":set list"
set listchars=tab:>-,eol:$,trail:~

"use advanced commandline auto-completion feature
set wildmenu

"files to be ingored in wildmenu
set wildignore=*.o,*.out,*.exe,*.dll,*.lib,*.info,*.swp,*.exp,*.

"set wildmode=list:full

"always show status line
set laststatus=2

"customize the statusline
set statusline=%2*[%-1.3n]%0*\ %F%m%r%h%w\ [FMT=%{&ff}]\ [TYPE=%Y]\ [ENC=%{&fenc}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [LEN=%L]\ [%p%%]

"show normal-mode command in the end of last line.
set showcmd

"Show matching brackets in insert mode
set showmatch

"no noisy beeping, just flipping the window
set visualbell

"do not redraw while executing macros (which will be much faster)
set lazyredraw

"keep cursor stay away from the first and last 5 lines of the screen
set scrolloff=5

" alway infor us whenever anything is changed via Ex command;default threashhold value is 2
set report=0

" differ options
set diffopt=filler,iwhite

"------------------------------------------------------------------------------------------------------
" encodings & language
"------------------------------------------------------------------------------------------------------

" use utf-8 as VIM's internal encoding scheme
set encoding=utf-8

" Make VIM understand following  kinds of encoding for external files.
set fileencodings=utf-8,chinese,ucs-bom,taiwan,japan

" language used for showing menu items.
set langmenu=en_US.utf-8
"set langmenu=zh_CN.utf-8

" language used for showing prompt message.
language messages en_US.utf-8
"language messages zh_CN.utf-8

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

autocmd EncodingChanged * if &encoding == "utf-8" | nmap <M-Space> :simalt ~<CR> | so $VIMRUNTIME/delmenu.vim | so $VIMRUNTIME/menu.vim | language message zh_CN.UTF-8 | endif

autocmd EncodingChanged * if &encoding == "cp936" | nmap <M-Space> :simalt ~<CR> | so $VIMRUNTIME/delmenu.vim | so $VIMRUNTIME/menu.vim | language message zh_CN | endif

" show amigurous character in two column width
if ( has('multi_byte') && v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)' )
    set ambiwidth=double
endif

"------------------------------------------------------------------------------------------------------
" search & replace
"------------------------------------------------------------------------------------------------------

"highlight searching result
set hlsearch

"show real-time search result when typing the pattern
set incsearch

"enable wrapping around when searching
set wrapscan

"ignore case when searching
set ignorecase

"resume case-sensitive if the pattern contain upper-case letter
set smartcase

"hello world"

" toggle search highlighting; now the unused key '\' finally can do something now....
nmap <silent> \      :nohlsearch<CR>

"search visually-selected text
"vmap <silent> * y/<C-R>=substitute(escape(@", '\\/.*$^~[]'), '\n', '\\n', 'g')<CR><CR>
"vmap <silent> # y?<C-R>=substitute(escape(@", '\\/.*$^~[]'), '\n', '\\n', 'g')<CR><CR>
vmap  * :call VisualSearch('f')<CR>
vmap  # :call VisualSearch('b')<CR>

"Since SPACE is not used under visual mode, Let's make good use of it!
"Search visual-selected text and put the matching lines in a new tab
vnoremap <SPACE> "*y<Esc>mzqqq:silent<SPACE>g/<C-R>*/y<SPACE>Q<CR>'z:tabnew<CR>"Qpdgg

"Make good use of <BAR>:search lines containing current word------A simple grep!
nmap <BAR> [I:let temp_nr=input("Which line:") <BAR> exec "normal " . temp_nr . "[\t"<CR>

"Substitute visually-selcted text, interactively and globally
vmap <Leader>s y:%s/<C-R>=substitute(escape(@", '\\/.*$^~[]'), '\n', '', 'g')<CR>/
vmap <Leader>S y:s/<C-R>=substitute(escape(@", '\\/.*$^~[]'), '\n', '', 'g')<CR>/
"Note: the 'g' in substitute() means gloabl for substitute(), not for command 's'

" Make p in Visual mode to replace the selected text with the contents of "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" disable annoying window
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

"------------------------------------------------------------------------------------------------------
" cut & copy & paste
"------------------------------------------------------------------------------------------------------

"use OS clipboard as unnamed register; for win32,this option solves both copy/paste
set clipboard=unnamed

"super paste; now in insert mode, you can use <C-v> to do pasting
inoremap <C-v> <ESC>:set paste<CR>mua<C-R>*<ESC>:set nopaste<CR>a

" switch the paste option on/off
set pastetoggle=<F8>

"Y's default unctionality is duplicated with 'yy' and conter-intuitive; Let's correct it
"Now 'C','D','Y' work the same way: from current position to the end of line
nnoremap Y y$

"auto-indent after pasting
"nnoremap <ECS>p p'[v']=
"nnoremap <ECS>P P'[v']=


""------------------------------------------------------------------------------------------------------
" moving around
"------------------------------------------------------------------------------------------------------

"Allow virtual editing in Insert mode.
set virtualedit=insert

" press <C-H>H and <C-L> to first and last character of line
nnoremap <C-H> ^
nnoremap <C-L> $

" move faster
nnoremap <C-J> 3j
vnoremap <C-J> 3j
nnoremap <C-k> 3k
vnoremap <C-k> 3k

nnoremap <SPACE> <C-F>
nnoremap <S-SPACE> <C-B>

"echance the function of '%' and '#'
source $VIMRUNTIME/macros/matchit.vim

"speed up the viewer scrolling 3 times
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"swap  ' and `, since ` is more useful
nnoremap ' `
nnoremap ` '

" swap ]] and ][
" now the rule is simple and instinct: first letter for direction,second letter for type: open or close?
nnoremap ]] ][
nnoremap ][ ]]

"map UP/DOWN to move one visual line ,not one physical line
nmap <DOWN> gj
imap <DOWN> <ESC>gja
nmap <UP> gk
imap <UP> <ESC>gka

"make tag jumping more easy"
nmap <Leader>d <ESC><C-]>
nmap <Leader>x <ESC><C-T>

"under insert mode, move cursor to beginning/end quickly
inoremap <C-A>   <Home>
inoremap <C-E>   <End>

"make cmdline operation more bash-style
cnoremap <C-A>  <Home>
cnoremap <C-E>  <End>

"Move current line of text up and down(crossing other text)
nmap <A-j> mz:m+<CR>`z
nmap <A-k> mz:m-2<CR>`z

"Move visually-selected text up and down(crossing other text)
vmap <A-j> :m'>+<CR>`<my`>mzgv`yo`z
vmap <A-k> :m'<-2<CR>`>my`<mzgv`yo`z

"------------------------------------------------------------------------------------------------------
" help & manpage
"------------------------------------------------------------------------------------------------------

"invoke help system more smart
nmap <F1> <ESC>:exec "help ".expand("<cword>")<CR>
imap <F1> <ESC>:exec "help ".expand("<cword>")<CR>

""make help system more like Web pages
autocmd FileType help call ActLikeWeb()
function! ActLikeWeb()
    nmap <buffer> <CR> <C-]>
    nmap <buffer> <BS> <C-T>
    nmap <buffer> o /''[a-z]\{2,\}''<CR>
    nmap <buffer> O ?''[a-z]\{2,\}''<CR>
    nmap <buffer> s /\|\S\+\|<CR>
    nmap <buffer> S ?\|\S\+\|<CR>
endfunction

"improve the user-experince of man pages;press "\K",instead of "K"
source $VIMRUNTIME/ftplugin/man.vim

"Now 'K' invokes external cmd 'manall' ,which will man all iterm with the same name
if has("unix")
    "set keywordprg=manall
    "set keywordprg=myman
endif

"re-generte tags for help docs on every start-up"
if has('unix')
    helptags ~/.vim/doc
elseif has('win32')
    helptags $VIM/vimfiles/doc
endif

"lookup current word in the dictionary
nmap <Leader>k :!clear;sdcv "<cword>"<CR>

"------------------------------------------------------------------------------------------------------
" text formatting/layout
"------------------------------------------------------------------------------------------------------
set tabstop=8
set shiftwidth=4
set expandtab
set softtabstop=4
"set smarttab

"set the length limitation of physical line; 0 mean unlimited
set textwidth=0

"show long line in auto-wrapping style----visually multiline, but physically still one line
set wrap

"make these operator multi-linable
set whichwrap=b,s,<,>,[,]

"make the wrapping more ingelegent----DO NOT break up a word!
set linebreak

"set the space between two successive lines; effective only under gVIM
set linespace=0

"choose C-style indentation
set cindent

" Now vim can reformat multibyte text (e.g. Chinese)
set formatoptions+=mM

" do not use Ex-mode, use Q for formatting
map Q gq

" autoformat the whole file
nnoremap <S-F> gg=G''

"make delelting annoying windows ^M more easy
nnoremap <Leader>m :%s/\r//g<CR>

"remove white space on empty line(which has no visuable character)
nnoremap <Leader>z :%s/\s*$//g<CR>:noh<CR>''

"after indentation adjustment, re-select previously highlighted text
vnoremap > >gv
vnoremap < <gv

"use TAB to do indentation
vmap <Tab>   >
vmap <S-Tab> <

"------------------------------------------------------------------------------------------------------
" folding
"------------------------------------------------------------------------------------------------------

"Enable folding
set foldenable

"folding sigature occupies 2 column on the left side
set foldcolumn=2

"set foldcolumn's color scheme
autocmd BufEnter * :highlight FoldColumn guibg=black guifg=white

"create folding based on indentation
set foldmethod=indent

"folds whose level is greater than 'foldlevel' are closed automatically
set foldlevel=10         "when started, unzip(fold) all!

"make fold opening/closing purely automaticlly
"set foldopen=all
"set foldclose=all

"use space to open/close fold
"nnoremap <SPACE> za

"------------------------------------------------------------------------------------------------------
" buffer & file
"------------------------------------------------------------------------------------------------------

"when switching buffer, also condider other tab
set switchbuf=usetab

"when detecting file is modified outside of Vim,reload the file automatically
set autoread

"do not create backup when editing
set nobackup
"but for the sake of acciendent....
set writebackup

"set where .swp file is putted
set directory=.,/var/tmp,/tmp

" use directory df the related buffer as the start-point for file browser
set browsedir=buffer

" automaticaly change $cwd to where the file is located
set autochdir

"use Ctrl+Left/Right arrow to cycle the buffer list
nmap <C-right>    <ESC>:bn<CR>
nmap <C-left>     <ESC>:bp<CR>

"make writing and quiting more easy
nmap <Leader>w mz:w<CR>'z
nmap <Leader>W :w!<CR>
nmap <Leader>q :q<CR>
nmap <Leader>Q :q!<CR>
nmap <Leader>a :qa<CR>
nmap <Leader>A :qa!<CR>

if has("unix")
    nmap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    nmap <Leader>e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif

" allows us to write to files even when we forget to use sudo to launch vim
command! -bar -nargs=0 Sudow :silent exe "w !sudo tee % > /dev/null" | silent edit!

" edit & load vimrc quickly
if has('unix')
    "Fast reading of .vimrc
    nmap <silent> <leader>r :call SwitchToBuf("$HOME/.vimrc")<CR>
    "Fast loading of the .vimrc
    nmap <silent> <leader>u :source $HOME/.vimrc<CR>
    "When .vimrc is edited and saved, reload it automaticaly
    autocmd! bufwritepost .vimrc source $HOME/.vimrc
elseif has('win32')
    "Fast reading of _vimrc
    nmap <silent> <leader>r :call SwitchToBuf("$VIM/_vimrc")<CR>
    "Fast loading of the _vimrc
    nmap <silent> <leader>u :source $VIM/_vimrc<CR>
    "When _vimrc is edited and saved, reload it automaticaly
    autocmd! bufwritepost _vimrc source $VIM/_vimrc
endif

"------------------------------------------------------------------------------------------------------
" window
"------------------------------------------------------------------------------------------------------

"make window manipulating more easy
nmap <Leader>s :split<CR><C-W><C-W>
nmap <Leader>v :vsplit<CR><C-W><C-w>
nmap <Leader>f <C-w><C-w>

" smart way to switch between windows
"nmap <C-j> <C-W>j
"nmap <C-k> <C-W>k
"nmap <C-h> <C-W>h
"nmap <C-l> <C-W>l

" make splitters between windows be blank,with no boring dashes
set fillchars=vert:\ ,stl:\ ,stlnc:\

"------------------------------------------------------------------------------------------------------
" tab-page
"------------------------------------------------------------------------------------------------------

"always show tabline, even when only one tab is opened
set showtabline=2

"make tabline(tab pager) compact and more distinguishing
set tabline=%!ShortTabLine()

"make tab operation more easy
nmap <silent> <Leader>t :tabnew<CR>
nmap <Leader>T :tabedit %:p:h<CR>
nmap <silent> <Leader>n :tabnext<CR>
nmap <silent> <Leader>p :tabprevious<CR>

"Switch to tab<N>
nnoremap <silent><leader>1 1gt<ESC>
nnoremap <silent><leader>2 2gt<ESC>
nnoremap <silent><leader>3 3gt<ESC>
nnoremap <silent><leader>4 4gt<ESC>
nnoremap <silent><leader>5 5gt<ESC>
nnoremap <silent><leader>6 6gt<ESC>
nnoremap <silent><leader>7 7gt<ESC>
nnoremap <silent><leader>8 8gt<ESC>
nnoremap <silent><leader>9 9gt<ESC>

"------------------------------------------------------------------------------------------------------
" abbrevation
"------------------------------------------------------------------------------------------------------

"use abbrevation to auto-correct the typo
iab teh     the
iab scr     src
iab taht    that
iab sned    send
iab itme    item
iab evla    eval
iab prot    port
iab serach  search
iab cosnt   const
iab toogle  toggle
iab envir   environment
iab partion partition

"use abbrevation to reduce key-typing;come on, lasy boy!
iab i18     Internationalization
iab l10n    Localization
iab posix   POSIX
iab fst     first
iab scd     second
iab misc    miscellaneous
iab xdate   <c-r>=strftime("%d/%m/%y %H:%M:%S")<CR>
iab xtime   <c-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>
iab autom   automaticaly
iab kath    Katherine
iab attri   attributes

"cab s   set

"------------------------------------------------------------------------------------------------------
" quick-fix mode
"------------------------------------------------------------------------------------------------------

"Ease the operation of quick-fix
nmap <silent><Left>  :cprevious<CR>
nmap <silent><Right> :cnext<CR>

"------------------------------------------------------------------------------------------------------
" gvim only
"------------------------------------------------------------------------------------------------------

"setting for gVim
if has("gui_running")

    "choose font
    if has("unix")
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
    elseif has("win32")
        set guifont=Bitstream_Vera_Sans_Mono:h11:cANSI
    endif

    "remove the toolbar,menubar
    set guioptions-=T       "No toolbar
    set guioptions-=m       "No menu
    set guioptions+=a       "make highlighted text yanked into global selection automatically

    "set scrollbar on the left side
    set guioptions-=r
    set guioptions+=l

    "maxmize the window when started
    if has ("win32")
        autocmd GUIEnter * simalt ~x
    elseif has ("unix")
        "set lines=40
        "set columns=160
    endif

    "Alt+xxx is not used for menu shortcut
    "set winaltkeys=no

    "use <C-F2> to show/hide the GVIM menu
    map <silent> <A-F1> :call Togglemenu()<CR>
    function!Togglemenu()
        if &guioptions =~# 'm'
            set guioptions-=m
        else
            set guioptions+=m
        endif
    endfunction

    "customize tab label
    "set guitablabel=%{ShortTabLabel()}

    "only show filename in the tab label; path is not included
    function! ShortTabLabel ()
        let bufnrlist = tabpagebuflist (v:lnum)
        let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
        let filename = fnamemodify (label, ':t')
        return filename
    endfunction

    "customize tab's tooltip
    set guitabtooltip=%!InfoGuiTooltip()

    function! InfoGuiTooltip()
        "get window count
        let wincount = tabpagewinnr(tabpagenr(),"$")
        let bufferlist=""
        "get name of active buffers in windows
        for i in tabpagebuflist()
            let bufferlist .= "[".fnamemodify(bufname(i),":t")."] "
        endfor
        return bufname($)."\n windows: ".wincount." " .bufferlist. " "
    endfunction

    "enable edit area tooltip,after cursor staying for 800ms;for example , on a folded area
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

endif

"------------------------------------------------------------------------------------------------------
" auto-commands
"------------------------------------------------------------------------------------------------------

"resume the cursor where the it was when the file was closed last time
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal g`\"" |
            \ endif

"Insert header automatically
"autocmd BufNewFile *.c,*.h,*.sh,*.javai,*.cppi,*.py,*.pl   call SetTitle()

"automatically set completion-method
autocmd FileType java setlocal omnifunc=javacomplete#Complete

autocmd VimEnter * call LoadSession()
autocmd VimLeave * call SaveSession()
function! SaveSession()
    set sessionoptions=buffers,folds,globals,options,resize,winpos,tabpages
    "make unix & win can understand each other's session file.
    set sessionoptions+=unix,slash
    if has ("unix")
        execute 'mksession! $HOME/.vim/sessions/session.vim'
    elseif has ("win32")
        "execute 'mksession! $HOME/session.vim'
        "execute 'mkview     $HOME/.vim/sessions/view.vim'
    endif
endfunction
function! LoadSession()
    if has ("unix")
        "execute 'source $HOME/.vim/sessions/session.vim'
    elseif has ("win32")
        "execute 'source $HOME/session.vim'
        "execute 'loadview     $HOME/.vim/sessions/view.vim'
    endif
endfunction

"------------------------------------------------------------------------------------------------------
" Misc
"------------------------------------------------------------------------------------------------------
" set <C-C> as no ops
nnoremap <C-C> <NOP>

" For vimperator 's sake
let g:netrw_http_cmd = "wget -q -O"

" setup necessary environment variables
if has('unix')
    let $VIMDATA=$HOME.'/.vim/vimdata'
elseif has ('win32')
    let $VIMDATA=$VIM.'/vimfiles/vimdata'
endif

"------------------------------------------------------------------------------------------------------
" plugins----A.vim
"------------------------------------------------------------------------------------------------------
"quick switching between .cpp and .h
nmap <silent><F4> :A<CR>

"------------------------------------------------------------------------------------------------------
" plugins----AlignPlugin.vim
"------------------------------------------------------------------------------------------------------
vmap <silent> <Leader>a= <ESC>:AlignPush<CR>:AlignCtrl lp1P1<CR>:'<,'>Align =<CR>:AlignPop<CR>
vmap <silent> <Leader>a, <ESC>:AlignPush<CR>:AlignCtrl lp0P1<CR>:'<,'>Align ,<CR>:AlignPop<CR>
vmap <silent> <Leader>a( <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align (<CR>:AlignPop<CR>

"------------------------------------------------------------------------------------------------------
" plugins----bash-support.vim
"------------------------------------------------------------------------------------------------------
let g:BASH_AuthorName = 'adaptee'
let g:BASH_Email      = 'adaptee@gmail.com'
let g:BASH_Company    = 'Open Source Corporation'

"------------------------------------------------------------------------------------------------------
" plugins----FavMenu.vim
"------------------------------------------------------------------------------------------------------
let $FAVOURITES=$VIMDATA.'/vim_favourites'

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
let MRU_File = $VIMDATA.'/vim_mru_files'
let MRU_Max_Entries = 20
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix

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
let OmniCpp_NamespaceSearch     = 1   " 0 ,  1 or 2
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

let Tlist_Sort_Type               = "name"  " sort tags by name ,not appearing order
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
"In insert mode, input pinyin for the word,and presss C-x C-u"
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
" plugins----winmanager.vim
"------------------------------------------------------------------------------------------------------
"nmap <silent><F4> :WMToggle<CR>
"let g:winManagerWindowLayout  = "BufExplorer|TagList"
"let g:winManagerWidth         = 30
"let g:defaultExplorer         = 0
"nmap <C-W><C-F> :FirstExplorerWindow<CR>
"nmap <C-W><C-B> :BottomExplorerWindow<CR>

"------------------------------------------------------------------------------------------------------
" plugins----Zoomwin.vim
"------------------------------------------------------------------------------------------------------
"Press <c-w>o :         the current window zooms into a full screen
"Press <c-w>o again:    the previous set of windows is restored

"------------------------------------------------------------------------------------------------------
" utility functions
"------------------------------------------------------------------------------------------------------
function! Cwd()
    let cwd = getcwd()
    return "e " . cwd
endfunc

function! CurDir()
    let curdir = tolower(substitute(getcwd(), '$HOME', "~/", "g"))
    return curdir
endf

function! SwitchToBuf(filename)
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

function! VisualSearch(direction) range
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

"------------------------------------------------------------------------------------------------------
" programming features
"------------------------------------------------------------------------------------------------------

set path+=/usr/include/c++/4.3
set path+=/usr/include/linux

" Recognize standard C++ headers
autocmd BufEnter /usr/include/c++/*    setfiletype cpp
autocmd BufEnter /usr/include/g++-3/*  setfiletype cpp

" In C/C++ file, press ';' to append ';' to the end of the line, when it is missing.
autocm FileType *.c,*.cpp  noremap <leader>; :s/\([^;]\)$/\1;/<CR>:let @/=""<CR><esc>

" Highlight space errors in C/C++ source files (Vim tip #935)
if $VIM_HATE_SPACE_ERRORS != '0'
    let c_space_errors=1
endif

"open included file in new buffer ,making gf(goto included file) more convenient
map gf :tabnew <cfile><CR>

" improve tag's utility
" Note: the final ';' is very import,which cause vim to loop up tag file upward recursily
" prerequisite: set autochdir
set tags=tags;
"set tags=./tags,tags;
"set tags=./tags,./../tags,./**/tags
"set tags+=/home/whodare/prog/software/linux/System/linux/tags

" make tag jumping for user-frindly
nnoremap <CR> g<C-]>
nnoremap <BS> <C-T>

" :tag will be repalced by :cstag ; the latter will search both tagfile and cscope database
"set cscopetag

" first search tag file, then search cscope database
"set cscopetagorder=1

" require plugin pythoncomplete.vim, which should be installed as default
autocmd FileType python set omnifunc=pythoncomplete#Complete

"Force VIM to update diff result on-the-fly when user edit the compared files
diffupdate

" Remove trailing spaces for C/C++ and Vim files when writing to disk
au BufWritePre *                  call DeleteTrailingWS()
function! DeleteTrailingWS()
    if $VIM_HATE_SPACE_ERRORS != '0' &&
                \(&filetype == 'c' || &filetype == 'cpp' || &filetype == 'vim'|| &filetype == 'python')
        normal m`
        silent! :%s/\s\+$//e
        normal ``
    endif
endfunction

"make VIM auto-complete the brackets!
"inoremap ( ()<ESC>i
"inoremap ) <C-R>=ClosePair(')')<CR>
inoremap { {}<ESC>i
inoremap } <C-R>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <C-R>=ClosePair(']')<CR>
inoremap < <><ESC>i
inoremap > <C-R>=ClosePair('>')<CR>
inoremap " ""<ESC>i

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

"map <F5> :call CompileRun()<CR>
"map <C-F5> :call Debug()<CR>
function! CompileRun()
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

function! Debug()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -g -o %<"
        exec "!gdb %<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!jdb %<"
    endif
endfunction

function! SetTitle()
    if &filetype == 'sh'
        call setline(1, "#!/bin/bash")
        call setline(2, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), " Author: Jekyll.Wu")
        call append(line(".")+1, " Created Time: ".strftime("%c"))
        call append(line(".")+2, " File Name: ".expand("%"))
        call append(line(".")+3, " Description: ")
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
endfunction

"------------------------------------------------------------------------------------------------------
" garabge
"------------------------------------------------------------------------------------------------------

"Map F7 to show the change since last time save
nmap <F7> :call DiffWithFileFromDisk()<CR>
function! DiffWithFileFromDisk()
    let filename=expand('%')
    let diffname = filename.'.fileFromBuffer'
    exec 'saveas! '.diffname
    diffthis
    vsplit
    exec 'edit '.filename
    diffthis
endfunction

