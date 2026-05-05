#!/bin/bash
set -exo pipefail

cat > test_ospray.cpp <<'EOF'
#include <ospray/ospray.h>

int main(int argc, const char **argv) {
    OSPError err = ospInit(&argc, argv);
    if (err != OSP_NO_ERROR) {
        return 1;
    }
    ospShutdown();
    return 0;
}
EOF

cat > CMakeLists.txt <<'EOF'
cmake_minimum_required(VERSION 3.20)
project(test_ospray LANGUAGES CXX)

find_package(ospray CONFIG REQUIRED)

add_executable(test_ospray test_ospray.cpp)
target_link_libraries(test_ospray PRIVATE ospray::ospray)
EOF

cmake -S . -B build -G Ninja -DCMAKE_PREFIX_PATH="$PREFIX"
cmake --build build --parallel ${CPU_COUNT}
./build/test_ospray
