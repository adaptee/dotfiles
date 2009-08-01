"Fast reading of _vimrc
nmap <silent> <leader>r :call SwitchToBuf("$VIM/_vimrc")<CR>

"When _vimrc is edited and saved, reload it automaticaly
autocmd! bufwritepost _vimrc source $VIM/_vimrc

autocmd VimEnter * call LoadSession()
autocmd VimLeave * call SaveSession()

function! SaveSession()
    set sessionoptions=buffers,folds,globals,options,resize,winpos,tabpages
    "make unix & win can understand each other's session file.
    set sessionoptions+=unix,slash
    "execute 'mksession! $VIMLOCAL/sessions/session.vim'
    "execute 'mkview     $VIMLOCAL/sessions/view.vim'
endfunction

function! LoadSession()
    "execute 'source   $VIMLOCAL/sessions/session.vim'
    "execute 'loadview $VIMLOCAL/sessions/view.vim'
endfunction

"open files under current folder.
nmap <Leader>e :e <C-R>=expand("%:p:h") . "\\" <CR>
