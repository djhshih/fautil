#!/bin/bash

# Assuming that complete set of headers and source files are at
# `orig/inc` and `orig/lib`, this scripts copies required files
# to a new destination

get_dep() {
	#echo $1
	./getdeps.py $1 \
		--include_path orig/inc --source_path orig/lib \
		--dest_include_path src/include --dest_source_path src/lib
}

for x in src/utils/*/*.c; do
	get_dep $x
done

# copy over source files that do not share the same name with the header file

# portable.h
cp orig/lib/{osunix.c,oswin9x.c} src/lib

# fuzzyFind.h
cp orig/lib/{ffAli.c,ffScore.c,fuzzyShow.c} src/lib
cp orig/jkOwnLib/{fuzzyFind.c,ffAliHelp.c} src/lib


# copy the dependencies of the source files

for x in src/lib/*.c; do
	get_dep $x
done	

for x in src/lib/*.c; do
	get_dep $x
done	


# copy misplaced header files

misplaced=(portimpl colHash gemfont)

for x in ${misplaced[@]}; do
	cp orig/lib/${x}.c src/lib
	cp orig/lib/${x}.h src/include
done

cp orig/lib/vGfxPrivate.h src/include


# copy stragglers

stragglers=(vGfx pipeline memalloc dlist axt pairHmm kxTok)

for x in ${stragglers[@]}; do
	cp orig/inc/${x}.h src/include
	cp orig/lib/${x}.c src/lib
done

cp orig/lib/axtAffine.c src/lib
cp orig/lib/wildcmp.c src/lib
cp orig/lib/intExp.c src/lib

