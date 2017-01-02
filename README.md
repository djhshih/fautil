# FASTA utility package

This package is consists of select utility programs for working with FASTA
files.  It is forked from the `git://genome-source.cse.ucsc.edu/kent.git`
repository (commit: `6e41e8a48a74cb10e8d1455a51169f1ea8e2662a`) and it has been
restructued to ease compilation and installation. See `LICENSE.txt` for
conditions of use.


# Installation

Prerequisite: `libz` libraries and headers.

With `gcc >= 4.4`, you can simply

    make

The executables will be installed to `bin` within the package directory by
default, the header files to `include`, and the libraries to `lib`. You may
change `${DESTDIR}` to change the prefix of the install path by:

    DESTDIR=/usr/local make

