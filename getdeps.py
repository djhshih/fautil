#!/usr/bin/env python3

import argparse
import subprocess
import os
import shutil

pr = argparse.ArgumentParser("Retrieve C dependency files")
pr.add_argument("target", help = "target C source file")
pr.add_argument("--include_path", help = "path to C header files", default = ".")
pr.add_argument("--source_path", help = "path to C source files", default = ".")
pr.add_argument("--dest_include_path", help = "destination path for header files", default = "out/include")
pr.add_argument("--dest_source_path", help = "destination path for source files", default = "out/src")

argv = pr.parse_args()

target = argv.target
include_path = argv.include_path
source_path = argv.source_path
dest_include_path = argv.dest_include_path
dest_source_path = argv.dest_source_path

cmd = "gcc -MM " + target + " -I" + include_path

out = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout.read()
parts = out.decode().split()

# first element is the object, second is the target source file
# execept for continuation characters, everything else should be header files
headers = [x for x in parts[2:] if x != '\\']

def modify_path(x, new_path, new_ext=None):
    fname = x.split('/')[-1]
    if new_ext is not None:
        fname = os.path.splitext(fname)[0] + new_ext
    return os.path.join(new_path, fname)


# replace include path with source path
# assume the source files have the same name as the header files
sources = [modify_path(x, source_path, ".c") for x in headers]


dest_headers = [modify_path(x, dest_include_path) for x in headers]
dest_sources = [modify_path(x, dest_source_path) for x in sources]


if not os.path.exists(dest_include_path):
    os.makedirs(dest_include_path)

if not os.path.exists(dest_source_path):
    os.makedirs(dest_source_path)


def copy_file(src, dest):
    if os.path.exists(src):
        if not os.path.exists(dest):
            shutil.copy(src, dest)
    else:
        print("Warning: file does not exist: {}".format(src))


# copy files over
for x, y in zip(headers, dest_headers):
    copy_file(x, y) 

for x, y in zip(sources, dest_sources):
    copy_file(x, y) 

