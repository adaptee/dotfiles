" Don't take this as a garbage place
" remembet to clear stuff here, at times !

" this line is for checkting whether the font is suitable for programming
let font_quality_test="oO0Q1liL"

"---------------------------------Testing Case------------------------------"

" last modified: 2010-Apr-07 05:46:53

" ftp://ftp.kernel.org/pub/README

" stdio.h:222

" /usr/include/donotexit.h

"--------------------------------- Try new things------------------------------"

" change the shape of the cursor in different modes
" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes

if $TERM != "linux"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Edit the file with an existing Vim if possible
source $VIMRUNTIME/macros/editexisting.vim

"cool by eyes, maybe?
"hi CursorLine gui=underline

"[vim 7.3]


"  used in combination with 'scrollbind'
"  make the cursor position in other window is also scrolled
set cursorbind

" available for version >= 7.3
if has('persistent_undo')

    " enable persistent undo across open/close
    "set undofile
    "set undodir=$HOME/.vim_undo/
endif

if v:version >= 703

    " use relative line number, instead of absolute line number
    "set relativenumber

    " highlight the column right after 'textwidth'.
    "set colorcolumn=+1
endif
"[end of vim 7.3]


" BOM often cause probelems under linux ; So remove BOM when writing
autocmd BufEnter * setlocal nobomb

" Highlight tabs not used for indentation
3match errorMsg /[^\t]\zs\t\+/

" underline the specified words
"3match Underlined /someword\|otherword/

"set printmbfont=r:STSong-Light,c:yes "MSungGBK-Light
"set printfont=r:Monaco
set printmbfont=r:ZenHei
"set printmbfont=r:YuanTiMono

" vimtip #900 Insert comment boxes
nnoremap ,co O#<Esc>72A=<Esc>o#<CR><Esc>i#<Esc>72a=<Esc>kA

"source $VIMLOCAL/rc/safesearch.vim

" vimtip #810 ; highlight longlines
"autocmd BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
"autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

"autocmd BufWinLeave * if expand("%") != "" | mkview | endif
"autocmd BufWinEnter * if expand("%") != "" | loadview | endif

" hint : 'H' for help
"autocmd BufLeave * if &filetype == "help" | mark H | endif
"nnoremap -h  :tabnew<CR>'H<CR>

if $TERM == 'screen'
    set term=xterm
endif

" vimtip #206
" highlight the typo of duplicated words
" [TODO]  does not work when the typo appaer within comment
syn match texDoubleWord "\c\<\(\a\+\)\_s\+\1\>"
highlight def link texDoubleWord Error

"--------------------------------------------------------------------------------"

" vimtip #1599
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
    echo a:cmdline
    let expanded_cmdline = a:cmdline
    for part in split(a:cmdline, ' ')
        if part[0] =~ '\v[%#<]'
            let expanded_part = fnameescape(expand(part))
            let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
        endif
    endfor
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'You entered:    ' . a:cmdline)
    call setline(2, 'Expanded Form:  ' .expanded_cmdline)
    call setline(3,substitute(getline(2),'.','=','g'))
    execute 'silent $read !'. expanded_cmdline
    setlocal nomodifiable
    1
endfunction


" vimtip #235  hightligh currnet word
nnoremap <silent><C-c> :call HighlightCurWord()<CR>
function! HighlightCurWord()
    if !exists("s:highlightcursor")
        match Underlined /\k*\%#\k*/
        let s:highlightcursor=1
    else
        match None
        unlet s:highlightcursor
    endif
endfunction


finish

let g:github_user = 'adaptee'
let g:github_token = 'fad1bbcf073a019011be9e1747253581'

" detect filetype based upon filename
let g:gist_detect_filetype = 1

" open browser after the post...
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'firefox %URL%'

"let g:PASTE_URI = 'http://paste.pocoo.org/'
let g:nickID = 'adaptee'

" vimtip #639
syn region MySkip contained start="^\s*#\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*#\s*endif\>" contains=MySkip
let g:CommentDefines = ""
hi link MyCommentOut2 MyCommentOut
hi link MySkip MyCommentOut
hi link MyCommentOut Comment
"map <silent> ,a :call AddCommentDefine()<CR>
"map <silent> ,x :call ClearCommentDefine()<CR>

function! AddCommentDefine()
    let g:CommentDefines = "\\(" . expand("<cword>") . "\\)"
    syn clear MyCommentOut
    syn clear MyCommentOut2
    exe 'syn region MyCommentOut start="^\s*#\s*ifdef\s\+' . g:CommentDefines . '\>" end=".\|$" contains=MyCommentOut2'
    exe 'syn region MyCommentOut2 contained start="' . g:CommentDefines . '" end="^\s*#\s*\(endif\>\|else\>\|elif\>\)" contains=MySkip'
    endfunction

    function! ClearCommentDefine()
        let g:ClearCommentDefine = ""
        syn clear MyCommentOut
        syn clear MyCommentOut2
    endfunction


