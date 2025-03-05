set -e

cd /d/TUT/vscode-cmake-armgcc-clangd-ninja/f407_cmake_ninja_clangd/build/cmake/stm32cubemx
/usr/bin/ccmake.exe -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
