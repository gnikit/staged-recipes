#!/bin/bash
set -exo pipefail

cmake -S . -B build -G Ninja \
    ${CMAKE_ARGS} \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_TESTING=ON \
    -DBUILD_BENCHMARKS=OFF \
    -DISPC_EXECUTABLE="${BUILD_PREFIX}/bin/ispc" \
    -DOpenVDB_ROOT="${PREFIX}"
cmake --build build --parallel ${CPU_COUNT}

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
    ctest -V --test-dir build --parallel ${CPU_COUNT}
fi

cmake --install build
