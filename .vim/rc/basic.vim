"--------------------------------------------------------------------------"
"                                   general                                "
"--------------------------------------------------------------------------"

" disable vi-compatible mode
set nocompatible

" now <Leader> means ','
let g:mapleader =","

" use utf-8 as Vim's internal encoding scheme
set encoding=utf-8

" use English UI, because I don't need Chinese prompt when using vim.
language messages C
language ctype en_US.UTF-8
language time C

" alwways use English in  GUI menu
set langmenu=none
" always use and only use English help
set helplang=en

" Prevent sourcing $VIMRUNTIME/menu.vim, I do not want menus :)
" [NOTE]: This has to be specified before enabling filetype support
set guioptions+=M
" Yes, I am lying!
let did_install_default_menus = 1

" command-line history limitation
set history=5000

" viminfo setting : what items are stored and restored?
set viminfo = ""
set viminfo+='1000  " number of files whose mark are saved
set viminfo+=/5000  " size of search history
set viminfo+=:5000  " size of Ex command history
set viminfo+=@5000  " size of Ex command history
set viminfo+=%      " save buffer list
set viminfo+=h      " disbale the effect of hlsearch after loading viminfo
set viminfo+=f1     " save global marks

" 99% time, I have a fast tty connection; improve redrawing
set ttyfast

" spell checking configuration
set spelllang=en_us
set spellsuggest=best,5
" setup where to store the good word(zg) and bad word(zw)
set spellfile=$VIMLOCAL/rc/spellfile.utf-8.add

" none of these should be word dividers
"set isk+=_,$,@,%,#,-

" Time to wait for a key mapping (default value causes an annoying delay)
set timeout
set timeoutlen=2000

" Time to wait for key codes
set ttimeout
set ttimeoutlen=100

" enable mouse support anywhere(even in the console !)
set mouse=a

" hide mouse when typing
set mousehide

" mouse behave in X11 style
behave xterm

" make '~' a full-featured operator, like 'd','c', which can be combined with motion and text-object
set tildeop

" enable mode-line feature
set modeline
" check the first and last 10 lines of files for vim-related setting
set modelines=10

" make Backspace behave as expected anywhere and any time
set backspace=indent,eol,start

" Maximum number of tab pages to be opened by the -p command line argument
" or the :tab all command.
set tabpagemax=50

" Enable filetype plug-in indent
filetype on
filetype plugin on
filetype indent on

" since 'jj' nearly never occur in input mode, use it to return to normal mode.
inoremap jj <Esc>

" insert newline for lazy guys
" kk apprear rarely  in word ; don't worry
inoremap kk <CR>


" repeat last change for each line withn selected range
vnoremap . :normal .<CR>

"--------------------------------------------------------------------------"
"                                   colors                                 "
"--------------------------------------------------------------------------"

" enable syntax highlighting
syntax on

" do not perform syntax highlight for characters after this column
" highlight a annomal-long line is slow and ridiculas.
set synmaxcol=1000

" choose color scheme
" text console provide poor support for colors....
if $TERM == "linux"
    execute "colorscheme darkZ"
else
    " otherwise, the terminal support 256 colors
    set t_Co=256
    execute "colorscheme darkZ"
endif

" use normal font in statusline
highlight StatusLine gui=none

"--------------------------------------------------------------------------"
"                                   visual clues                           "
"--------------------------------------------------------------------------"

" show line-number
set number

" highlight current line
set cursorline

" after executing ":set list"
" show TAB as '>-------', NEWLINE as '$', trailing whitespace as '~'
set listchars=tab:>-,eol:$,trail:*,extends:»,precedes:«

" use advanced command-line auto-completion feature
set wildmenu

" files to be ignored in wild-menu
set wildignore=*.o,*.out,*.exe,*.dll,*.lib,*.info,*.swp,*.exp,*.

set completeopt=menu,longest

" within cmdline completion, filename with such suffixes are given low priority
set suffixes +=~
set suffixes +=.bak
set suffixes +=.orig
set suffixes +=.swp
set suffixes +=.o
set suffixes +=.info
set suffixes +=.aux
set suffixes +=.log
set suffixes +=.dvi
set suffixes +=.bbl
set suffixes +=.blg
set suffixes +=.brf
set suffixes +=.cb
set suffixes +=.ind
set suffixes +=.idx
set suffixes +=.ilg
set suffixes +=.inx
set suffixes +=.out
set suffixes +=.toc

" give the first completion. also list all candidates
set wildmode=list:full

" customize the filling char used in statusline，vertical separator ,diff, etc
set fillchars=stl:\ ,stlnc:\ ,vert:\ ,diff:-

" always show status line
set laststatus=2

"  make statusline customization easier
set statusline=%2*[%-1.3n]%0*               "" buffer number
set statusline+=\ [%{GetCWD()}]             "" current directory
set statusline+=\ %t                        "" file name only
set statusline+=%m                          "" buffer modified , or not
set statusline+=%r                          "" file readonly, or not
set statusline+=%h                          "" help buffer , nor not
set statusline+=%w                          "" preview window, or not
set statusline+=%\=                         "" after here, justify to the right
set statusline+=\ [POS=%l,%v,%o]            "" line, column, byte-offset
set statusline+=\ [HEX=0x%02B]              "" show current char's hexidecimal code point
set statusline+=\ [%LL,%p%%]                "" percentage by line
set statusline+=%<                          "" truncate from here, if needed
set statusline+=\ [ENC=%{&fenc}]            "" show file encoding
set statusline+=\ [GIT=%{GitBranch()}]      "" show which branch we are on
set statusline+=\ [FMT=%{&ff}]              "" unix ,or dos
set statusline+=\ [TYPE=%{&ft}]             "" show file type

" show normal-mode command in the end of last line.
set showcmd

" Show matching brackets in insert mode
set showmatch

" make % apply to '<' and '>'
set matchpairs+=<:>

" no noisy beeping, just flipping the window
set visualbell

" do not redraw while executing macros (which will be much faster)
set lazyredraw


" keep cursor stay away from the first and last 5 lines of the screen
set scrolloff=5

" leading indicator for wrapped lines
" set showbreak=>>


" ignore whitespace difference
set diffopt=filler,iwhite

" lastline :show last line as much as possible, when these is not enough space
" uhex: show un-printable character as <xx>, instead of ^K
set display+=lastline

" highlight the 1st, 5th, 9th column ,etc
" match Search /\%(\_^\s*\)\@<=\%(\%1v\|\%5v\|\%9v\)\s/

" highlight text beyond the 80th column
"match ErrorMsg '\%>80v.\+'

"--------------------------------------------------------------------------"
"                           encoding & locale                             "
"--------------------------------------------------------------------------"


"  Make VIM understand following kinds of encoding
set fileencodings=ucs-bom,utf-8,sjis,japan,cp936,gb18030,chinese,taiwan,big5,korea,latin1

" show ambiguous character in width of two columns
if  has('multi_byte')
    set ambiwidth=double
endif

"--------------------------------------------------------------------------"
"                               search & replace                           "
"--------------------------------------------------------------------------"

" highlight searching result
set hlsearch

" show real-time search result when typing the pattern
set incsearch

" enable wrapping around when searching
set wrapscan

" ignore case when searching
set ignorecase

" resume case-sensitive if the pattern contain upper-case letter
set smartcase

" make vim more smart with upper/lower case when doing completion
set infercase

" When on, the ":substitute" flag 'g' is default on.
"set gdefault

" toggle search result highlighting; now the unused key '\' finally can do something now....
nnoremap <silent> \      :nohlsearch<CR>

" search visually-selected text
vnoremap  * :call SearchVisualSelectedText('f')<CR>
vnoremap  # :call SearchVisualSelectedText('b')<CR>

" Substitute current word , or visually-selected text
" Note: 'g' applys to function substitute(), not to command ':s'
nnoremap <Leader>s  :%s/\<<C-R>=expand("<cword>")<CR>\>//g<Left><Left>
vnoremap <Leader>s y:%s/\<<C-R>=substitute(escape(@", '\\/.*$^~[]'), '\n', '', 'g')<CR>\>//g<Left><Left>

" Search visual-selected text and put the matching lines in a new tab
vnoremap <Leader>g "*y<Esc>mzqqq:silent<Space>g/<C-R>*/y<Space>Q<CR>'z:tabnew<CR>"Qpdgg

" Make good use of <BAR>
" "search lines containing current word------A simple grep!
nmap <BAR> [I:let temp_nr=input("Which line:") <BAR> execute "normal " . temp_nr . "[\t"<CR>


" disable annoying window
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" put next item in the center of screen, automatically
nnoremap n nzz
nnoremap N Nzz

" virtual replace is often what you prefer
" especailly when dealing <TAB> aligned table columns
nnoremap r gr
nnoremap R gR


"--------------------------------------------------------------------------"
"                             cut & copy & paste                           "
"--------------------------------------------------------------------------"

" make "* and "_ equivalent
set clipboard+=unnamed

" automatically put visually selected text into "*
set clipboard+=autoselect

" paste in line-wise mode
nnoremap ,p :put "<CR>
nnoremap ,P :put! "<CR>

" Make p in Visual mode to replace selected text with previous yanked content.
vnoremap <silent> p <Esc>:let register_backup=@"<CR>gvp:let @"=register_backup<CR>

" super paste; now in insert mode, you can use <C-v> to do pasting
inoremap <C-v> <ESC>:set paste<CR>mua<C-R>*<ESC>:set nopaste<CR>a

" Y's default functionality is duplicated with 'yy' and counter-intuitive
" Now 'C','D','Y' work the same way: from current position to EoF
nnoremap Y y$

" stolen from VimTip 1539; added creating mark before making changes.
" exchange the word under cursor with next word
nnoremap <Leader>x mx:s/\v(<\k*%#\k*>)(\_.{-})(<\k+>)/\3\2\1/<CR>'x<Esc>:nohlsearch<CR>
" exchange the word under cursor with previous word
nnoremap <Leader>X mx:s/\v(<\k+>)(.{-})(<\k*%#\k*>)/\3\2\1/<CR>'x<Esc>:nohlsearch<CR>


" Make shift-insert work like in Xterm : paste selection
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

"--------------------------------------------------------------------------"
"                           moving around quickly                          "
"--------------------------------------------------------------------------"

" allow virtual position in these modes
set virtualedit=insert,block

" move faster
nnoremap <C-J> 3j
vnoremap <C-J> 3j
nnoremap <C-k> 3k
vnoremap <C-k> 3k

nnoremap <Space> <C-F>
nnoremap <S-Space> <C-B>

" enhance the function of '%' and '#'
source $VIMRUNTIME/macros/matchit.vim

" speed up the viewer scrolling 3 times
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" swap  ' and `, since ` is more useful
nnoremap ' `
nnoremap ` '

" swap ]] and ][
" now the rule is simple and instinct:
" first letter for forward or back, second letter for open or close
nnoremap ]] ][
nnoremap ][ ]]


" make moving under insert mode more easy.
inoremap <C-h> <Left>
inoremap <C-l> <Right>



" In normal & visual mode, move cursor to beginning/end quickly
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" after jumping, move that position to the center, automatically
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" now you car press 'd '  to delete until next <Space>(inclusice)
onoremap <Space> f<Space>

if ( &virtualedit == "all")
    nnoremap <silent> x x:call BetterXinVirtualEdit()<CR>
endif

"  '_' has no usage, my opionin
"  now, '+' and '_', both pressed together with Shift, do opposotie thing
nnoremap _ -
vnoremap _ -

"--------------------------------------------------------------------------"
"                                  command line                            "
"--------------------------------------------------------------------------"

" ';' is not quite useful in normal mode, use it to enter Ex mode quickly
nnoremap ; :

" make command-line operation more emacs style
" help tcsh-style
cnoremap <C-A>  <Home>
cnoremap <C-E>  <End>
cnoremap <C-j>  <Home>
cnoremap <C-k>  <End>
cnoremap <C-h>  <Left>
cnoremap <C-l>  <Right>
cnoremap <C-b>  <S-Left>
cnoremap <C-f>  <S-Right>
cnoremap <C-D>  <Del>

" <CR> is hard to each
cnoremap <C-m> <CR>

" ; is quite useless in command line
" if you really need to insert ; , press <C-v>;
cnoremap ; :


"--------------------------------------------------------------------------"
"                                  Arrows                                  "
"--------------------------------------------------------------------------"

" map UP/DOWN to move one visual line, not one physical line
nnoremap <DOWN> gj
inoremap <DOWN> <ESC>gja
nnoremap <UP> gk
inoremap <UP> <ESC>gka

" cycle  buffer list
nnoremap <silent> <Left>     :bprevious<CR>
nnoremap <silent> <Right>    :bnext<CR>

" scroll the alternate window
nnoremap <silent> <Up>       :call ScrollOtherWindow("up")<CR>
nnoremap <silent> <Down>     :call ScrollOtherWindow("down")<CR>

" move tabpage
nnoremap <silent> <S-Left>   :call TabMoveLeft()<CR>
nnoremap <silent> <S-Right>  :call TabMoveRight()<CR>



"--------------------------------------------------------------------------"
"                         text formatting/layout                           "
"--------------------------------------------------------------------------"

set tabstop=8
set shiftwidth=4
set expandtab
set softtabstop=4

" set the length limitation of physical line; 0 mean unlimited
set textwidth=0

" show long line in auto-wrapping style
" visually multi-line, but physically still one line
set wrap

" make the wrapping more intelligent----DO NOT break up a word!
" like wrap, this option only control haw data is display .
" It won't influece the data itself.
set linebreak

" make these operator to move cursor across lines
set whichwrap+=b,s
set whichwrap+=h,l
set whichwrap+=<,>,[,]


" Round indent to multiple of 'shiftwidth'.
set shiftround

" choose C-style indentation
set cindent


" format paragraph
set formatprg=fmt

" do not use Ex-mode, use Q for formatting
map Q gq

" put 2 spaces after '.' '!' '?' when join lines
set joinspaces

" Since Jx is more useful than only J....
"nnoremap J Jx

" format the whole file
nnoremap <Leader>F gg=G''

" make deleting annoying windows ^M more easy
nnoremap <Leader>M :%s/\r//g<CR>

" after indentation adjustment, re-select previously highlighted text
vnoremap > >gv
vnoremap < <gv

" use TAB to do indentation
vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv

" merge multiple contiguous blank lines into single one.
nnoremap <silent> <Leader>Z :call MergeBlankLinesIntoSingleLine()<CR>

"--------------------------------------------------------------------------"
"                                 formatoptions                            "
"--------------------------------------------------------------------------"

" auto-re-foramt paragraph after insertion or deletion
"set formatoptions+=a

" auto-wrap text
"set formatoptions+=t

" auto-format comments , useful for source code
"set formatoptions+=c

" add extra indentation to the first line of a paragraph
"set formatoptions+=2

" insert comment header when new comment line is created
"set formatoptions+=o
"set formatoptions+=r

" allow line-breaking after multibyte char, such as Chinese
set formatoptions+=mM

"--------------------------------------------------------------------------"
"                                  Printing                                "
"--------------------------------------------------------------------------"

" these 2 options has to match
set printencoding=utf-8
set printmbcharset=ISO10646


"--------------------------------------------------------------------------"
"                                   folding                                "
"--------------------------------------------------------------------------"

" Enable folding
set foldenable

" folding signature occupies 2 column on the left side
set foldcolumn=2

" set foldcolumn's color scheme
autocmd BufEnter * :highlight FoldColumn guibg=black guifg=white

" create folding based on indentation
set foldmethod=indent

" folds whose level is greater than 'foldlevel' are closed automatically
set foldlevel=10         "when started, unzip(fold) all!

" make fold opening/closing purely automatically
"set foldopen=all
"set foldclose=all

"use space to open/close fold
"nnoremap <Space> za

"--------------------------------------------------------------------------"
"                                   buffer & file                          "
"--------------------------------------------------------------------------"

" when switching buffer, also consider other tab
set switchbuf=usetab

" when detecting file is modified outside of Vim, reload the file automatically
set autoread

" make a backup before overwriting a file, for the sake of safety.
set writebackup
" but delete the backup after the file is overwritten successfully.
set nobackup

" use directory of the related buffer as the start-point for file browser
set browsedir=buffer

" automatically change current directory to where the file is located
if exists('+autochdir')
    set autochdir
else
    autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

" when dealing with unsaved buffer, raise a confirmation dialog instead of failing
set confirm

" make writing and quiting more easy
nnoremap <Leader>w mw:update<CR>'w
nnoremap <Leader>W :w!<CR>

nnoremap <silent> <Leader>q :Quit("q")<CR>
nnoremap <silent> <Leader>Q :Quit("q!")<CR>
nnoremap <silent> <Leader>a :qa<CR>
nnoremap <silent> <Leader>A :qa!<CR>

" add more functionality to existing <C-g>
" first, show the full path
" then, copy the full path into 3 registers: * + "
nnoremap <silent> <C-g> 1<C-g>:call CopyCurrentFileName()<CR>

" view folder hierarchical in flat mode
nnoremap -F :call FlatView('.')<CR>

" supprss W10 : changing a readonly file
autocmd FileChangedRO /*  setlocal noreadonly

"--------------------------------------------------------------------------"
"                                   window                                 "
"--------------------------------------------------------------------------"

" make window manipulating more easy
nnoremap <Leader>S :split<CR><C-W>W
nnoremap <Leader>V :vsplit<CR><C-W>w

" iterate window quickly
nnoremap <C-N>      <C-W>w
nnoremap <C-P>      <C-W>W

" put new window below the original one.
"set splitbelow
" put new window on right side of the original one.
"set splitright


"--------------------------------------------------------------------------"
"                                   tabpage                                "
"--------------------------------------------------------------------------"

" always show tabline, even when only one tab is opened
set showtabline=2

" make tabline(tabpage) compact and more distinguishing
set tabline=%!MyTabLine()

" create empty new tab
nnoremap <silent> <Leader>t :tabnew<CR>
" show all buffers in separate tabs
nnoremap <silent> <Leader>T :tab sball<CR>

" switch to next tab
nnoremap <silent> <Tab>     :tabnext<CR>
" switch to previous tab
nnoremap <silent> <S-Tab>   :tabprevious<CR>

" fast switch to first & last tab
nnoremap <silent> <Leader>1 :tabfirst<CR>
nnoremap <silent> <Leader>0 :tablast<CR>

" Switch to tab<N>
nnoremap <silent> <Leader>2 2gt
nnoremap <silent> <Leader>3 3gt
nnoremap <silent> <Leader>4 4gt
nnoremap <silent> <Leader>5 5gt
nnoremap <silent> <Leader>6 6gt
nnoremap <silent> <Leader>7 7gt
nnoremap <silent> <Leader>8 8gt
nnoremap <silent> <Leader>9 9gt

"--------------------------------------------------------------------------"
"                                 messages                                 "
"--------------------------------------------------------------------------"

" enable a bunch of shortness
set shortmess+=a

" avoid the warning message when finding .swp file
"set shortmess+=A

" don't give 'search hit BOTTOM, continuing at TOP'
set shortmess+=s

" truncate file message at the start if it is too long
set shortmess+=t

" always info us whenever anything is changed via Ex command
" default threshold is 2 lines
set report=0

"--------------------------------------------------------------------------"
"                                  tags                                    "
"--------------------------------------------------------------------------"

" improve tag's utility
" Note: the final ';' is very import, which cause vim to loop up tag file upward recursively
" prerequisite: set autochdir
" set tags=tags;
set tags=./tags,tags;

" :tag will be replaced by :cstag ; the latter will search both tagfile and cscope database
"set cscopetag

" first search tag file, then search cscope database
set cscopetagorder=1

" make tag jumping more easy"
nnoremap <silent> <Leader>d :call GotoDefinition(expand("<cword>"))<CR>
nnoremap <Leader>z <C-T>

" invoke help system more easily
nnoremap <F1> :execute "help ".expand("<cword>")<CR>

" re-generate tags for help docs on start-up
helptags $VIMLOCAL/doc

"--------------------------------------------------------------------------"
"                               quickfix mode                              "
"--------------------------------------------------------------------------"

" jump to next/previous entry in quickfix list
nnoremap <silent> <C-H> :cprevious<CR>
nnoremap <silent> <C-L> :cnext<CR>

" press v in quickfix window to preview while holding focus in quickfix window
autocmd FileType qf :nnoremap <buffer> v <Enter>zz:wincmd p<Enter>

"--------------------------------------------------------------------------"
"                         programming features                             "
"--------------------------------------------------------------------------"


" better gf : open the file in new tabpage, just next to current tabpage
"nnoremap gf :tabfind <cfile> <CR>
nnoremap gf <C-w>gF
vnoremap gf <C-w>gF

" enable 'gf' to work with environment variable in the form of ${VAR}
set isfname+={,}

" archives with those extensions are actully zip files
autocmd BufReadCmd *.jar,*.xpi call zip#Browse(expand("<amatch>"))

" Insert python header automatically
autocmd BufNewFile *.py  call InsertHeaderForPythonScript()

" Remove trailing white spaces when saving files
autocmd BufWritePre *    call DeleteTrailingWhiteSpaces()

" Adjust wrongly spaced commas when saving changes
autocmd BufWritePre *    call AdjustCommaRelatedSpacing()



"--------------------------------------------------------------------------"
"                                miscellaneous                             "
"--------------------------------------------------------------------------"

" resume the cursor where the it was when the file was closed last time
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal g`\"" |
            \ endif

" left-and-right-align a line by filling in appropriate extra spaces
source $VIMRUNTIME/macros/justify.vim

" if file is already open in other vim instance,  activate that instace
" then just exit
source $VIMRUNTIME/macros/editexisting.vim

" now <C-y> and <C-b> is very to remember by their relative position to 'h'
" 1).y(above h) mean inserting character in corresponding position of upper line
" 2).b(below h) mean repeating character in corresponding position of lower line
inoremap <C-b> <C-e>

" for those who has the obsession of saving changes.....
" save automatically after pressing <Enter>
"inoremap <cr> <c-o>:w<cr><cr>

" For vimperator's sake
let g:netrw_http_cmd = "wget -q -O"

" defines what Vim will consider for numbers when using
" CTRL-A and CTRL-X commands for adding to and subtracting.
" note, alpha mean (a, b, c, d,...z); besides, decimal is always implied.
set nrformats=alpha,hex

" VimTip 1540
" set 'updatetime' to 10 seconds when in insert mode
autocmd InsertEnter * let updatetimerestore=&updatetime | set updatetime=10000
autocmd InsertLeave * let &updatetime=updatetimerestore
" automatically leave insert mode after 'updatetime' milliseconds of idleness
autocmd CursorHoldI * stopinsert

