"Fast reading of .vimrc
nmap <silent> <leader>r :call SwitchToBuf("$HOME/.vimrc")<CR>

"When .vimrc is edited and saved, reload it automaticaly
autocmd! bufwritepost .vimrc source $HOME/.vimrc


autocmd VimEnter * call LoadSession()
autocmd VimLeave * call SaveSession()

function! SaveSession()
    set sessionoptions=buffers,folds,globals,options,resize,winpos,tabpages
    "make unix & win can understand each other's session file.
    set sessionoptions+=unix,slash
        execute 'mksession! $VIMLOCAL/sessions/session.vim'
endfunction

function! LoadSession()
        "execute 'source $VIMLOCAL/sessions/session.vim'
endfunction

"open files under current folder.
nmap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"Now 'K' invokes external cmd 'manall' , which will man all iterm with the same name
"set keywordprg = manall
"set keywordprg = myman
