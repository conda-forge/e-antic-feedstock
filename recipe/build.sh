#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    CXXFLAGS="$CXXFLAGS -fno-common"
fi

./configure --prefix="$PREFIX"

make -j${CPU_COUNT}
make check || (cat test-suite.log; false)
make install
