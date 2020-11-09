#include <stdio.h>
#include "xil_printf.h"
#include "xgpiops.h"
#include "sleep.h"
#define GPIO_DEVICE_ID		XPAR_XGPIOPS_0_DEVICE_ID
XGpioPs Gpio;

void gpio_init();
void gpio_set_led();
void gpio_reset_led();
