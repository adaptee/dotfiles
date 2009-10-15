" setup necessary environment variables
if has('unix')
    let $VIMLOCAL=$HOME.'/.vim'
elseif has ('win32')
    let $VIMLOCAL=$VIM.'/vimfiles'
endif

source $VIMLOCAL/rc/function.vim
source $VIMLOCAL/rc/basic.vim
source $VIMLOCAL/rc/plugin.vim

if has('unix')
    source $VIMLOCAL/rc/linux.vim
elseif has ('win32')
    source $VIMLOCAL/rc/win32.vim
endif

if has('gui_running')
    source $VIMLOCAL/rc/gui.vim
endif

" for testing un-confirmed setting
source $VIMLOCAL/rc/test.vim

