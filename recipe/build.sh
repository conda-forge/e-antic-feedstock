#!/usr/bin/env bash

set -x

if [ "$target_platform" == osx* ]; then
    CXXFLAGS="$CXXFLAGS -fno-common"
fi

if [ "$target_platform" == win* ]; then
    cp $PREFIX/lib/gmp.lib $PREFIX/lib/gmpxx.lib
    CXXFLAGS="$CXXFLAGS -std=c++14"
    CPPFLAGS="$CPPFLAGS -std=c++14"
fi

set +x

./configure --prefix="$PREFIX" || (cat config.log; false)
[[ "$target_platform" == "win-64" ]] && patch_libtool

make -j${CPU_COUNT}
make check || (cat test-suite.log; false)
make install
