@echo off
REM Windows build script for ftxui
setlocal enableextensions enabledelayedexpansion

cmake -S . -B build -G Ninja %CMAKE_ARGS% -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS:BOOL=ON -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
cmake --build build --config Release --parallel %CPU_COUNT%
cmake --install build --config Release
