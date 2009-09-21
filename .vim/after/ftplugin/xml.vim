" added and modified by adaptee manually, not by any plugin.


" environment variable XMLLINT_INDENT controls the indentation margin.
" here, we set it to 4 spaces.
setlocal equalprg=XMLLINT_INDENT\=\"\ \ \ \"\ xmllint\ --format\ -

" It's really a pity that tidy does not support the customization of indentation margin.
setlocal equalprg=tidy\ -indent\ -xml\ -quiet --indent-spaces 4
