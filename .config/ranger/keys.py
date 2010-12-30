#!/usr/bin/env python
# vim: set fileencoding=utf-8 :

"""
    Define your own keybindings
    (use ranger/defaults/keys.py as reference)
"""

from ranger.api.keys import *

browser = keymanager.get_context('browser')

# 'D'  for ':delete'
browser('D', fm.open_console('delete %s'))

# 'M' for ':mkdir'
browser('M', fm.open_console('mkdir '))

# 'F' for ':find'
browser('F', fm.open_console('find '))

# similar to 'j/k', but with larger step
browser('J', fm.move(down=3, relative=True))
browser('K', fm.move(up=3, relative=True))

# move around with even larger steps: half a page
browser('f', fm.move(down=0.5, pages=True))
browser('b', fm.move(up=0.5, pages=True))

# 'q'  for 'quit'
browser("q", fm.exit())

