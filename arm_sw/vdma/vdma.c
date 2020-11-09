#include "xil_printf.h"
#include "vdma.h"
#include "../main.h"


int FrameVdmaReadInit(XAxiVdma *VdmaInstancePtr, int VDMA_ID, DisplayCtrl* dispPtr,int FrameAddr){
    int Status;
	XAxiVdma_Config *VdmaConfig;
	XAxiVdma_DmaSetup ReadCfg;
	VdmaConfig = XAxiVdma_LookupConfig(VDMA_ID);
		if (!VdmaConfig)
		{
			xil_printf("No video DMA found for ID %d\r\n", VDMA_ID);

		}
		Status = XAxiVdma_CfgInitialize(VdmaInstancePtr, VdmaConfig, VdmaConfig->BaseAddress);
		if (Status != XST_SUCCESS)
		{
			xil_printf("VDMA Configuration Initialization failed %d\r\n", Status);

		}

		ReadCfg.FrameDelay = 0;
		ReadCfg.EnableCircularBuf = 1;
		ReadCfg.EnableSync = 0;
		ReadCfg.PointNum = 0;
		ReadCfg.EnableFrameCounter = 0;
		ReadCfg.VertSizeInput = 540;
		ReadCfg.HoriSizeInput = 960 * 3;
		ReadCfg.Stride = 1920*3;
		ReadCfg.FixedFrameStoreAddr = 0;
		ReadCfg.FrameStoreStartAddr[0] = FrameAddr;

		Status = XAxiVdma_DmaConfig(VdmaInstancePtr, XAXIVDMA_READ, &ReadCfg);

		if (Status != XST_SUCCESS){
			xdbg_printf(XDBG_DEBUG_GENERAL, "Read channel config failed %d\r\n", Status);
			return XST_FAILURE;
		}

		Status = XAxiVdma_DmaSetBufferAddr(VdmaInstancePtr, XAXIVDMA_READ, ReadCfg.FrameStoreStartAddr);
		if (Status != XST_SUCCESS){
			xdbg_printf(XDBG_DEBUG_GENERAL, "Read channel set buffer address failed %d\r\n", Status);
			return XST_FAILURE;
		}

		return XST_SUCCESS;

}

int CamVdmaWriteInit(){

	Xil_Out32((XPAR_AXIVDMA_0_BASEADDR + 0x030), 0x108B);
	Xil_Out32((XPAR_AXIVDMA_0_BASEADDR + 0x0AC), FRAME0);
	Xil_Out32((XPAR_AXIVDMA_0_BASEADDR + 0x0B0), FRAME1);
	Xil_Out32((XPAR_AXIVDMA_0_BASEADDR + 0x0B4), FRAME2);
	Xil_Out32((XPAR_AXIVDMA_0_BASEADDR + 0x0A8), (1920*3));
	Xil_Out32((XPAR_AXIVDMA_0_BASEADDR + 0x0A4), (960*3));
	Xil_Out32((XPAR_AXIVDMA_0_BASEADDR + 0x0A0),  540);

	Xil_Out32((XPAR_AXIVDMA_4_BASEADDR + 0x030), 0x108B);
	Xil_Out32((XPAR_AXIVDMA_4_BASEADDR + 0x0AC), FRAME3);
	Xil_Out32((XPAR_AXIVDMA_4_BASEADDR + 0x0B0), FRAME4);
	Xil_Out32((XPAR_AXIVDMA_4_BASEADDR + 0x0B4), FRAME5);
	Xil_Out32((XPAR_AXIVDMA_4_BASEADDR + 0x0A8), (1920*3));
	Xil_Out32((XPAR_AXIVDMA_4_BASEADDR + 0x0A4), (960*3));
	Xil_Out32((XPAR_AXIVDMA_4_BASEADDR + 0x0A0),  540);

}

int FrameVdmaReadStart(DisplayCtrl *dispCtrl){

	FrameVdmaReadInit(&vdma1, XPAR_AXIVDMA_1_DEVICE_ID,&dispCtrl,FRAME0);
	FrameVdmaReadInit(&vdma2, XPAR_AXIVDMA_2_DEVICE_ID,&dispCtrl,FRAME1);
	FrameVdmaReadInit(&vdma3, XPAR_AXIVDMA_3_DEVICE_ID,&dispCtrl,FRAME2);

	FrameVdmaReadInit(&vdma5, XPAR_AXIVDMA_5_DEVICE_ID,&dispCtrl,FRAME3);
	FrameVdmaReadInit(&vdma6, XPAR_AXIVDMA_6_DEVICE_ID,&dispCtrl,FRAME4);
	FrameVdmaReadInit(&vdma7, XPAR_AXIVDMA_7_DEVICE_ID,&dispCtrl,FRAME5);


	XAxiVdma_DmaStart(&vdma1, XAXIVDMA_READ);
	XAxiVdma_DmaStart(&vdma2, XAXIVDMA_READ);
    XAxiVdma_DmaStart(&vdma3, XAXIVDMA_READ);

	XAxiVdma_DmaStart(&vdma5, XAXIVDMA_READ);
	XAxiVdma_DmaStart(&vdma6, XAXIVDMA_READ);
    XAxiVdma_DmaStart(&vdma7, XAXIVDMA_READ);

}







