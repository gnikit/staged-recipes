cmake -S . -B build -G Ninja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DLIBSAIS_BUILD_SHARED_LIB=ON ^
    -DLIBSAIS_USE_OPENMP=ON ^
    %CMAKE_ARGS%
if errorlevel 1 exit 1

cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit 1

cmake --install build
if errorlevel 1 exit 1
