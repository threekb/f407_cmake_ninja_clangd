set -e

cd /c/Users/Admin/Desktop/f407_cmake_ninja_clangd
/usr/bin/ccmake.exe -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
