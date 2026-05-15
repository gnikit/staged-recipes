#!/usr/bin/env bash
set -euxo pipefail

cmake -S . -B build -G Ninja $CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON

cmake --build build --parallel ${CPU_COUNT}
cmake --install build
