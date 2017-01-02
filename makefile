DESTDIR?=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all:
	mkdir -p ${DESTDIR}/{bin,include,lib}
	# make the static libraries
	cd src/htslib && make
	cd src/lib && make
	# make the programs
	cd src/utils/faAlign && make
	cd src/utils/faCat && make
	cd src/utils/faCmp && make
	cd src/utils/faCount && make
	cd src/utils/faFilter && make
	cd src/utils/faFilterN && make
	cd src/utils/faFrag && make
	cd src/utils/faGapLocs && make
	cd src/utils/faGapSizes && make
	cd src/utils/faLowerToN && make
	cd src/utils/faNoise && make
	cd src/utils/faOneRecord && make
	cd src/utils/faPolyASizes && make
	cd src/utils/faRandomize && make
	cd src/utils/faRc && make
	cd src/utils/faRenameRecords && make
	cd src/utils/faSimplify && make
	cd src/utils/faSize && make
	cd src/utils/faSomeRecords && make
	cd src/utils/faSplit && make
	cd src/utils/faToFastq && make
	cd src/utils/faToTab && make
	cd src/utils/faToTwoBit && make
	cd src/utils/faTrans && make
	cd src/utils/faTrimPolyA && make
	cd src/utils/faTrimRead && make
	cd src/utils/faUniqify && make
	cd src/utils/fastqToFa && make
	cd src/utils/twoBitInfo && make
	cd src/utils/twoBitToFa && make
	# copy over headers and static libraries
	cp -r src/include/* ${DESTDIR}/include
	cp -r src/htslib/htslib ${DESTDIR}/include
	cp -r src/lib/*/*.a ${DESTDIR}/lib

install:
	# already done during build

clean:
	rm -f src/*/*.o src/*/*/*.o src/lib/*/*.a

