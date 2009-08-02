"Sad fact,*nix only accept formal locale name such as 'en_US.utf-8'
"But, Windows only accept short locale name such as 'en'
"use english UI, because I don't need chinese prompt when using vim.
"language en_US.utf-8
language messages en_US.utf-8


"Fast reading of .vimrc
nmap <silent> <leader>r :call SwitchToBuf("$HOME/.vimrc")<CR>

"When .vimrc or sub-vimrc is edited and saved, reload vimrc automaticaly
autocmd! bufwritepost .vimrc source $HOME/.vimrc
autocmd! bufwritepost $VIMLOCAL/rc/*.vim source $HOME/.vimrc


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

"lookup current word in the dictionary
nmap <Leader>k :!clear;sdcv "<cword>"<CR>


" Note, if we only use gvim, then <A-1> will be ok.
" However, terminal support is necessary.
" So, here we make some dirty hacking.
"
" toggle search result highlight, too
set <M-1>=1
nnoremap <silent><M-1> <Esc>:set invhlsearch<CR>

" togggle the showing of TAB, trailing ws.
set <M-2>=2
nnoremap <silent><M-2> <Esc>:set invlist<CR>

" toggle and show current pasting status
set <M-3>=3
nnoremap <M-3> <Esc>:set invpaste<CR>:set paste?<CR>

" open previsous file.
set <M-4>=4
nnoremap <M-4> <Esc>:e #<CR>


