1. `llvm`、`clang`和`clangd`是通过`msys2`安装的。
2. `.vscode`文件夹和`run.sh`脚本建议参考我的配置。
3. cmake生成的`compile_commands.json`文件中，路径应该为`C:/`而不是`/c/`。
   > 如果工程存放在别的盘，则修改为对应盘符即可（在Windows下，路径是需要经常注意的）
   - 这个问题可以通过`run.sh`脚本解决。
4. 需要额外开启的一些编译参数：
   - 添加到`cmake/gcc-arm-none-eabi.cmake`文件中：
```cmake
# 有中文注释的部分是 CubeMX 不会自动生成的，需要手动添加
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -u _printf_float")  # 支持 printf 函数打印浮点数
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -lm")  # 链接数学库 libm
set(CMAKE_EXE_LINKER_FLAGS "-Wl,--gc-sections,--no-warn-rwx-segments")  # 取消 rwx 段的警告
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-unused-parameter")  # 忽略 C 代码中未使用参数的警告
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-unused-parameter")  # 忽略 C++ 代码中未使用参数的警告
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
```
1. 使用`arm-none-eabi-gdb`进行调试：
   - 在第一个终端中输入：
```bash
openocd -f interface/cmsis-dap.cfg -f target/stm32f4x.cfg
# 也可以直接
openocd -f attach.cfg
```
   - 打开第二个终端，输入：
```bash
arm-none-eabi-gdb executable.elf
# 第一个命令成功执行后输入以下命令：
target remote :3333
```
> 调试常用命令：
```bash
break main  # 在 main() 函数打断点
continue    # 运行程序，此时按下复位键
n           # 单步执行下一条命令，但不会进入函数
s           # 单步执行，如果是函数调用，则会进入到函数里继续单步执行
print val   # 打印出 val 的值（十进制）
disassemble # 查看汇编代码
list        # 查看代码
finish      # 回到断点
quit        # 退出调试，输入 y 确认
```

