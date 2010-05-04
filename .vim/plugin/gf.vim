" File:          gf.vim
" Author:        Jekyll Wu
" Version:       0.0.1
" Last Modified: 2010-05-05
" Description:   gf.vim provide command :Gf, which is a better alternative to gf

"[FIXME] fails when opening stdio.h multiple times in a buffer with no name
"[REASON]" the buffer with no name will retains the current dir of previous window( because i turn on autochdir)
" go bufloaed("stdio.h")  will be interpreted as bufloaded("/usr/include/stdio.h") ,which is true, and cause SwitchToBuffer("stdio.h") be called.

function! Gf(filename)

    " expand environment variables, such as $VIM or $HOME
    let l:fullname = expand(a:filename)

    " if the file is already open
    if bufloaded(l:fullname)
        " switch to exising window
        "echo l:fullname . " is already loaded !"
        "call SwitchToBuffer(l:fullname)
        execute "drop " . l:fullname
    else
        " for absolute path, no need to do searching in 'path'
        if l:fullname[0] == '/'
            if CurrentBufNotUsed( )
                execute "edit " . l:fullname
            else
                execute "tabedit " . l:fullname
            endif
        else
            " execute is used to prevent gf from being mapped recusively
            execute "normal \<C-w>gF"

            " or, this should also work
            "execute "tabfind " . l:fullname
        endif
    endif

endfunction

function! CurrentBufNotUsed ( )

    if ( bufname('%') == '' && &modified == 'nomodified' )
        return 1
    else
        return 0
    fi

endfunction

command! -nargs=1 Gf call Gf( <args> )
nnoremap gf :Gf( expand("<cfile>") )<CR>

" [Damn it] the build-in command :drop does the same thing!
" prerequisite : the file named as fullname has been loaded
" action : switch focus to  the window showing that buffer
function! SwitchToBuffer(fullname)

    let l:found = -1

    " locate in which tabpage is the file loaded
    for i in range(tabpagenr('$'))

        let tabnr = i + 1
        let bufnrlist = tabpagebuflist( tabnr )

        for bufnr in bufnrlist
            " bufname() may only return the filename, not inclduing directory
            " so fnamemodify() is neeed to get the fullname
            let filename = fnamemodify( bufname(bufnr), ":p")
            if filename == a:fullname
                let l:found = 1
                break
            endif
        endfor

        if  ( l:found != -1 )
            " first , ask vim to switch focus to that tabpage
            execute "tabnext " . tabnr

            " second , ark vim to switch focus to that window
            let l:winnr = bufwinnr(bufnr)
            execute l:winnr . "wincmd w"

            return

        endif

    endfor

    echo "[Error]: " . a:fullname . " is still not loaded yet!"

endfunction


