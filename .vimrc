" setup necessary environment variables
" source OS-dependent config first
if has('unix')
    let $VIMLOCAL=$HOME.'/.vim'
    source $VIMLOCAL/rc/linux.vim
elseif has ('win32')
    let $VIMLOCAL=$VIM.'/vimfiles'
    source $VIMLOCAL/rc/win32.vim
endif

source $VIMLOCAL/rc/function.vim
source $VIMLOCAL/rc/basic.vim
source $VIMLOCAL/rc/plugin.vim
"source $VIMLOCAL/rc/autocorrect.vim

if has('gui_running')
    source $VIMLOCAL/rc/gui.vim
endif

" for testing un-confirmed setting
source $VIMLOCAL/rc/test.vim

