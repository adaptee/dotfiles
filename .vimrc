" setup necessary environment variables
if has('unix')
    let $VIMLOCAL=$HOME.'/.vim'
elseif has ('win32')
    let $VIMLOCAL=$VIM.'/vimfiles'
endif

source $VIMLOCAL/rc/basic.vim
source $VIMLOCAL/rc/plugin.vim

source $VIMLOCAL/rc/linux.vim

if has("gui_running")
    source $VIMLOCAL/rc/gui.vim
endif
