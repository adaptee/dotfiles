"--------------------------------------------------------------------------"
"                                   general                                "
"--------------------------------------------------------------------------"

"disable vi-compatible mode
set nocompatible

"use English UI, because I don't need Chinese prompt when using vim.
language messages en_US.utf-8

"now <Leader> means ','
let g:mapleader =","

"command-line history limitation
set history=1000

"spell checking configuration
set spelllang=en
set spellsuggest=best,5
"setup where to store the good word(zg) and bad word(zw)
set spellfile=$VIMLOCAL/rc/spellfile.utf-8.add
" tips:
" ]s : jumps to next spell error
" ]s : jumps to previous spell error.
" z= : show candidate corrections.

" none of these should be word dividers
"set isk+=_,$,@,%,#,-

" Time to wait for a key mapping (default value causes an annoying delay)
set timeout
set timeoutlen=2000

" Time to wait for key codes
set ttimeout
set ttimeoutlen=100

"enable mouse support anywhere(even in the console !)
"set mouse=a

"make '~' a full-featured operator, like 'd','c', which can be combined with motion and text-object
set tildeop

"enable mode-line feature
set modeline
"check the first and last 20 lines of files for vim-related setting
set modelines=20

"make Backspace behave as expected anywhere and any time
set backspace=indent,eol,start

"Enable filetype plugin indent
filetype on
filetype plugin on
filetype indent on

" since 'jj' nearly never occur in input mode, use it to return to normal mode.
inoremap jj <Esc>

" since ';' is not quite useful in normal mode, use it to enter Ex mode quickly
nnoremap ; :

"--------------------------------------------------------------------------"
"                                   colors                                 "
"--------------------------------------------------------------------------"

"enable syntax highlighting
syntax on


"choose color scheme
" text console provide poor support for colors....
if $TERM == "linux"
    exec "colo torte"
else
    "the terminal support 256 colors
    set t_Co=256
    exec "colo darkZ"
endif

"--------------------------------------------------------------------------"
"                                   visual clues                           "
"--------------------------------------------------------------------------"

"show line-number
set number

"highlight current line
set cursorline

"show TAB as '>-------', NEWLINE as '$', trailing whitespace as '~' when executing ":set list"
set listchars=tab:>-,eol:$,trail:~

"use advanced command-line auto-completion feature
set wildmenu

"files to be ignored in wild-menu
set wildignore=*.o,*.out,*.exe,*.dll,*.lib,*.info,*.swp,*.exp,*.

"set wildmode=list:full

"always show status line
set laststatus=2

"customize the status-line
set statusline=%2*[%-1.3n]%0*\ %F%m%r%h%w\ [GIT=%{GitBranch()}]\ [FMT=%{&ff}]\ [TYPE=%Y]\ [ENC=%{&fenc}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [LEN=%L]\ [%p%%]

"show normal-mode command in the end of last line.
set showcmd

"Show matching brackets in insert mode
set showmatch

"make % apply to '<' and '>'
set matchpairs+=<:>

"no noisy beeping, just flipping the window
set visualbell

"do not redraw while executing macros (which will be much faster)
set lazyredraw

"keep cursor stay away from the first and last 5 lines of the screen
set scrolloff=5

" leading indicator for wrapped lines
"set showbreak=>>

" alway info us whenever anything is changed via Ex command;default threshold value is 2
set report=0

" differ options
set diffopt=filler,iwhite

"--------------------------------------------------------------------------"
"                           encodings & locale                             "
"--------------------------------------------------------------------------"

" use utf-8 as VIM's default internal encoding scheme
set encoding=utf-8

"" Make VIM understand following kinds of encoding
set fileencodings=ucs-bom,utf-8,sjis,chinese,taiwan,japan,korea,latin1

" show ambiguous character in two column width
if ( has('multi_byte') && v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)' )
    set ambiwidth=double
endif

"--------------------------------------------------------------------------"
"                               search & replace                           "
"--------------------------------------------------------------------------"

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

"make vim more smart with upper/lower case when doing completion
set infercase

"When on, the ":substitute" flag 'g' is default on.
"set gdefault

" toggle search result highlighting; now the unused key '\' finally can do something now....
nmap <silent> \      :nohlsearch<CR>

"search visually-selected text
vmap  * :call SearchVisualSelectedText('f')<CR>
vmap  # :call SearchVisualSelectedText('b')<CR>

"Search visual-selected text and put the matching lines in a new tab
vnoremap <Leader>g "*y<Esc>mzqqq:silent<Space>g/<C-R>*/y<Space>Q<CR>'z:tabnew<CR>"Qpdgg

"Make good use of <BAR>:search lines containing current word------A simple grep!
nmap <BAR> [I:let temp_nr=input("Which line:") <BAR> exec "normal " . temp_nr . "[\t"<CR>

"Substitute visually-selected text, interactively and globally
vmap <Leader>s y:%s/<C-R>=substitute(escape(@", '\\/.*$^~[]'), '\n', '', 'g')<CR>/
vmap <Leader>S y:s/<C-R>=substitute(escape(@", '\\/.*$^~[]'), '\n', '', 'g')<CR>/
"Note: the 'g' in substitute() belong to substitute(), not for command 's'

" Make p in Visual mode to replace selected text with previous yanked content.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>:let @"=current_reg<CR><Esc>

" disable annoying window
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" put next item in the center of screen, automatically
nnoremap n nzz
nnoremap N Nzz

"--------------------------------------------------------------------------"
"                             cut & copy & paste                           "
"--------------------------------------------------------------------------"

"use OS clipboard as unnamed register; for windows, this option solves both copy/paste
set clipboard=unnamed

"super paste; now in insert mode, you can use <C-v> to do pasting
inoremap <C-v> <ESC>:set paste<CR>mua<C-R>*<ESC>:set nopaste<CR>a

" stolen from VimTip 1539; added creating mark before making changes.
" exchange the word under cursor with next word
nnoremap <Leader>x mx<Esc>:s/\v(<\k*%#\k*>)(\_.{-})(<\k+>)/\3\2\1/<CR>'x<Esc>:nohlsearch<CR>
" exchange the word under cursor with previous word
nnoremap <Leader>X mx<Esc>:s/\v(<\k+>)(.{-})(<\k*%#\k*>)/\3\2\1/<CR>'x<Esc>:nohlsearch<CR>

"Y's default functionality is duplicated with 'yy' and counter-intuitive
"Now 'C','D','Y' work the same way: from current position to EoF
nnoremap Y y$

"--------------------------------------------------------------------------"
"                           moving around quickly                          "
"--------------------------------------------------------------------------"

"Allow virtual editing in Insert mode.
set virtualedit=insert

" move faster
nnoremap <C-J> 3j
vnoremap <C-J> 3j
nnoremap <C-k> 3k
vnoremap <C-k> 3k

nnoremap <Space> <C-F>
nnoremap <Leader><Space> <C-B>

vnoremap <Space> <C-F>
vnoremap <Leader><Space> <C-B>

"enhance the function of '%' and '#'
source $VIMRUNTIME/macros/matchit.vim

"speed up the viewer scrolling 3 times
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"swap  ' and `, since ` is more useful
nnoremap ' `
nnoremap ` '

" swap ]] and ][
" now the rule is simple and instinct:
" first letter for forward or back, second letter for open or close
nnoremap ]] ][
nnoremap ][ ]]

"map UP/DOWN to move one visual line, not one physical line
nmap <DOWN> gj
imap <DOWN> <ESC>gja
nmap <UP> gk
imap <UP> <ESC>gka

" make moving under insert mode more easy.
imap <C-h> <Left>
imap <C-l> <Right>

"make tag jumping more easy"
nmap <Leader>d <ESC><C-]>
nmap <Leader>z <ESC><C-T>

" In normal mode, move cursor to beginning/end quickly
nnoremap H ^
noremap  L $

" In insert mode, move cursor to beginning/end quickly
inoremap <C-A>   <Home>
inoremap <C-E>   <End>

"make command-line operation more bash-style
cnoremap <C-A>  <Home>
cnoremap <C-E>  <End>

"after jumping, move that position to the center, automatically
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

"stolen from VimTip 646
"Move current line of text up and down(crossing other text)
set <M-j>=j
set <M-k>=k
nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
"Move visually-selected text up and down(crossing other text)
vmap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

"--------------------------------------------------------------------------"
"                               help & man-pages                             "
"--------------------------------------------------------------------------"

"invoke help system more smart
nnoremap <F1> <ESC>:exec "help ".expand("<cword>")<CR>

""make help system navigation more like Web pages
autocmd FileType help call MakeHelpSystemNavigationWebStyle()

"improve the user-experience of man pages;press "\K", instead of "K"
source $VIMRUNTIME/ftplugin/man.vim

"re-generate tags for help docs on start-up"
helptags $VIMLOCAL/doc

"--------------------------------------------------------------------------"
"                         text formatting/layout                           "
"--------------------------------------------------------------------------"

set tabstop=8
set shiftwidth=4
set expandtab
set softtabstop=4

"set the length limitation of physical line; 0 mean unlimited
set textwidth=0

"show long line in auto-wrapping style----visually multi-line, but physically still one line
set wrap

"make these operator multi-linable
set whichwrap=b,s,<,>,[,]

"make the wrapping more intelligent----DO NOT break up a word!
set linebreak

"set the space between two successive lines; effective only under gVim
set linespace=0

"choose C-style indentation
set cindent

" Now vim can reformat multi-byte text (e.g. Chinese)
set formatoptions+=mM

" do not use Ex-mode, use Q for formatting
map Q gq

" format the whole file
nnoremap <Leader>F gg=G''

"make deleting annoying windows ^M more easy
nnoremap <Leader>M :%s/\r//g<CR>

"after indentation adjustment, re-select previously highlighted text
vnoremap > >gv
vnoremap < <gv

"use TAB to do indentation
vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv

" merge multiple contiguous blank lines into single one.
nnoremap <silent><Leader>Z :call MergeBlankLinesIntoSingleLine()<CR>

"--------------------------------------------------------------------------"
"                                   folding                                "
"--------------------------------------------------------------------------"

"Enable folding
set foldenable

"folding signature occupies 2 column on the left side
set foldcolumn=2

"set foldcolumn's color scheme
autocmd BufEnter * :highlight FoldColumn guibg=black guifg=white

"create folding based on indentation
set foldmethod=indent

"folds whose level is greater than 'foldlevel' are closed automatically
set foldlevel=10         "when started, unzip(fold) all!

"make fold opening/closing purely automatically
"set foldopen=all
"set foldclose=all

"use space to open/close fold
"nnoremap <Space> za

"--------------------------------------------------------------------------"
"                                   buffer & file                          "
"--------------------------------------------------------------------------"

"when switching buffer, also consider other tab
set switchbuf=usetab

"when detecting file is modified outside of Vim, reload the file automatically
set autoread

" make a backup before overwriting a file, for the sake of safety.
set writebackup
" but delete the backup after the file is overwritten successfully.
set nobackup

" use directory of the related buffer as the start-point for file browser
set browsedir=buffer

" automatically change $CWD to where the file is located
set autochdir

"use Ctrl+Left/Right arrow to cycle the buffer list
nmap <C-right>    <ESC>:bn<CR>
nmap <C-left>     <ESC>:bp<CR>

"make writing and quiting more easy
nmap <Leader>s mz:w<CR>'z
nmap <Leader>W :w!<CR>
nmap <Leader>q :q<CR>
nmap <Leader>Q :q!<CR>
nmap <Leader>a :qa<CR>
nmap <Leader>A :qa!<CR>

" allows us to write to files even when we forget to use sudo when launching vim
command! -bar -nargs=0 W :silent exe "w !sudo tee % > /dev/null" | silent edit!

" add more functionality to existing <C-g>
" first, show the full path
" then, copy the full path into 3 main registers: *, +,
nnoremap <silent><C-g> 1<C-g>:call CopyCurrentFileName()<CR>

"--------------------------------------------------------------------------"
"                                   window                                 "
"--------------------------------------------------------------------------"

"make window manipulating more easy
nmap <Leader>S :split<CR><C-W>W
nmap <Leader>V :vsplit<CR><C-W>w

" iterate to next window
"nmap <Leader>i <C-w>w
" reverse iterate to previous window
"nmap <Leader>I <C-w>W

" iterate window quickly
nnoremap <C-N>      <C-W>w
nnoremap <C-P>      <C-W>W

" put new window below the original one.
"set splitbelow
" put new window on right side of the original one.
"set splitright

" make splitters between windows be blank, with no boring dashes
set fillchars=vert:\ ,stl:\ ,stlnc:\

"--------------------------------------------------------------------------"
"                                   tab page                               "
"--------------------------------------------------------------------------"

"always show tabline, even when only one tab is opened
set showtabline=2

"make tabline(tab pager) compact and more distinguishing
set tabline=%!ShortTabLine()

"create empty new tab
nnoremap <silent><Leader>t :tabnew<CR>
"show all buffers in separate tabs
nnoremap <silent><Leader>T :tab sball<CR>

"switch to next tab
nnoremap <silent><Leader>n :tabnext<CR>
nnoremap <silent><Tab>     :tabnext<CR>
"switch to previous tab
nnoremap <silent><Leader>p :tabprevious<CR>
nnoremap <S-Tab>           :tabprevious<CR>

"fast switch to first & last tab
nnoremap <silent><leader>1 :tabfirst<CR>
nnoremap <silent><leader>0 :tablast<CR>

"Switch to tab<N>
nnoremap <silent><leader>2 2gt<ESC>
nnoremap <silent><leader>3 3gt<ESC>
nnoremap <silent><leader>4 4gt<ESC>
nnoremap <silent><leader>5 5gt<ESC>
nnoremap <silent><leader>6 6gt<ESC>
nnoremap <silent><leader>7 7gt<ESC>
nnoremap <silent><leader>8 8gt<ESC>
nnoremap <silent><leader>9 9gt<ESC>

"--------------------------------------------------------------------------"
"                                abbreviation                               "
"--------------------------------------------------------------------------"

"use abbreviation to auto-correct the typo
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
iab partion partition
iab htis     this
iab tihs     this
iab funciton function
iab fucntion function
iab funtion  function
iab retunr   return
iab reutrn   return
iab sefl     self
iab eslf     self

"use abbreviation to reduce key-typing;come on, lazy boy!
iab ok      OK
iab abbr    abbreviation
iab autom   automatically
iab i18n    Internationalization
iab l10n    Localization
iab posix   POSIX
iab envir   environment
iab fst     first
iab scd     second
iab misc    miscellaneous
iab xdate   <C-r>=strftime("%d/%m/%y %H:%M:%S")<CR>
iab xtime   <C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>
iab kath    Katherine
iab attr    attribute
iab chinese Chinese
iab english English
iab america America
iab spec    specification
iab #b /************************************************
iab #e ************************************************/
iab #l /*----------------------------------------------*/

" make entering the most frequently used command more easily
cab E   echo
cab G   grep
cab H   help
cab M   map
cab IM  imap
cab UM  unmap
cab R   registers
cab S   set
cab V   vimgrep

"--------------------------------------------------------------------------"
"                               quickfix mode                              "
"--------------------------------------------------------------------------"

" jump to next/previous entry in quickfix list
nnoremap <silent><C-H> :cprevious<CR>
nnoremap <silent><C-L> :cnext<CR>

" jump to next/previous entry in quickfix list
nmap <silent><Left>  :cprevious<CR>
nmap <silent><Right> :cnext<CR>

"press v in quickfix window to preview while holding focus in quickfix window
autocmd FileType qf :nnoremap <buffer> v <Enter>zz:wincmd p<Enter>

"--------------------------------------------------------------------------"
"                               auto-commands                              "
"--------------------------------------------------------------------------"

"resume the cursor where the it was when the file was closed last time
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal g`\"" |
            \ endif

"--------------------------------------------------------------------------"
"                         programming features                             "
"--------------------------------------------------------------------------"

"open file in new tab, making gf(goto included file) more convenient
nnoremap gf <C-W>gf

"Insert header automatically
"autocmd BufNewFile *.sh  call InsertHeaderForBashScript()

"Insert python header automatically
autocmd BufNewFile *.py  call InsertHeaderForPythonScript ()

" Remove trailing white spaces when saving files
autocmd BufWritePre *                  call DeleteTrailingWhiteSpaces()

" Adjust wrongly spaced commas when saving changes
autocmd BufWritePre *                  call AdjustCommaRelatedSpacing()

" improve tag's utility
" Note: the final ';' is very import, which cause vim to loop up tag file upward recursively
" prerequisite: set autochdir
"set tags=tags;
set tags=./tags,tags;

" :tag will be replaced by :cstag ; the latter will search both tagfile and cscope database
"set cscopetag

" first search tag file, then search cscope database
"set cscopetagorder=1

"map <F5> :call CompileCurrentFile()<CR>
"map <C-F5> :call DebugCurrentFile()<CR>


"--------------------------------------------------------------------------"
"                                miscellaneous                             "
"--------------------------------------------------------------------------"

" since <C-e> is customized to moving to EOL, I will map <C-b> to original <C-e>
" now <C-y> and <C-b> is very to remember:
" 1).y(upper) mean inserting character in corresponding position of upper line
" 2).h(lower) mean repeating character in corresponding position of lower line
inoremap <C-b> <C-e>

" Since Jx is more useful than only J....
"nnoremap J Jx

" for those who has the obsession of saving changes.....
" save automatically after pressing <Enter>
":inoremap <cr> <c-o>:w<cr><cr>

" For vimperator's sake
let g:netrw_http_cmd = "wget -q -O"

" defines what Vim will consider for numbers when using
" CTRL-A and CTRL-X commands for adding to and subtracting.
" note, alpha mean (a, b, c, d,...z); besides, decimal is always implied.
set nrformats=alpha,hex

"stolen from VimTip 1540
" set 'updatetime' to 10 seconds when in insert mode
autocmd InsertEnter * let updatetimerestore=&updatetime | set updatetime=10000
autocmd InsertLeave * let &updatetime=updatetimerestore
" automatically leave insert mode after 'updatetime' milliseconds of inaction
autocmd CursorHoldI * stopinsert

"--------------------------------------------------------------------------"
"                                   garbage                                "
"--------------------------------------------------------------------------"

"show the change since last save
"nmap <F7> :call ShowDiffSinceLastSave()<CR>


