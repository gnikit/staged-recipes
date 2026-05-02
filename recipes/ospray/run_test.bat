@echo on

(
echo #include ^<ospray/ospray.h^>
echo.
echo int main^(int argc, const char **argv^) {
echo     OSPError err = ospInit^(&argc, argv^);
echo     if ^(err != OSP_NO_ERROR^) {
echo         return 1;
echo     }
echo     ospShutdown^(^);
echo     return 0;
echo }
) > test_ospray.cpp

(
echo cmake_minimum_required^(VERSION 3.20^)
echo project^(test_ospray LANGUAGES CXX^)
echo.
echo find_package^(ospray CONFIG REQUIRED^)
echo.
echo add_executable^(test_ospray test_ospray.cpp^)
echo target_link_libraries^(test_ospray PRIVATE ospray::ospray^)
) > CMakeLists.txt

cmake -S . -B build -G "NMake Makefiles JOM" -DCMAKE_PREFIX_PATH="%PREFIX%"
if errorlevel 1 exit 1

cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit 1

build\test_ospray.exe
if errorlevel 1 exit 1
