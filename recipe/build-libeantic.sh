#!/usr/bin/env bash
set -x

if [[ "$target_platform" == osx* ]]; then
    CXXFLAGS="$CXXFLAGS -fno-common"
fi

if [[ "$target_platform" == win* ]]; then
    cp $PREFIX/lib/gmp.lib $PREFIX/lib/gmpxx.lib
    CXXFLAGS="$CXXFLAGS -std=c++14"
fi

set +x

cd libeantic

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

./configure --prefix="$PREFIX" --without-benchmark --without-byexample --without-version-script || (cat config.log; false)
[[ "$target_platform" == "win-64" ]] && patch_libtool

make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make check || (cat test/test-suite.log; false)
fi
make install

