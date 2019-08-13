# -*- coding: utf-8; mode: _tcl; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- vim:fenc=utf-8:ft=tcl:et:sw=2:ts=2:sts=2

set user.ver.clang  8.0
set user.ver.gcc    10
set user.ver.perl   5.28
set user.ver.ruby   2.6
set ruby.branch     ${user.ver.ruby}
set user.ver.php    7.3
set user.py.dot     3.7
set user.py.nodot   37
set user.arch       x86_64
set user.ghub       gaming-hacker
# set user.ver.intel  2018.3.185
# set user.intel.root /opt/intel/compilers_and_libraries_${user.ver.intel}/mac
# set user.tbb.inc    ${user.intel.root}/tbb/inc
# set user.tbb.lib    ${user.intel.root}/tbb/lib
# set user.mkl.root   ${user.intel.root}/mkl
# set user.mkl.inc    ${user.intel.root}/mkl/inc
# set user.mkl.lib    ${user.intel.root}/mkl/lib
# set user.ipp.inc    ${user.intel.root}/ipp/inc
# set user.ipp.lib    ${user.intel.root}/ipp/lib
# set user.daal.inc   ${user.intel.root}/daal/inc
# set user.daal.lib   ${user.intel.root}/daal/lib

set user.CFLAGS "-O3 -pipe -m64 -arch x86_64 -march=native -mtune=native -mmacosx-version-min=10.13 -fomit-frame-pointer -fno-common -mavx -mavx2 -mfma -mfpmath=sse -msse2 -msse3 -msse4.1 -msse4.2"

set user.WNO "-Wno-unknown-warning-option -Wno-unused-function -Wno-unused-variable -Wno-unused-command-line-argument -Wno-ignored-optimization-argument"

set user.MACROS "-DLEVEL1_DCACHE_LINESIZE=64 -DLEVEL1_DCACHE_SIZE=32 -DLEVEL2_DCACHE_SIZE=256 -DHASWELL -DL1_DATA_SIZE=32768 -DL1_DATA_LINESIZE=64 -DL2_SIZE=262144 -DL2_LINESIZE=64 -DDTB_DEFAULT_ENTRIES=64 -DDTB_SIZE=4096 -DHAVE_AVX -DHAVE_AVX2 -DHAVE_CFLUSH -DHAVE_CMOV -DHAVE_FMA3 -DHAVE_MMX -DHAVE_PSE -DHAVE_SSE -DHAVE_SSE2 -DHAVE_SSE3 -DHAVE_SSSE3 -DSSE4_1 -DHAVE_SSE4_2 -DHAVE_VFPV3 -DHAVE_OPENCL -D_REENTRANT -D_THREAD_SAFE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -DHAVE_NASM -DNDEBUG -DPIC -DUSE_PTHREAD"

set universal_variant   no
set supported_archs     x86_64
set configure.ccache    no
set use_parallel_build  yes
set autoreconf.args     -fvi
set livecheck.type      none
set platforms           darwin

set configure.compiler  macports-clang-${user.ver.clang}

set configure.cc       ${prefix}/bin/clang-mp-${user.ver.clang}

set configure.cflags   "${user.CFLAGS} ${user.WNO} ${user.MACROS} -std=c11 -stdlib=libc++"

set configure.cxx      "${prefix}/bin/clang++-mp-${user.ver.clang}"

set configure.cxxflags "${user.CFLAGS} ${user.WNO} ${user.MACROS} -std=c++11 -stdlib=libc++"

set configure.cpp      "${prefix}/bin/clang-cpp-mp-${user.ver.clang} -E"

set configure.env ${user.MACROS}

set configure.optflags ${user.CFLAGS}

set minimum_xcodeversions {17 10.0}

set user.config.default  "--quiet --disable-option-checking  --enable-shared --disable-static  --enable-silent-rules --enable-fast-install --enable-pic --with-pic --disable-dependency-tracking --enable-libtool-lock --disable-debug --disable-example --enable-simd --enable-asm --enable-libc++ --enable-sse"
