#!/usr/bin/env bash

if [ "$target_platform" == osx* ]; then
    CXXFLAGS="$CXXFLAGS -fno-common"
fi

if [ "$target_platform" == win* ]; then
    cp $PREFIX/lib/gmp.lib $PREFIX/lib/gmpxx.lib
fi

./configure --prefix="$PREFIX" || (cat config.log; false)
[[ "$target_platform" == "win-64" ]] && patch_libtool

make -j${CPU_COUNT}
make check || (cat test-suite.log; false)
make install
