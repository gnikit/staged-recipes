@echo off
setlocal enabledelayedexpansion

sed -i 's/install(TARGETS mgclient-static mgclient-shared/install(TARGETS mgclient-shared/' "${SRC_DIR}"/src/CMakeLists.txt
mkdir %SRC_DIR%\build
pushd "%SRC_DIR%\build
  cmake ${CMAKE_ARGS} .. -G "Ninja"
  cmake --build .
  ninja install
popd

mv "${PREFIX}"/Library/lib/mgclient.dll ${PREFIX}/Library/bin/mgclient.dll
