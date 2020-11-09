#ifndef __OV5640_H__
#define __OV5640_H__
#include "xil_types.h"
#include "xgpio.h"
struct reginfo
{
    u16 reg;
    u8 val;
};

#define SEQUENCE_INIT        0x00
#define SEQUENCE_NORMAL      0x01

#define SEQUENCE_PROPERTY    0xFFFD
#define SEQUENCE_WAIT_MS     0xFFFE
#define SEQUENCE_END	     0xFFFF
#define IIC_DEVICE_ID	XPAR_XIICPS_0_DEVICE_ID
int sensor_init();
int sensor_rst(XGpio* GpioInstance,int GpioId);
#endif
