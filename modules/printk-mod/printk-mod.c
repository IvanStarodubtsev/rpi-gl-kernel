#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Ivan Starodubtsev");
MODULE_DESCRIPTION(__FILE__);
MODULE_VERSION("0.1");

static int __init module_printk_init (void)
{
	printk (KERN_INFO "Hello, World from %s!", __FILE__);

	return 0;
}

static void __exit module_printk_exit (void)
{
	printk (KERN_INFO "Goodbye cruel world!");
}

module_init (module_printk_init);
module_exit (module_printk_exit);
