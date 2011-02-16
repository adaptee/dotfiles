
" '=' is rarely used in filename
" besides, it causes C-x C-f fail with  "PATH=/usr/share/..."
setlocal isfname-==

"" $ is frequently used in shell script
inoremap <buffer> 4 $
inoremap <buffer> $ 4
