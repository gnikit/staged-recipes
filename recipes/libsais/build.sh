#!/bin/bash
set -ex

cmake -S . -B build -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DLIBSAIS_BUILD_SHARED_LIB=ON \
    -DLIBSAIS_USE_OPENMP=ON \
    ${CMAKE_ARGS}

cmake --build build --parallel ${CPU_COUNT}
cmake --install build
