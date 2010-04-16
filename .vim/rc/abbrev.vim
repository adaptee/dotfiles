"--------------------------------------------------------------------------"
"                                abbreviation                               "
"--------------------------------------------------------------------------"

" auto-correct typo
iab teh         the
iab scr         src
iab fro         for
iab taht        that
iab sned        send
iab itme        item
iab evla        eval
iab prot        port
iab serach      search
iab cosnt       const
iab toogle      toggle
iab partion     partition
iab htis        this
iab tihs        this
iab funciton    function
iab fucntion    function
iab funtion     function
iab retunr      return
iab reutrn      return
iab sefl        self
iab eslf        self
iab candicate   candidate
iab seperate    separate
iab enbale      enable
iab unavailabe  unavailable
iab encounting  encountering
iab defalut default
iab sepcified  specified
iab bakcup backup
iab processs process
iab canonicalize canonicalize
iab accessable accessible
iab commmand command
iab commmad  command
iab follwo follow
iab utilily utility
iab tranform transform
iab specifiles specifies
iab charater character
iab maxmize maximize
iab approriate appropriate
iab throuth through
iab hlep help
cab hlep help
iab yuo you
iab YOu You
iab eralier earlier
iab similiar similar
iab ti it
iab ot to
iab fo of
iab fra far
iab edn end
iab tha the
iab waht what
iab tehn then
iab othre other
iab place palce
iab elemenet element
iab elmeent element
iab wihch which
iab standarsd  stardards
iab standrad  stardard
iab alghough although
iab docuemnt document

" reduce key-typing;come on, lazy boy!
iab ok      OK
iab ad      advertisement
iab abbr    abbreviation
iab autom   automatically
iab i18n    Internationalization
iab l10n    Localization
iab posix   POSIX
iab envir   environment
iab fst     first
iab scd     second
iab misc    miscellaneous
iab kath    Katherine
iab attr    attribute
iab chinese Chinese
iab english English
iab america America
iab spec    specification
iab appl application
iab appro appropriate
iab ms    Microsoft
iab gg    Google


" make entering the most frequently used command more easily
cab E   echo
cab G   grep
cab H   helpgrep
cab M   map
cab UM  unmap
cab IM  imap
cab IUM iunmap
cab CM  cmap
cab CUM cunmap
cab R   registers
cab S   set
cab V   verbose
cab P   pwd
cab -   cd -
cab kk  <C-m>


" some more instresting abbrevs

" insert date and time more easylit
" Format String              Example output
" -------------              --------------
" %c                         Thu 27 Sep 2007 07:37:42 AM EDT (depends on locale)
" %a %d %b %Y                Thu 27 Sep 2007
" %b %d, %Y                  Sep 27, 2007
" %d/%m/%y %H:%M:%S          27/09/07 07:36:32
" %H:%M:%S                   07:36:44
" %T                         07:38:09
" %m/%d/%y                   09/27/07
" %y%m%d                     070927
" %x %X (%Z)                 09/27/2007 08:00:59 AM (EDT)
" RFC822 format:
" %a, %d %b %Y %H:%M:%S %z   Wed, 29 Aug 2007 02:37:15 -0400
" ISO8601/W3C format (http://www.w3.org/TR/NOTE-datetime):
" %FT%T%z                    2007-08-29T02:37:13-0400
iab <expr> xdate  strftime("%F")
iab <expr> xtime  strftime("%F %H:%M:%S")
iab <expr> xlast  "Last Modified : " . strftime("%F")
iab xmail adaptee@gmail.com
iab xsig  Love Katherine

