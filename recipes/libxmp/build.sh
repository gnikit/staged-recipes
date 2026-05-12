#!/bin/bash
set -ex

mkdir build
cd build

cmake -G Ninja \
    -DBUILD_SHARED=ON \
    -DBUILD_STATIC=OFF \
    -DBUILD_LITE=OFF \
    $CMAKE_ARGS \
    ..

cmake --build .
cmake --install .
