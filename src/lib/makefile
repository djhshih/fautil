kentSrc = ..
include ../inc/localEnvironment.mk
include ../inc/common.mk


O = \
aliType.o \
asParse.o \
axt.o \
axtAffine.o \
bPlusTree.o \
base64.o \
basicBed.o \
binRange.o \
bits.o \
cda.o \
chain.o \
colHash.o \
common.o \
dlist.o \
dnaseq.o \
dnautil.o \
dystring.o \
errAbort.o \
fa.o \
ffAli.o \
ffAliHelp.o \
ffScore.o \
filePath.o \
fuzzyFind.o \
fuzzyShow.o \
gemfont.o \
gfxPoly.o \
hash.o \
hex.o \
htmshell.o \
https.o \
internet.o \
linefile.o \
localmem.o \
memgfx.o \
memalloc.o \
net.o \
nib.o \
obscure.o \
options.o \
osunix.o \
pairHmm.o \
pipeline.o \
psl.o \
rangeTree.o \
rbTree.o \
seqOut.o \
sqlList.o \
sqlNum.o \
tokenizer.o \
twoBit.o \
udc.o \
vGfx.o \
verbose.o \
wildcmp.o \
kxTok.o \
intExp.o \
portimpl.o \
cheapcgi.o \

#mime.o \
#oswin9x.o \


LIBHTS_OBJS = \
../htslib/kfunc.o \
../htslib/knetfile.o \
../htslib/kstring.o \
../htslib/bgzf.o \
../htslib/faidx.o \
../htslib/hfile.o \
../htslib/hfile_net.o \
../htslib/hts.o \
../htslib/md5.o \
../htslib/regidx.o \
../htslib/sam.o \
../htslib/synced_bcf_reader.o \
../htslib/vcf_sweep.o \
../htslib/tbx.o \
../htslib/vcf.o \
../htslib/vcfutils.o \
../htslib/cram/cram_codecs.o \
../htslib/cram/cram_decode.o \
../htslib/cram/cram_encode.o \
../htslib/cram/cram_external.o \
../htslib/cram/cram_index.o \
../htslib/cram/cram_io.o \
../htslib/cram/cram_samtools.o \
../htslib/cram/cram_stats.o \
../htslib/cram/files.o \
../htslib/cram/mFILE.o \
../htslib/cram/open_trace_file.o \
../htslib/cram/pooled_alloc.o \
../htslib/cram/rANS_static.o \
../htslib/cram/sam_header.o \
../htslib/cram/string_alloc.o \
../htslib/cram/thread_pool.o \
../htslib/cram/vlen.o \
../htslib/cram/zfio.o

O += $(LIBHTS_OBJS)


$(MACHTYPE)/libfautil.a: $(O) $(MACHTYPE)
	ar rcus $(MACHTYPE)/libfautil.a $(O)

$(MACHTYPE):
	mkdir $(MACHTYPE)

test:
	cd tests && ${MAKE} test

clean:
	rm -f ${O} $(MACHTYPE)/libfautil.a
	cd tests && ${MAKE} clean

tags:
	etags ../inc/*.h ../lib/*.h ../lib/*.c  ../hg/inc/*.h ../hg/lib/*.h ../hg/lib/*.c ../hg/hgTracks/*.c ../hg/hgc/*.c ../hg/hgTrackUi/*.c
