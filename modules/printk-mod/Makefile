obj-m += printk-mod.o

build:
	make $(KERNEL_OPTS) -C $(KERNEL_DIR) M=$(shell pwd) modules

clean:
	make $(KERNEL_OPTS) -C $(KERNEL_DIR) M=$(shell pwd) clean

