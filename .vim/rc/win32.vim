" In windows , use cp936 as internal encoding
" ugly choice, but windows is ugly itself...
set encoding=cp936

" behaves well under both Linux/Windows/Mac
set fileformats=dos,unix,mac

" Fast  viewing vimrc
nnoremap <silent> <leader>v :call Gf("$VIM/_vimrc")<CR>

" When vimrc or sub-vimrc is edited and saved, reload vimrc automatically
autocmd! BufWritePost _vimrc source $VIM/_vimrc
autocmd! BufWritePost $VIMLOCAL/rc/*.vim source $VIM/_vimrc

"autocmd VimEnter * call LoadSession()
"autocmd VimLeave * call SaveSession()

function! SaveSession()
    set sessionoptions=buffers,folds,globals,options,resize,winpos,tabpages
    "make Unix & Win can understand each other's session file.
    set sessionoptions+=unix,slash
    execute 'mksession! $VIM/vim_session.vim'
    execute 'mkview     $VIM/vim_view.vim'
endfunction

function! LoadSession()
    execute 'source   $vim/vim_session.vim'
    execute 'loadview $vim/vim_view.vim'
endfunction

" open files under current folder.
nnoremap <Leader>o :e <C-R>=expand("%:p:h") . "\\" <CR>
cnoremap <C-o> edit <C-R>=expand("%:p:h") . "\\" <CR>

" In windows, we generally only use gvim.
" So,<A-1> will work fine. NO dirty hacking is needed.

" toggle search result highlight, too
nnoremap <silent><M-1> <Esc>:set invhlsearch<CR>:set<Space>hlsearch?<CR>

" toggle the showing of TAB and trailing white-spaces.
nnoremap <silent><A-2> <Esc>:set<Space>invlist<CR>:set<Space>list?<CR>

" toggle and show current pasting status
nnoremap <A-3> <Esc>:set<Space>invpaste<CR>:set<Space>paste?<CR>

" open previous file.
nnoremap <silent><A-4> <Esc>:e #<CR>

" enable/disable spell checking
nnoremap <A-5> <Esc>:setlocal<Space>invspell<CR>:setlocal<Space>spell?<CR>

