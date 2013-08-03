#!/usr/bin/env python

import glob
import sys
import os
import os.path
import subprocess

SOURCE_DIR = "../compiler"
DESTINATION_DIR = "."

PARSER = "../parser/taulap"
TRANSLATOR = "./taula2py"


for dirpath, dirnames, filenames in os.walk(SOURCE_DIR):
    base_dirpath = os.path.relpath(dirpath, SOURCE_DIR)
    destination_dirpath = os.path.join(DESTINATION_DIR, base_dirpath)

    try:
        os.mkdir(destination_dirpath)
    except OSError:
        pass

    for filename in filenames:
        pathname = os.path.join(dirpath, filename)
        base_pathname, source_ext = os.path.splitext(os.path.relpath(pathname, SOURCE_DIR))

        if source_ext == ".ta":
            ta_filename = os.path.join(SOURCE_DIR, base_pathname) + ".ta"
            tap_filename = os.path.join(DESTINATION_DIR, base_pathname) + ".tap"
            py_filename = os.path.join(DESTINATION_DIR, base_pathname) + ".py"

            print "Compiling", ta_filename
            subprocess.call([PARSER, "-o", tap_filename, ta_filename])
            print "Translating", ta_filename
            subprocess.call([TRANSLATOR, tap_filename])

            sys.exit(0)

