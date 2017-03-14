# root Makefile for holding all basic targets

horses		:=	$(shell nproc)

ROOT_DIR	:=	$(abspath .)
KERNEL_DIR	:=	$(ROOT_DIR)/build.dir

CC		:= 	arm-linux-gnueabihf-gcc
AS		:= 	arm-linux-gnueabihf-as
LD		:= 	arm-linux-gnueabihf-ld
OBJCOPY		:= 	arm-linux-gnueabihf-objcopy
STRIP		:= 	arm-linux-gnueabihf-strip
AR		:= 	arm-linux-gnueabihf-ar
NM		:= 	arm-linux-gnueabihf-nm
OBJDUMP		:= 	arm-linux-gnueabihf-objdump

KERNEL_OPTS 	= 	"ARCH=arm AS=$(AS) LD=$(LD) CC=$(CC) AR=$(AR) NM=$(NM) 			\
			CROSS_COMPILE=arm-linux-gnueabihf- STRIP=$(STRIP) 			\
			OBJCOPY=$(OBJCOPY) OBJDUMP=$(OBJDUMP) O=$(ROOT_DIR)/build.dir $$(V)"

# put all the modules names here (referred to as subfolders inside modules/ dir) to loop via and build each
MODULES_LIST	:=	printk-mod

all: init update kernel modules.build

init: build.dir

build.dir:
	- (mkdir $@)

update:
	(git submodule update --init --recursive .)

kernel:
	(cd kernel-rpi && make -j$(horses) $(KERNEL_OPTS) bcm2709_defconfig)
	(cd kernel-rpi && make -j$(horses) $(KERNEL_OPTS))

clean: modules.clean
	(cd kernel-rpi && make clean)

purge: clean
	(cd kernel-rpi && make distclean)

modules.build:
	$(foreach dir, $(MODULES_LIST), cd modules/$(dir) && make build KERNEL_DIR=$(KERNEL_DIR) KERNEL_OPTS=$(KERNEL_OPTS))

modules.clean:
	$(foreach dir, $(MODULES_LIST), cd modules/$(dir) && make clean KERNEL_DIR=$(KERNEL_DIR) KERNEL_OPTS=$(KERNEL_OPTS))

.PHONY: all modules.build modules.clean update clean purge
.DEFAULT_GOAL=all
