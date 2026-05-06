@echo on
setlocal enabledelayedexpansion

cmake -S . -B build -G Ninja ^
    %CMAKE_ARGS% ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_EXAMPLES=OFF ^
    -DBUILD_TESTING=ON ^
    -DBUILD_BENCHMARKS=OFF ^
    -DOpenVDB_ROOT="%LIBRARY_PREFIX%" ^
    -DISPC_EXECUTABLE="%BUILD_PREFIX%\Library\bin\ispc.exe"
if %ERRORLEVEL% neq 0 exit /b 1

cmake --build build --parallel %CPU_COUNT%
if %ERRORLEVEL% neq 0 exit /b 1

if not "%CONDA_BUILD_SKIP_TESTS%"=="1" (
    ctest -V --test-dir build --parallel %CPU_COUNT%
)
if %ERRORLEVEL% neq 0 exit /b 1

cmake --install build
if %ERRORLEVEL% neq 0 exit /b 1
