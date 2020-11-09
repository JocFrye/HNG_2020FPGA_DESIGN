#ifndef HNG_TEST_
#define HNG_TEST_

#include "display_ctrl/display_ctrl.h"
#include <stdio.h>
#include "math.h"
#include <ctype.h>
#include <stdlib.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xiicps.h"
#include "vdma/vdma.h"
#include "i2c/PS_i2c.h"
#include "xgpio.h"
#include "sleep.h"
#include "ov5640/ov5640.h"
#include "adv7511/adv7511.h"
#include "xobjdet_hw.h"
#include "gpio/gpio.h"

#define DEMO_MAX_FRAME (1920*1080*3)

#define  FRAME0  XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x01000000
#define  FRAME1  FRAME0 + 1920*1080*3
#define  FRAME2  FRAME1 + 1920*1080*3

#define  FRAME3  FRAME2 + 1920*1080*3
#define  FRAME4  FRAME3 + 1920*1080*3
#define  FRAME5  FRAME4 + 1920*1080*3


#define DYNCLK_BASEADDR XPAR_AXI_DYNCLK_0_BASEADDR
#define DISPLAY_VDMA_ID XPAR_AXIVDMA_0_DEVICE_ID
#define SENSOR_VDMA_ID XPAR_AXIVDMA_1_DEVICE_ID
#define DISP_VTC_ID XPAR_VTC_0_DEVICE_ID
#define UART0_BASEADDR XPAR_PS7_UART_0_BASEADDR


#define DEMO_STRIDE (1920 * 3)

DisplayCtrl dispCtrl;
XIicPs ps_i2c0;
XIicPs ps_i2c1;
XGpio cmos_rstn;
XAxiVdma vdma0 , vdma1 , vdma2 , vdma3 , vdma4 , vdma5 , vdma6 , vdma7;


#endif
