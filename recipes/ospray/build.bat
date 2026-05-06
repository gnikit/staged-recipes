@echo on
setlocal enabledelayedexpansion

if "%mpi%"=="nompi" (
    set "OSPRAY_MPI=OFF"
) else (
    set "OSPRAY_MPI=ON"
)

cmake -S . -B build -G Ninja ^
    ${CMAKE_ARGS} ^
    -DISPC_EXECUTABLE="${BUILD_PREFIX}\Library\bin\ispc.exe" ^
    -DOSPRAY_MODULE_CPU=ON ^
    -DOSPRAY_MODULE_GPU=OFF ^
    -DOSPRAY_ENABLE_VOLUMES=ON ^
    -DOSPRAY_MODULE_DENOISER=ON ^
    -DOSPRAY_MODULE_MPI=${OSPRAY_MPI} ^
    -DOSPRAY_ENABLE_APPS=ON ^
    -DOSPRAY_ENABLE_APPS_TESTING=ON ^
    -DOSPRAY_ENABLE_APPS_EXAMPLES=OFF ^
    -DOSPRAY_ENABLE_APPS_TUTORIALS=OFF ^
    -DOSPRAY_ENABLE_APPS_BENCHMARK=OFF ^
    -DOSPRAY_INSTALL_DEPENDENCIES=OFF
if %ERRORLEVEL% neq 0 exit /b 1

cmake --build build --parallel %CPU_COUNT%
if %ERRORLEVEL% neq 0 exit /b 1

cmake --install build
if %ERRORLEVEL% neq 0 exit /b 1
