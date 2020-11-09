#include "gpio.h"

void gpio_init(){
    
    XGpioPs_Config *ConfigPtr;	
	ConfigPtr = XGpioPs_LookupConfig(GPIO_DEVICE_ID);

	XGpioPs_CfgInitialize(&Gpio, ConfigPtr,ConfigPtr->BaseAddr);

    XGpioPs_SetDirectionPin(&Gpio, 54, 1);
	XGpioPs_SetDirectionPin(&Gpio, 55, 1);
	XGpioPs_SetDirectionPin(&Gpio, 56, 1);
	XGpioPs_SetDirectionPin(&Gpio, 57, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, 54, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, 55, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, 56, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, 57, 1);

}

void gpio_set_led(){
	XGpioPs_WritePin(&Gpio, 54, 0x1);
	XGpioPs_WritePin(&Gpio, 55, 0x1);
	XGpioPs_WritePin(&Gpio, 56, 0x1);
	XGpioPs_WritePin(&Gpio, 57, 0x1);

}


void gpio_reset_led(){

	XGpioPs_WritePin(&Gpio, 54, 0x0);
	XGpioPs_WritePin(&Gpio, 55, 0x0);
	XGpioPs_WritePin(&Gpio, 56, 0x0);
	XGpioPs_WritePin(&Gpio, 57, 0x0);
}
