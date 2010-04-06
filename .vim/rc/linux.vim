" In linux, UTF-8 is your best choice
set encoding=utf-8

" behaves well under both Linux/Windows/Mac
set fileformats=unix,dos,mac

" Fast reading of .vimrc
nmap <silent> <leader>v :call SwitchToBuffer("$HOME/.vimrc")<CR>

" When vimrc or sub-vimrc is edited and saved, reload vimrc automatically
autocmd! bufwritepost .vimrc source $HOME/.vimrc
autocmd! bufwritepost $VIMLOCAL/rc/*.vim source $HOME/.vimrc

"autocmd VimEnter * call LoadSession()
"autocmd VimLeave * call SaveSession()

function! SaveSession()
    set sessionoptions=buffers,folds,globals,options,resize,winpos,tabpages
    "make Unix & Win can understand each other's session file.
    set sessionoptions+=unix,slash
    execute 'mksession! ~/.vim_session.vim'
endfunction

function! LoadSession()
    execute 'source ~/.vim_session.vim'
endfunction

" open files under current folder.
nmap <Leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

" Note, if we only use gvim, then <A-1> will be OK.
" However, terminal support is necessary.
" So, here we make some dirty hacking.
"
" toggle search result highlight, too
set <M-1>=1
"nnoremap <silent><M-1> <Esc>:set invhlsearch<CR>
nnoremap <silent><M-1> <Esc>:nohlsearch<CR>:echo<Space>'nohlsearh'<CR>

" toggle the showing of TAB and trailing white-spaces.
set <M-2>=2
nnoremap <silent><M-2> <Esc>:set<Space>invlist<CR>:set<Space>list?<CR>

" toggle and show current pasting status
set <M-3>=3
nnoremap <M-3> <Esc>:set<Space>invpaste<CR>:set<Space>paste?<CR>

" open previous file.
set <M-4>=4
nnoremap <M-4> <Esc>:e #<CR>

" enable/disable spell checking
set <M-5>=5
nnoremap <M-5> <Esc>:setlocal<Space>invspell<CR>:setlocal<Space>spell?<CR>

" Now 'K' invokes external cmd 'manall' , which will man all items with the same name
"set keywordprg = manall
"set keywordprg = myman

" look up current word in the dictionary
nmap <Leader>k :!clear;sdcv "<cword>"<CR>

" Use ':W'" to write to files even when we forget to use sudo when launching vim
command! -bar -nargs=0 W :silent exe "w !sudo tee % > /dev/null" | silent edit!
