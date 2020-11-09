#ifndef DISPLAY_CTRL_H_
#define DISPLAY_CTRL_H_


#include "xil_types.h"
#include "xaxivdma.h"
#include "xvtc.h"
#include "../dynclk/dynclk.h"
#include "display_modes.h"


#define BIT_DISPLAY_RED 16
#define BIT_DISPLAY_BLUE 8
#define BIT_DISPLAY_GREEN 0

#define DISPLAY_NUM_FRAMES 3



typedef struct {
		u32 dynClkAddr;
		XVtc vtc;
		VideoMode vMode;
		u32 stride;
		double pxlFreq;

} DisplayCtrl;


int DisplayStart(DisplayCtrl *dispPtr);
int DisplayInitialize(DisplayCtrl *dispPtr,u16 vtcId, u32 dynClkAddr,  u32 stride);

#endif

