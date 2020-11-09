
#ifndef VDMA_H_
#define VDMA_H_

#include "xaxivdma.h"
#include "../display_ctrl/display_ctrl.h"
#include "../main.h"




int FrameVdmaReadInit(XAxiVdma *VdmaInstancePtr, int VDMA_ID, DisplayCtrl* dispPtr, int FrameAddr);
int CamVdmaWriteInit();
int FrameVdmaReadStart(DisplayCtrl *dispPtr);

#endif
