#!/bin/bash
set -euxo pipefail

./configure --prefix="$PREFIX" --with-ncurses="$PREFIX"
make -j"${CPU_COUNT}"
make install
