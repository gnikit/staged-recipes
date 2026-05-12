@echo on

mkdir build
cd build

cmake -G Ninja ^
    -DBUILD_SHARED=ON ^
    -DBUILD_STATIC=OFF ^
    -DBUILD_LITE=OFF ^
    %CMAKE_ARGS% ^
    ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build .
if %ERRORLEVEL% neq 0 exit 1

cmake --install .
if %ERRORLEVEL% neq 0 exit 1
