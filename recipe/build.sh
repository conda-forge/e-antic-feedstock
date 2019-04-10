#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    export CXXFLAGS="$CXXFLAGS -fno-common"
fi

./bootstrap.sh
./configure --prefix="$PREFIX" || (cat config.log && false)

make -j${CPU_COUNT}
make check
make install
