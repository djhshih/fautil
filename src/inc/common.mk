CC=gcc
# to build on sundance: CC=gcc -mcpu=v9 -m64
COPTS=-O2 -Os -fdata-sections -ffunction-sections -Wl,--gc-sections
CFLAGS?=

ifeq (${MACHTYPE},)
    MACHTYPE:=$(shell uname -m)
#    $(info MACHTYPE was empty, set to: ${MACHTYPE})
endif
ifneq (,$(findstring -,$(MACHTYPE)))
#    $(info MACHTYPE has - sign ${MACHTYPE})
    MACHTYPE:=$(shell uname -m)
#    $(info MACHTYPE has - sign set to: ${MACHTYPE})
endif

HG_DEFS=-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_GNU_SOURCE -DMACHTYPE_${MACHTYPE}
HG_INC+=-I../include -I../../include -I../../../include -I../../../../include -I../../../../../include -I$(kentSrc)/htslib

# to check for Mac OSX Darwin specifics:
UNAME_S := $(shell uname -s)
# to check for builds on hgwdev
FULLWARN = $(shell uname -n)

L += -L$(kentSrc)/htslib -lhts -lz -lm

# pthreads is required
ifneq ($(UNAME_S),Darwin)
  L+=-pthread
endif

# pass through COREDUMP
ifneq (${COREDUMP},)
    HG_DEFS+=-DCOREDUMP
endif


SYS = $(shell uname -s)

ifeq (${HG_WARN},)
  ifeq (${SYS},Darwin)
      HG_WARN = -Wall -Wno-unused-variable -Wno-deprecated-declarations
      HG_WARN_UNINIT=
  else
    ifeq (${SYS},SunOS)
      HG_WARN = -Wall -Wformat -Wimplicit -Wreturn-type
      HG_WARN_UNINIT=-Wuninitialized
    else
      ifeq (${FULLWARN},hgwdev)
        HG_WARN = -Wall -Werror -Wformat -Wformat-security -Wimplicit -Wreturn-type -Wempty-body -Wunused-but-set-variable
        HG_WARN_UNINIT=-Wuninitialized
      else
        HG_WARN = -Wall -Wformat -Wimplicit -Wreturn-type
        HG_WARN_UNINIT=-Wuninitialized
      endif
    endif
  endif
  # -Wuninitialized generates a warning without optimization
  ifeq ($(findstring -O,${COPT}),-O)
     HG_WARN += ${HG_WARN_UNINIT}
  endif
endif

# this is to hack around many make files not including HG_WARN in
# the link line
COPT += ${HG_WARN}

SCRIPTS?=/bin
BINDIR?=/bin
DESTDIR?=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))/../..

# location of stringify program
STRINGIFY = ${DESTDIR}${BINDIR}/stringify

MKDIR=mkdir -p
STRIP?=true
CVS=cvs
GIT=git

# portable naming of compiled executables: add ".exe" if compiled on 
# Windows (with cygwin).
ifeq (${OS}, Windows_NT)
  AOUT=a
  EXE=.exe
else
  AOUT=a.out
  EXE=
endif


%.o: %.c
	${CC} ${COPT} ${CFLAGS} ${HG_DEFS} ${LOWELAB_DEFS} ${HG_WARN} ${HG_INC} ${XINC} -o $@ -c $<

