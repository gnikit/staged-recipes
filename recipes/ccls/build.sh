#!/bin/bash
set -euxo pipefail

mkdir -p build
cd build

cmake .. \
  -G Ninja \
  $CMAKE_ARGS \
  -DCCLS_VERSION="${PKG_VERSION}" \
  -DUSE_SYSTEM_RAPIDJSON=ON

cmake --build . --parallel "${CPU_COUNT}"
cmake --install .
