@echo off
setlocal enabledelayedexpansion

:: Create conda_build.sh wrapper
:: With pixi, environment is already activated - no need to source conda.sh
:: With Miniforge/conda, we need to source conda.sh and activate
echo if [ -f "D:/Miniforge/etc/profile.d/conda.sh" ]; then   > conda_build.sh
echo   source D:/Miniforge/etc/profile.d/conda.sh           >> conda_build.sh
echo   conda activate "${PREFIX}"                           >> conda_build.sh
echo   conda activate --stack "${BUILD_PREFIX}"             >> conda_build.sh
echo fi                                                     >> conda_build.sh
echo CONDA_PREFIX=${CONDA_PREFIX//\\//}                     >> conda_build.sh
type "%RECIPE_DIR%\build.sh"                                >> conda_build.sh

set CMAKE_ARGS=%CMAKE_ARGS%
set MSYSTEM=MINGW64
set MSYS2_PATH_TYPE=inherit
set MSYS2_ARG_CONV_EXCL="*"
set CHERE_INVOKING=1
bash -lce "./conda_build.sh"
if errorlevel 1 exit 1
