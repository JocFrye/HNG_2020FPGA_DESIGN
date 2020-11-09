#include "display_ctrl.h"
#include "xdebug.h"
#include "xil_io.h"


int DisplayStart(DisplayCtrl *dispPtr)
{

	ClkConfig clkReg;
	ClkMode clkMode;

	XVtc_Timing vtcTiming;
	XVtc_SourceSelect SourceSelect;

	xdbg_printf(XDBG_DEBUG_GENERAL, "display start entered\n\r");



	ClkFindParams(dispPtr->vMode.freq, &clkMode);

	dispPtr->pxlFreq = clkMode.freq;

	if (!ClkFindReg(&clkReg, &clkMode))
	{
		xdbg_printf(XDBG_DEBUG_GENERAL, "Error calculating CLK register values\n\r");
		return XST_FAILURE;
	}
	ClkWriteReg(&clkReg, dispPtr->dynClkAddr);

	ClkStop(dispPtr->dynClkAddr);
	ClkStart(dispPtr->dynClkAddr);


	vtcTiming.HActiveVideo = dispPtr->vMode.width;	/**< Horizontal Active Video Size */
	vtcTiming.HFrontPorch = dispPtr->vMode.hps - dispPtr->vMode.width;	/**< Horizontal Front Porch Size */
	vtcTiming.HSyncWidth = dispPtr->vMode.hpe - dispPtr->vMode.hps;		/**< Horizontal Sync Width */
	vtcTiming.HBackPorch = dispPtr->vMode.hmax - dispPtr->vMode.hpe + 1;		/**< Horizontal Back Porch Size */
	vtcTiming.HSyncPolarity = dispPtr->vMode.hpol;	/**< Horizontal Sync Polarity */
	vtcTiming.VActiveVideo = dispPtr->vMode.height;	/**< Vertical Active Video Size */
	vtcTiming.V0FrontPorch = dispPtr->vMode.vps - dispPtr->vMode.height;	/**< Vertical Front Porch Size */
	vtcTiming.V0SyncWidth = dispPtr->vMode.vpe - dispPtr->vMode.vps;	/**< Vertical Sync Width */
	vtcTiming.V0BackPorch = dispPtr->vMode.vmax - dispPtr->vMode.vpe + 1;;	/**< Horizontal Back Porch Size */
	vtcTiming.V1FrontPorch = dispPtr->vMode.vps - dispPtr->vMode.height;	/**< Vertical Front Porch Size */
	vtcTiming.V1SyncWidth = dispPtr->vMode.vpe - dispPtr->vMode.vps;	/**< Vertical Sync Width */
	vtcTiming.V1BackPorch = dispPtr->vMode.vmax - dispPtr->vMode.vpe + 1;;	/**< Horizontal Back Porch Size */
	vtcTiming.VSyncPolarity = dispPtr->vMode.vpol;	/**< Vertical Sync Polarity */
	vtcTiming.Interlaced = 0;		/**< Interlaced / Progressive video */


	memset((void *)&SourceSelect, 0, sizeof(SourceSelect));
	SourceSelect.VBlankPolSrc = 1;
	SourceSelect.VSyncPolSrc = 1;
	SourceSelect.HBlankPolSrc = 1;
	SourceSelect.HSyncPolSrc = 1;
	SourceSelect.ActiveVideoPolSrc = 1;
	SourceSelect.ActiveChromaPolSrc= 1;
	SourceSelect.VChromaSrc = 1;
	SourceSelect.VActiveSrc = 1;
	SourceSelect.VBackPorchSrc = 1;
	SourceSelect.VSyncSrc = 1;
	SourceSelect.VFrontPorchSrc = 1;
	SourceSelect.VTotalSrc = 1;
	SourceSelect.HActiveSrc = 1;
	SourceSelect.HBackPorchSrc = 1;
	SourceSelect.HSyncSrc = 1;
	SourceSelect.HFrontPorchSrc = 1;
	SourceSelect.HTotalSrc = 1;

	XVtc_SelfTest(&(dispPtr->vtc));

	XVtc_RegUpdateEnable(&(dispPtr->vtc));
	XVtc_SetGeneratorTiming(&(dispPtr->vtc), &vtcTiming);
	XVtc_SetSource(&(dispPtr->vtc), &SourceSelect);

	XVtc_EnableGenerator(&dispPtr->vtc);


	return XST_SUCCESS;
}




int DisplayInitialize(DisplayCtrl *dispPtr, u16 vtcId, u32 dynClkAddr,  u32 stride)
{
	int Status;

	XVtc_Config *vtcConfig;
	ClkConfig clkReg;
	ClkMode clkMode;


	dispPtr->dynClkAddr = dynClkAddr;


	dispPtr->stride = stride;
	dispPtr->vMode = VMODE_1920x1080;

	ClkFindParams(dispPtr->vMode.freq, &clkMode);

	dispPtr->pxlFreq = clkMode.freq;


	if (!ClkFindReg(&clkReg, &clkMode))
	{
		xdbg_printf(XDBG_DEBUG_GENERAL, "Error calculating CLK register values\n\r");
		return XST_FAILURE;
	}
	ClkWriteReg(&clkReg, dispPtr->dynClkAddr);

	ClkStart(dispPtr->dynClkAddr);


	vtcConfig = XVtc_LookupConfig(vtcId);

	if (NULL == vtcConfig) {
		return (XST_FAILURE);
	}
	Status = XVtc_CfgInitialize(&(dispPtr->vtc), vtcConfig, vtcConfig->BaseAddress);

	if (Status != (XST_SUCCESS)) {
		return (XST_FAILURE);
	}


	return XST_SUCCESS;
}

