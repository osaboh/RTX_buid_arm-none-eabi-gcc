This repository provides a Makefile to build the example that of comes with the RTX in gcc.

* toolchains

I have used gcc of the debian package.
Maybe "GNU ARM Embedded Toolchain" of launchpad can also be used.

  $ arm-none-eabi-gcc --version
  arm-none-eabi-gcc (4.8.4-1+11-1) 4.8.4 20141219 (release)
  Copyright (C) 2013 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


* usage
1. Get RTX Ver4.70
  https://www.keil.com/demo/eval/rtx.htm

2. unzip cmsis_rtos_rtx_v4p70.zip

3. patch -p0 < delimiter_to_unix.patch

    patching file Examples/C++/Example1/GCC/Retarget.c
    patching file Examples/C++/Example2/GCC/Retarget.c
    patching file Examples/Mail/GCC/Retarget.c
    patching file Examples/Message/GCC/Retarget.c
    patching file Examples/Semaphore/GCC/Retarget.c

4. cp Makefile Examples && make


* License
MIT.
But RTX is see documents in the archive.


Download RTX Ver4.70
https://www.keil.com/demo/eval/rtx.htm
