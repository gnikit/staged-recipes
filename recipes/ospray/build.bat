@echo on
setlocal enabledelayedexpansion

cmake -S . -B build -G "NMake Makefiles JOM" ^
    ${CMAKE_ARGS} ^
    -DISPC_EXECUTABLE="${BUILD_PREFIX}/bin/ispc" ^
    -DOSPRAY_MODULE_CPU=ON ^
    -DOSPRAY_MODULE_GPU=OFF ^
    -DOSPRAY_ENABLE_VOLUMES=ON ^
    -DOSPRAY_MODULE_DENOISER=ON ^
    -DOSPRAY_MODULE_MPI=OFF ^
    -DOSPRAY_ENABLE_APPS=OFF ^
    -DOSPRAY_ENABLE_APPS_TESTING=OFF ^
    -DOSPRAY_ENABLE_APPS_EXAMPLES=OFF ^
    -DOSPRAY_ENABLE_APPS_TUTORIALS=OFF ^
    -DOSPRAY_ENABLE_APPS_BENCHMARK=OFF ^
    -DOSPRAY_INSTALL_DEPENDENCIES=OFF
if %ERRORLEVEL% neq 0 exit /b 1

cmake --build build --parallel %CPU_COUNT%
if %ERRORLEVEL% neq 0 exit /b 1

cmake --install build
if %ERRORLEVEL% neq 0 exit /b 1
