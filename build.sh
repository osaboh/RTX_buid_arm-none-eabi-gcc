#!/bin/sh
unzip cmsis_rtos_rtx_v4p70.zip

patch -p0 < delimiter_to_unix.patch

mv Makefile Examples
mv gdb_connect_qemu.init Examples
cd Examples

make

