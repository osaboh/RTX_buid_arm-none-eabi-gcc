CROSS = arm-none-eabi-

CMSIS_DIR = /tmp/a/CMSIS
INC = -I$(CMSIS_DIR)/CM3/CoreSupport -I../INC
LIBS  = ../LIB/GCC/libRTX_CM3.a
CFLAGS = -mthumb -mcpu=cortex-m3 -g3 -O2 -ffunction-sections -fdata-sections -Wl,--gc-sections

# qemu-system-arm
QEMU_PATH = ~/Dev/tools/qemu/qemu_stm32/installed/bin/
QEMU = $(QEMU_PATH)qemu-system-arm
QEMU_DEVICE = -cpu cortex-m3 -machine lm3s6965evb -monitor null -serial null
QEMU_GDB = -gdb tcp::3333 -S

all: RTX_ex1.elf RTX_ex2.elf Mail.elf Semaphore.elf Message.elf C++_ex1.elf C++_ex2.elf


RTX_ex1.elf:
	$(CROSS)gcc -T $(shell find RTX_ex1/GCC -name ARMCMx.ld)  $(CFLAGS) $(INC) -o $@ \
		$(shell find RTX_ex1 -name *.[Sc]) $(LIBS)
	$(CROSS)objcopy -Obinary $@ $(shell basename $@ .elf).bin
	$(CROSS)size $@

RTX_ex2.elf:
	$(CROSS)gcc -T $(shell find RTX_ex2/GCC -name ARMCMx.ld)  $(CFLAGS) $(INC) -o $@  \
		$(shell find RTX_ex2 -name *.[Sc]) $(LIBS)
	$(CROSS)objcopy -Obinary $@ $(shell basename $@ .elf).bin
	$(CROSS)size $@

Mail.elf:
	$(CROSS)gcc -T $(shell find Mail/GCC -name ARMCMx.ld)  $(CFLAGS) $(INC) -o $@  \
		$(shell find Mail -name *.[Sc] | grep -v Mail/ARM | grep -v Mail/G++ | grep -v Mail/IAR) $(LIBS)
	$(CROSS)objcopy -Obinary $@ $(shell basename $@ .elf).bin
	$(CROSS)size $@

Semaphore.elf:
	$(CROSS)gcc -T $(shell find Semaphore/GCC -name ARMCMx.ld)  $(CFLAGS) $(INC) -o $@  \
		$(shell find Semaphore -name *.[Sc] | grep -v Semaphore/ARM | grep -v Semaphore/G++ | grep -v Semaphore/IAR) $(LIBS)
	$(CROSS)objcopy -Obinary $@ $(shell basename $@ .elf).bin
	$(CROSS)size $@

Message.elf:
	$(CROSS)gcc -T $(shell find Message/GCC -name ARMCMx.ld)  $(CFLAGS)  $(INC) -o $@ \
		$(shell find Message -name *.[Sc] | grep -v Message/ARM | grep -v Message/G++ | grep -v Message/IAR) $(LIBS)
	$(CROSS)objcopy -Obinary $@ $(shell basename $@ .elf).bin
	$(CROSS)size $@

C++_ex1.elf:
	$(CROSS)gcc -T $(shell find C++/Example1/GCC -name ARMCMx.ld)  $(CFLAGS)   $(INC) -o $@ \
		$(shell find C++/Example1 -name *.cpp) \
		$(shell find C++/Example1 -name *.[Sc] | grep -v C++/Example1/ARM | grep -v C++/Example1/G++ | grep -v C++/Example1/IAR)  $(LIBS) -lstdc++
	$(CROSS)objcopy -Obinary $@ $(shell basename $@ .elf).bin
	$(CROSS)size $@

C++_ex2.elf:
	$(CROSS)gcc -T $(shell find C++/Example2/GCC -name ARMCMx.ld)  $(CFLAGS)   $(INC) -o $@ \
		$(shell find C++/Example2 -name *.cpp) \
		$(shell find C++/Example2 -name *.[Sc] | grep -v C++/Example2/ARM | grep -v C++/Example2/G++ | grep -v C++/Example2/IAR)  $(LIBS) -lstdc++
	$(CROSS)objcopy -Obinary $@ $(shell basename $@ .elf).bin
	$(CROSS)size $@

qemu:
	$(QEMU) $(QEMU_DEVICE) $(QEMU_GDB) -kernel RTX_ex1.bin &
	$(CROSS)gdb -x gdb_connect_qemu.init

clean:
	rm -f *.elf *.o a.out *.bin
