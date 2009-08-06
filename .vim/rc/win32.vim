"Fast reading of _vimrc
nmap <silent> <leader>r :call SwitchToBuf("$VIM/_vimrc")<CR>

"When vimrc or sub-vimrc is edited and saved, reload vimrc automatically
autocmd! bufwritepost _vimrc source $VIM/_vimrc
autocmd! bufwritepost $VIMLOCAL/rc/*.vim source $VIM/_vimrc

autocmd VimEnter * call LoadSession()
autocmd VimLeave * call SaveSession()

function! SaveSession()
    set sessionoptions=buffers,folds,globals,options,resize,winpos,tabpages
    "make Unix & Win can understand each other's session file.
    set sessionoptions+=unix,slash
    "execute 'mksession! $VIMLOCAL/sessions/session.vim'
    "execute 'mkview     $VIMLOCAL/sessions/view.vim'
endfunction

function! LoadSession()
    "execute 'source   $VIMLOCAL/sessions/session.vim'
    "execute 'loadview $VIMLOCAL/sessions/view.vim'
endfunction

"open files under current folder.
nmap <Leader>E :e <C-R>=expand("%:p:h") . "\\" <CR>

" In windows, we generally only use gvim.
" So,<A-1> will work fine. NO dirty hacking is needed.

" toggle search result highlight, too
nnoremap <silent><A-1> <Esc>:set invhlsearch<CR>

" toggle the showing of TAB and trailing white-spaces.
nnoremap <silent><A-2> <Esc>:set invlist<CR>

" toggle and show current pasting status
nnoremap <A-3> <Esc>:set invpaste<CR>:set paste?<CR>

" open previous file.
nnoremap <silent><A-4> <Esc>:e #<CR>

" enable/disable spell checking
nnoremap <A-5> <Esc>:setlocal invspell<CR>:setlocal spell?<CR>

