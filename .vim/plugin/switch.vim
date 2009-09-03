"         name: Switch
"      summary: Quickly toggle boolean options between 'on' and 'off'
"      version: 0.12
"      license: GPL
"     requires: Vim 7+
"    script id: 2214
"  last change: 2009 Feb 25
"      creator: Tomas RC
" co-developer: Andy Wokula   
"      project: Univrc
"        email: univrc@gmail.com
"         site: http://univrc.org/
" 
"          use: # get help : <C-Q><Tab>
"               # toggle   : <C-Q>{key}

" {{{1 [comments]                 
    " {{{2 [changes]                  
        " {{{3 2008 Jul 07  \A/  v. 0.10  
"   Andy Wokula <anwoku@yahoo.de>
"
" Added: Added <C-Q><Tab>, which is more  intuitive.  If I look for completions
" in the command-line I always try Tab and never Space.
"
" Added: accept a choice also when the  user forgets to release CTRL, first try
" the lower then the upper case letter; doesn't work always, e.g. Ctrl-C always
" breaks, Ctrl-I is like <Tab>; where  possible, conversion is done:  Ctrl-@ ->
" "J".  Another problem: unwanted setting of "m" if Enter is pressed, therefore
" convert Ctrl-M (Enter) to " ". Conversion to " " ignores a flag.
"
" Added: there are three places where options are remembered:
" - the s:sys dictionary
" - s:defaults (string) to remember defaults (does never change)
" - g:switch_options (string) for user settings (to modify or replace defaults)
"
" Added: interface  mapping <Plug>SwitchOption  in case  the user  doesn't like
" Ctrl-Q
"
" Added: after  printing help with <C-Q><Space>,  the screen is not  cleared if
" the user continues  with Command-line mode (by typing ":"  or Ctrl-U to clear
" ":switch").  Very  useful to  edit the g:switch_options  variable, or  to get
" help  on an  option.   And it's  more  close  to the  behavior  of other  Vim
" commands.  In this situation, both keys take precedence over <C-Q>: or <C-Q>u
" mappings.
"
" Added: after printing help with <C-Q><Space>, another <C-Q> redraws and shows
" the ":switch" prompt (instead of trying to set the "q" option).
"
" Added:  the  user  can  press  <F1>  to  get  help  on  an  option;  e.g.  to
" get  help on  'expandtab' he  can  press <C-Q><F1>e  or <C-Q><Space><F1>e  or
" <C-Q><F1><Space><F1>e; pressing  <F1> two times in  a row quits.  Ok,  now we
" have a really big messy function <SID>Switch().
"
" Changed: massive change to the set of available default options:
" -   removed   flags: D:digraph,   E:expandtab,   f:foldenable,   F:rightleft,
" g:ignorecase, G:magic, K:writebackup, N:icon, O:confirm, o:readonly, t:title,
" U:autoindent, u:secure, V:revins, v:visualbell
" -   changed    flags:   a:showmatch->a:autoindent,   c:cindent->c:ignorecase,
" e:errorbells->e:expandtab, r:ruler->r:readonly
"
" Changed:  now sets  the  local value  of  an option  (not  the global  value;
" :setlocal sets the global value anyway if there is no local value)
"
" Changed: include the key that was rejected in the message
"
" Changed: now  uses the full screen  width to show available  options (several
" columns)
"
" Changed: After pressing  <C-Q><Space>, don't  require another  <C-Q>, instead
" show the :switch prompt immediately
"
" Fix: test for non-existant option names caused an error
"
" Fix: the  escape key  shouldn't give  an error (also  keys with  empty return
" char)
"
" ... some more ...
        " }}}3
        " {{{3     2008 Jul 26       v. 0.11  
" Added:  The switch functionality now  works, optionally, in visual and insert
" modes as  well.  Note  that switch.vim  uses one  mapping for  each activated
" mode.  The  default mapping key is  <C-Q> (Ctrl-q).  The mapping  keys can be
" changed in  the [setting up]  -> [mappings]  section, in the  following three
" lines:
"          - nmap <silent> <C-Q> <Plug>SwitchOption
"          - imap <silent> <C-Q> <Plug>SwitchOption
"          - xmap <silent> <C-Q> <Plug>SwitchOption
"           
" Changed: In the listing, an option name is prepended with "no", if the option
" is currently turned on and a key press will turn it off. (By Andy Wokula)
"
" Changed: All global variables are now converted to script-local variables.
"
" Changed: The  sections  were reorganized  a  bit.   All user  configurations,
" except for the mapping keys, now lies in the [configuration] section.
"
        " }}}3
        " {{{3     2008 Jul 30       v. 0.12  
" Added: Now the map keys can also be defined in the [configuration] section.
" They can be easily defined in any of the following fashions: 
"
"    if !exists("g:switch_map_keys") 
"        let g:switch_map_keys  = {  'normal' : ""
"                                 \, 'insert' : "<C-Q>"
"                                 \, 'visual' : "_" }
"
" Thanks to godlygeek for the " eval('"'.'\'.map.'"') " solution.
"
" Fixed: One global variable was not being removed.
"
        " }}}3
        " {{{3     2009 Feb 25       v. 0.13  
" Changed: Small improvement on the options help table
        " }}}3

    " {{{2 [documentation]            

" This plugin  enables you  to toggle  any Vim boolean  options between  'on' and
" 'off' using just one key mapping for each working mode. That works, by default,
" in three  different modes  (normal, visual  and insert),  using three  maps (if
" free).
" 
" How to use it
"     Two lines quick guide
"         * get help : <C-Q><Tab>
"         * toggle option: <C-Q>{char} | where char represents a boolean option  
" 
"     Five lines quick guide
"         By default, the map key is  (<C-Q>). Following the map key, 
"         * a character toggles the value of the boolean option it represents
"         * <Tab> or <Space> prints the available char-option pairs
"         * <F1> +  character opens the help page of its related option 
"         * <Esc> escapes 
" 
" How to configure it
"     All  user configurable  definitions are  present in  the [configuration]
"     section and can be also defined in your .vimrc, if wanted:
"     
"             1. g:switch_options (string) Default : ""
"             2. g:switch_help_header (boolean) Default : 1
"             3. g:switch_help_leftalign (boolean) Default : 0
"             4. g:switch_map_modes (dictionary) Default (value entry): 1 
"             5. g:switch_map_keys (dictionary) Default (value entry): 1 
"             6. g:switch_default (string)
"
"         1. g:switch_options (string) Default: ""
" 
"             It  customizes the  existent  key-option pairs. It  can have  three
"             different meanings:
"                 * "" : Use the default set of key-option pairs
"                 * "L:cursorline" : Use exclusively the two defined pairs
"                 * "., l:list" : Use the default set (.) plus the two pairs. 
" 
"         Example: let g:switch_options = "., e:expandtab, k" 
"         With ".," at  the begin, start with the  default set. Following entries
"         either add/replace "key:option"  pairs or remove keys  if the ":option"
"         part is missing. Separator is "," followed by optional white space. The
"         example makes <C-Q>e toggle 'expandtab' and <C-Q>k raise an error. (bad
"         example, "e" already is in the defaults).
" 
"         2. g:switch_help_header (boolean) Default: 1
"             If on, show header lines. 
" 
"         3. g:switch_help_leftalign (boolean) Default: 0
"             If off, make displaying the options look more like centering (about
"             1/3 of white space before, 2/3 after).
" 
"         4. g:switch_map_modes (dictionary) Default (value entry): 1
"             Define in which Vim modes the plugin will by operational Each entry
"             key is a  Vim mode and each  value is a boolean  that authorizes or
"             not the activation of pair mode.
" 
"         5. g:switch_map_keys (dictionary) Default (value entry): 1
"             Define the mapping key for each of the three operating modes.
" 
"         6. g:switch_default (string) 
"             Define the default pairs char:option.
"
" 
" ? To see the list of the available boolean options type :set inv<C-D>
" ! Lots of thanks to Andy Wokula, who made this humble plugin much nicer
" @ This plugin is related to the Univrc project (http://univrc.org)

    "}}}2

" {{{1 [script init]              
if exists('loaded_switch')
    finish
endif
let loaded_switch = 1

if v:version < 700 || &cp
    echomsg "Switch: you need at least Vim 7.0 and 'nocp' set"
    finish
endif

" {{{1 [configuration]            
if !exists("g:switch_options")
    let g:switch_options = ""
endif

if !exists("g:switch_help_header")
    let g:switch_help_header = 1
endif

if !exists("g:switch_help_leftalign")
    let g:switch_help_leftalign = 0
endif

if !exists("g:switch_map_modes")
    let g:switch_map_modes = {  'normal' : 1
                             \, 'insert' : 1
                             \, 'visual' : 1 }
endif

if !exists("g:switch_map_keys") 
    let g:switch_map_keys  = {  'normal' : "<C-Q>"
                             \, 'insert' : "<C-Q>"
                             \, 'visual' : "<C-Q>" }
endif

if !exists("g:switch_default")
    let g:switch_default = 
            \ "A:autochdir, B:scrollbind, C:cursorcolumn, H:hidden"
            \.", I:infercase, L:cursorline, M:showmode, P:wrapscan"
            \.", S:showcmd, W:autowrite, a:autoindent"
            \.", b:linebreak, c:ignorecase, d:diff, e:expandtab, h:hlsearch"
            \.", i:incsearch, j:joinspaces, k:backup, l:list, m:modifiable"
            \.", n:number, p:paste, r:readonly, s:spell, w:wrap, z:lazyredraw"
endif

" {{{1 [setting up]               
    " {{{2 [variables]                   
let s:defaults       = g:switch_default
let s:options        = g:switch_options
let s:map_modes      = g:switch_map_modes
let s:map_keys       = g:switch_map_keys 
let s:help_header    = g:switch_help_header
let s:help_leftalign = g:switch_help_leftalign
" remember the previous g:switch_options value to avoid redundant updates:
let s:old_options = "~(_8(I)"
 
    " {{{2 [mappings]                 

if !hasmapto("<Plug>SwitchOption","nvic") 
    if s:map_modes.normal == 1  
        exe "nmap <silent> ".s:map_keys['normal']." <Plug>SwitchOption"
    endif
    if s:map_modes.insert == 1  
        exe "imap <silent> ".s:map_keys['insert']." <Plug>SwitchOption"
    endif
    if s:map_modes.visual == 1  
        exe "xmap <silent> ".s:map_keys['visual']." <Plug>SwitchOption"
    endif

    nnoremap <Plug>SwitchOption :<C-U>call <SID>Switch('normal')<CR>
    inoremap <Plug>SwitchOption <C-O>:<C-U>call <SID>Switch('insert')<CR>
    xnoremap <Plug>SwitchOption <ESC>:<C-U>call <SID>Switch('visual')<BAR>:normal gv<CR>
endif

    " }}}2

" {{{1 [functions]                
func! s:GetUserSettings() "{{{
    " if !exists("s:options")
    "     let s:options = ""
    " endif
    if s:old_options == s:options
        return
    endif
    let s:old_options = s:options
    let s:sys = {}
    let modify = s:options[0:1] == ".,"
    if modify || s:options == ""
        for flagmap in split(s:defaults, ',\s*')
            let s:sys[flagmap[0]] = flagmap[2:]
        endfor
        if modify
            let s:options = matchstr(s:options, '^\.,\s*\zs.*')
        endif
    endif
    if s:options != ""
        for flagmap in split(s:options, ',\s*')
            if strlen(flagmap) >= 4
                let s:sys[flagmap[0]] = flagmap[2:]
            else
                sil! unlet s:sys[flagmap[0]]
            endif
        endfor
    endif
    if modify
        let s:options = s:old_options
    endif
endfunc "}}}
func! Switch_PrintOptions() "{{{
    call s:GetUserSettings()

    let nentries = len(s:sys)
    let maxoptlen = 5 + max(map(values(s:sys),'strlen(v:val)'))
    let colwidth = 2 + 1 + 3 + maxoptlen + 2
    let ncolumns = (&columns-1) / colwidth
    if ncolumns > 0
        let nlines = nentries / ncolumns + (nentries % ncolumns > 0)
        if s:help_leftalign
            let prewidth = 0
        else
            if nlines > 1
                let ncolumns = nentries / nlines + (nentries % nlines > 0)
                let prewidth = ((&columns-1) - ncolumns*colwidth) / 3
            else
                " the old setting, slightly wrong
                let prewidth = (&columns-1) % colwidth / 3
            endif
        endif
        let prespaces = repeat(" ", prewidth)
        let fmtstr = "  %s : %.". maxoptlen. "s  "
    else
        let ncolumns = 1
        let nlines = nentries
        let prespaces = ""
        let fmtstr = "%s : %.". maxoptlen. "s"
    endif

    if s:help_header
        let headline = prespaces. "  Dictionary of boolean options  "
        if strlen(headline) <= &columns - 1
            echo prespaces. "  Get help: Press F1 {flag}"
            echo "\n"
        else
            let headline = prespaces. "  Options  "
        endif
        echohl PreProc
        echo headline
        echohl none
        echo "\n"
    endif

    let list = []
    for entry in items(s:sys)
        call add(list, [entry[1], entry[0]])
    endfor
    call sort(list)

    let filler = repeat(" ", maxoptlen)
    let lidx = 0
    while lidx < nlines
        let line = prespaces
        let cidx = lidx
        while cidx < nentries
            let entry = list[cidx]
            let status = eval("&". entry[0]) ? "[on] " : "     "
            let line .= printf(fmtstr, entry[1], status.entry[0].filler)
            let cidx += nlines
        endwhile
        echo line
        let lidx += 1
    endwhile
    echo "\n"
    " not a bug: it is normal if not all columns are used
endfunc "}}}
func! <SID>Switch(mode,...) "{{{
    " a:1 -- (boolean) redraw after showing help (internal use only)
    let recursive = a:0>=1 && a:1
    echo ":switch "
    let gotchar = getchar()
    let showhelp = gotchar=="\<F1>"
    let flag = nr2char(gotchar)
    let map = s:map_keys[a:mode]
    if recursive
        if flag =~ "[:\<C-U>]"
            call feedkeys(":")
            return
        elseif flag =~ '\s'
            redraw
            return
        elseif flag == eval('"'.'\'.map.'"')
            redraw
            call feedkeys("\<Plug>SwitchOption")
            return
        endif
    endif
    if showhelp
        if !recursive
            redraw
        endif
        echo ":switch help "
        let flag = nr2char(getchar())
        if recursive && flag =~ '\s'
            redraw
            return
        endif
    endif
    if flag == "" || flag == "\e"
        redraw
        return
    elseif flag =~ '\s'
        call Switch_PrintOptions()
        call <SID>Switch(a:mode,1)
        return
    endif
    call s:DoOption(flag, showhelp)
endfunc "}}}
func! s:DoOption(flag, showhelp) "{{{
    let flag = a:flag
    call s:GetUserSettings()
    try
        let sav_dy = &dy
        set display-=uhex
        " strtrans() depends on 'display'
        let optname = ""
        if has_key(s:sys, flag)
            let optname = s:sys[flag]
        else
            let tryctrl = tr(strtrans(flag),"@M","J ")
            if strlen(tryctrl)==2 && tryctrl[0] == "^"
                let flag = tolower(tryctrl[1])
                if has_key(s:sys, flag)
                    let optname = s:sys[flag]
                else
                    let flag = toupper(tryctrl[1])
                    if has_key(s:sys, flag)
                        let optname = s:sys[flag]
                    else
                        let flag = tolower(flag)
                    endif
                endif
            endif
        endif
        if flag == " "
            return
        endif
        redraw
        if optname == ""
            echohl WarningMsg
            echomsg 'Switch: Key "'.strtrans(flag).'" not found in the boolean options dictionary!'
            echohl none
            return
        endif
        if exists("+". optname)
            if a:showhelp
                exec "help '". s:sys[flag]."'"
            else
                exec "setlocal" optname."!" optname."?"
            endif
        else
            echohl WarningMsg
            echo "Switch: Not a working option: '". optname. "'"
            echohl none
            return 1
        endif
    finally
        let &dy = sav_dy
    endtry
endfunc "}}}

" {{{1 [cleaning]                 
unlet g:switch_default
unlet g:switch_options
unlet g:switch_help_header
unlet g:switch_help_leftalign
unlet g:switch_map_modes
unlet g:switch_map_keys


" vim:set fen fdm=marker fdl=0 
