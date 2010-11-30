""" User configuration file for IPython

This is a more flexible and safe way to configure ipython than *rc files
(ipythonrc, ipythonrc-pysh etc.)

This file is always imported on ipython startup. You can import the
ipython extensions you need here (see IPython/Extensions directory).

Feel free to edit this file to customize your ipython experience.

Note that as such this file does nothing, for backwards compatibility.
Consult e.g. file 'ipy_profile_sh.py' for an example of the things
you can do here.

See http://ipython.scipy.org/moin/IpythonExtensionApi for detailed
description on what you could do here.
"""

# Most of your config files and extensions will probably start with this import

import IPython.ipapi
ip = IPython.ipapi.get()

# You probably want to uncomment this if you did %upgrade -nolegacy
#import ipy_defaults

import os

def main():

    # uncomment if you want to get ipython -p sh behaviour
    # without having to use command line switches
    # import ipy_profile_sh

    # Configure your favourite editor?
    # Good idea e.g. for %edit os.path.isfile

    #import ipy_editors

    # Choose one of these:
    #ipy_editors.scite()
    #ipy_editors.scite('c:/opt/scite/scite.exe')
    #ipy_editors.komodo()
    #ipy_editors.idle()
    # ... or many others, try 'ipy_editors??' after import to see them

    # Or roll your own:
    #ipy_editors.install_editor("c:/opt/jed +$line $file")


    # An example on how to set options
    o = ip.options

    o.autocall = 1
    o.autoedit_syntax = 1
    o.autoindent = 1
    o.automagic =  1

    o.cache_size = 1000
    o.classic = 0

    o.colors =  "Linux"
    o.color_info = 1

    o.confirm_exit =  0

    o.deep_reload = 1

    o.editor = "vim"

    o.log = 1

    o.banner = 1
    o.messages = 1

    o.pdb = 1
    o.pprint = 1

    o.prompt_in1 = 'In [\#]: '
    o.prompt_in2 = '   .\D.: '
    o.prompt_out = 'Out[\#]: '
    o.prompts_pad_left = 1

    o.readline = 1
    o.screen_length = 0


    o.quick = 0

    # problematic
    #o.separate_in   = '\n'
    #o.separate_out  = 0
    #o.separate_out2 = 0
    #o.nosep         = 0


    o.system_header  = "IPython system call: "
    o.system_verbose = 0

    o.wildcards_case_sensitive = 0

    o.xmode = "Context"

    # alway import_all those module
    #execf('~/.ipython/ns.py')

    # -- prompt
    # A different, more compact set of prompts from the default ones, that
    # always show your current location in the filesystem:
    #o.prompt_in1 = r'\C_LightBlue[\C_LightCyan\Y2\C_LightBlue]\C_Normal\n\C_Green|\#>'
    #o.prompt_in2 = r'.\D: '
    #o.prompt_out = r'[\#] '

    # Try one of these color settings if you can't read the text easily
    # autoexec is a list of IPython commands to execute on startup
    #o.autoexec.append('%colors LightBG')
    #o.autoexec.append('%colors NoColor')
    #o.autoexec.append('%colors Linux')

    # for sane integer division that converts to float (1/2 == 0.5)
    #o.autoexec.append('from __future__ import division')

    # For %tasks and %kill
    import jobctrl

    # For autoreloading of modules (%autoreload, %aimport)
    import ipy_autoreload

    # For winpdb support (%wdb)
    #import ipy_winpdb

    # For bzr completer, requires bzrlib (the python installation of bzr)
    #ip.load('ipy_bzr')

    # Tab completer that is not quite so picky (i.e.
    # "foo".<TAB> and str(2).<TAB> will work). Complete
    # at your own risk!
    #import ipy_greedycompleter



# some config helper functions you can use
def import_all(modules):
    """ Usage: import_all("os sys") """
    for m in modules.split():
        ip.ex("from %s import *" % m)

def execf(fname):
    """ Execute a file in user namespace """
    ip.ex('execfile("%s")' % os.path.expanduser(fname))

main()
