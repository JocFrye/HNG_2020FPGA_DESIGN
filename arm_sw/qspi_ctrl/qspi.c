

#include "qspi.h"
#include "xtime_l.h"
#include "stdio.h"

void FlashWriteEnable(XQspiPs *QspiPtr);

void FlashWriteDisable(XQspiPs *QspiPtr) ;

void FlashErase(XQspiPs *QspiPtr, u32 Address, u32 ByteCount);

void FlashWrite(XQspiPs *QspiPtr, u32 Address, u32 ByteCount, u8 Command);

void FlashRead(XQspiPs *QspiPtr, u32 Address, u32 ByteCount, u8 Command);

int FlashReadID(void);

void print_percent(int percent) ;


XQspiPs QspiInstance;


u8 ReadBuffer[PAGE_SIZE + DATA_OFFSET + DUMMY_SIZE];
u8 WriteBuffer[PAGE_SIZE + DATA_OFFSET];


int update_qspi(XQspiPs *QspiInstancePtr, u16 QspiDeviceId, unsigned int TotoalLen, char *FlashDataToSend)
{
	int Status;
	int i ;
	unsigned int HasSendNum = 0 ;
	unsigned int WriteAddr = 0 ;
	unsigned int HasRecvNum = 0 ;
	unsigned int ReadAddr = 0 ;
	XTime TimerStart, TimerEnd;
	float elapsed_time ;

	int PercentCurr = -1 ;
	int PercentLast = -1 ;

	XQspiPs_Config *QspiConfig;

	QspiConfig = XQspiPs_LookupConfig(QspiDeviceId);
	if (NULL == QspiConfig) {
		return XST_FAILURE;
	}

	Status = XQspiPs_CfgInitialize(QspiInstancePtr, QspiConfig,
			QspiConfig->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	XQspiPs_SetLqspiConfigReg(QspiInstancePtr, DUAL_QSPI_CONFIG);


	XQspiPs_SetOptions(QspiInstancePtr, XQSPIPS_MANUAL_START_OPTION |
			XQSPIPS_FORCE_SSELECT_OPTION |
			XQSPIPS_HOLD_B_DRIVE_OPTION);

	XQspiPs_SetClkPrescaler(QspiInstancePtr, XQSPIPS_CLK_PRESCALE_8);


	XQspiPs_SetSlaveSelect(QspiInstancePtr);


	FlashReadID();


	printf("Performing Erase Operation...\r\n") ;

	XTime_SetTime(0) ;
	XTime_GetTime(&TimerStart) ;
	FlashErase(QspiInstancePtr, 0, TotoalLen);
	XTime_GetTime(&TimerEnd) ;
	printf("100%%\r\n") ;
	elapsed_time = ((float)(TimerEnd-TimerStart))/((float)COUNTS_PER_SECOND) ;
	printf("INFO:Elapsed time = %.2f sec\r\n", elapsed_time) ;
	printf("Erase Operation Successful.\r\n") ;




	printf("Performing Program Operation...\r\n") ;
	XTime_SetTime(0) ;
	XTime_GetTime(&TimerStart) ;
	do{
		PercentCurr = (int)(((float)HasSendNum/(float)TotoalLen)*10) ;

		if (PercentCurr != PercentLast)
			print_percent(PercentCurr) ;

		PercentLast = PercentCurr ;

		if ((HasSendNum+PAGE_SIZE) > TotoalLen)
		{
			for (i = 0 ; i < PAGE_SIZE ; i++)
			{
				if (i >= TotoalLen-HasSendNum)
				{
					WriteBuffer[DATA_OFFSET + i] = 0 ;
				}
				else
				{
					WriteBuffer[DATA_OFFSET + i] = (u8)(FlashDataToSend[HasSendNum+i]);
				}
			}
			FlashWrite(QspiInstancePtr, WriteAddr, PAGE_SIZE, WRITE_CMD);
			printf("100%%\r\n") ;
			XTime_GetTime(&TimerEnd) ;
			elapsed_time = (float)(TimerEnd-TimerStart)/(COUNTS_PER_SECOND) ;
			printf("INFO:Elapsed time = %.2f sec\r\n", elapsed_time) ;
			printf("Program Operation Successful.\r\n") ;
			HasSendNum+= PAGE_SIZE ;
		}
		else
		{
			for (i = 0 ; i < PAGE_SIZE ; i++)
			{
				WriteBuffer[DATA_OFFSET + i] = (u8)(FlashDataToSend[HasSendNum+i]);
			}
			FlashWrite(QspiInstancePtr, WriteAddr, PAGE_SIZE, WRITE_CMD);
			HasSendNum+= PAGE_SIZE ;
			WriteAddr+= PAGE_SIZE/2 ;
		}
	}while(HasSendNum < TotoalLen) ;

	HasSendNum = 0 ;
	WriteAddr = 0 ;


	XQspiPs_SetOptions(QspiInstancePtr,  XQSPIPS_LQSPI_MODE_OPTION |
			XQSPIPS_HOLD_B_DRIVE_OPTION);
	XQspiPs_SetLqspiConfigReg(QspiInstancePtr, DUAL_QSPI_CONFIG);

	printf("Performing Verify Operation...\r\n") ;
	memset(ReadBuffer, 0x00, sizeof(ReadBuffer));
	XTime_SetTime(0) ;
	XTime_GetTime(&TimerStart) ;
	do{
		PercentCurr = (int)(((float)HasRecvNum/(float)TotoalLen)*10) ;

		if (PercentCurr != PercentLast)
			print_percent(PercentCurr) ;

		PercentLast = PercentCurr ;

		if ((HasRecvNum+PAGE_SIZE) > TotoalLen)
		{
			FlashRead(QspiInstancePtr, ReadAddr, PAGE_SIZE, QUAD_READ_CMD);
			for (i = 0 ; i < TotoalLen-HasRecvNum; i++)
			{
				if (ReadBuffer[DATA_OFFSET + DUMMY_SIZE+i] != (u8)(FlashDataToSend[HasRecvNum+i]))
				{
					printf("Verify data error, address is 0x%x\tSend Data is 0x%x\tRead Data is 0x%x\r\n",
							ReadAddr+i+1,FlashDataToSend[HasRecvNum+i], ReadBuffer[DATA_OFFSET + DUMMY_SIZE+i]) ;
					printf("Verify Operation Failed!\r\n") ;
					return XST_FAILURE ;
				}
			}
			HasRecvNum+= PAGE_SIZE ;
			printf("100%%\r\n") ;
			XTime_GetTime(&TimerEnd) ;
			elapsed_time = (float)(TimerEnd-TimerStart)/(COUNTS_PER_SECOND) ;
			printf("INFO:Elapsed time = %.2f sec\r\n", elapsed_time) ;
			printf("Verify Operation Successful.\r\n") ;
		}
		else
		{
			FlashRead(QspiInstancePtr, ReadAddr, PAGE_SIZE, QUAD_READ_CMD);
			for (i = 0 ; i < PAGE_SIZE ; i++)
			{
				if (ReadBuffer[DATA_OFFSET + DUMMY_SIZE+i] != (u8)(FlashDataToSend[HasRecvNum+i]))
				{
					printf("Verify data error, address is 0x%x\tSend Data is 0x%x\tRead Data is 0x%x\r\n",
							ReadAddr+i+1,FlashDataToSend[HasRecvNum+i], ReadBuffer[DATA_OFFSET + DUMMY_SIZE+i]) ;
					printf("Verify Operation Failed!\r\n") ;
					return XST_FAILURE ;
				}
			}
			HasRecvNum+= PAGE_SIZE ;
			ReadAddr+= PAGE_SIZE/2 ;
		}
	}while(HasRecvNum < TotoalLen) ;

	HasRecvNum = 0 ;
	ReadAddr = 0 ;

	return XST_SUCCESS;
}



void FlashWrite(XQspiPs *QspiPtr, u32 Address, u32 ByteCount, u8 Command)
{
	u8 WriteEnableCmd = { WRITE_ENABLE_CMD };
	u8 ReadStatusCmd[] = { READ_STATUS_CMD, 0 };  /* must send 2 bytes */
	u8 FlashStatus[2];

	XQspiPs_PolledTransfer(QspiPtr, &WriteEnableCmd, NULL,
			sizeof(WriteEnableCmd));

	WriteBuffer[COMMAND_OFFSET]   = Command;
	WriteBuffer[ADDRESS_1_OFFSET] = (u8)((Address & 0xFF0000) >> 16);
	WriteBuffer[ADDRESS_2_OFFSET] = (u8)((Address & 0xFF00) >> 8);
	WriteBuffer[ADDRESS_3_OFFSET] = (u8)(Address & 0xFF);


	XQspiPs_PolledTransfer(QspiPtr, WriteBuffer, NULL,
			ByteCount + OVERHEAD_SIZE);


	while (1) {

		XQspiPs_PolledTransfer(QspiPtr, ReadStatusCmd, FlashStatus,
				sizeof(ReadStatusCmd));


		if ((FlashStatus[1] & 0x01) == 0) {
			break;
		}
	}
}


void FlashRead(XQspiPs *QspiPtr, u32 Address, u32 ByteCount, u8 Command)
{

	WriteBuffer[COMMAND_OFFSET]   = Command;
	WriteBuffer[ADDRESS_1_OFFSET] = (u8)((Address & 0xFF0000) >> 16);
	WriteBuffer[ADDRESS_2_OFFSET] = (u8)((Address & 0xFF00) >> 8);
	WriteBuffer[ADDRESS_3_OFFSET] = (u8)(Address & 0xFF);

	if ((Command == FAST_READ_CMD) || (Command == DUAL_READ_CMD) ||
			(Command == QUAD_READ_CMD)) {
		ByteCount += DUMMY_SIZE;
	}

	XQspiPs_PolledTransfer(QspiPtr, WriteBuffer, ReadBuffer,
			ByteCount + OVERHEAD_SIZE);
}


void FlashErase(XQspiPs *QspiPtr, u32 Address, u32 ByteCount)
{
	u8 WriteEnableCmd = { WRITE_ENABLE_CMD };
	u8 ReadStatusCmd[] = { READ_STATUS_CMD, 0 };  /* must send 2 bytes */
	u8 FlashStatus[2];
	u32 RealAddr;
	int Sector;
	unsigned int EraseSecNum ;
	int PercentCurr = -1 ;
	int PercentLast = -1 ;


	if (ByteCount == (NUM_SECTORS * SECTOR_SIZE)) {

		XQspiPs_PolledTransfer(QspiPtr, &WriteEnableCmd, NULL,
				sizeof(WriteEnableCmd));

		WriteBuffer[COMMAND_OFFSET]   = BULK_ERASE_CMD;


		XQspiPs_PolledTransfer(QspiPtr, WriteBuffer, NULL,
				BULK_ERASE_SIZE);


		while (1) {

			XQspiPs_PolledTransfer(QspiPtr, ReadStatusCmd,
					FlashStatus,
					sizeof(ReadStatusCmd));


			if ((FlashStatus[1] & 0x01) == 0) {
				xil_printf("Bulk Erase Done!\r\n") ;
				break;
			}
		}

		return;
	}



	EraseSecNum = ((ByteCount / SECTOR_SIZE) + 2) ;
	xil_printf("Erase Size is %u Bytes\r\n", EraseSecNum*SECTOR_SIZE) ;

	for (Sector = 0; Sector < EraseSecNum ; Sector++) {

		PercentCurr = (int)(((float)Sector/(float)EraseSecNum)*10) ;

		if (PercentCurr != PercentLast)
			print_percent(PercentCurr) ;

		PercentLast = PercentCurr ;



		XQspiPs_PolledTransfer(QspiPtr, &WriteEnableCmd, NULL,
				sizeof(WriteEnableCmd));



		RealAddr = Address / 2;

		WriteBuffer[COMMAND_OFFSET]   = SEC_ERASE_CMD;
		WriteBuffer[ADDRESS_1_OFFSET] = (u8)(RealAddr >> 16);
		WriteBuffer[ADDRESS_2_OFFSET] = (u8)(RealAddr >> 8);
		WriteBuffer[ADDRESS_3_OFFSET] = (u8)(RealAddr & 0xFF);


		XQspiPs_PolledTransfer(QspiPtr, WriteBuffer, NULL,
				SEC_ERASE_SIZE);




		while (1) {

			XQspiPs_PolledTransfer(QspiPtr, ReadStatusCmd,
					FlashStatus,
					sizeof(ReadStatusCmd));


			if ((FlashStatus[1] & 0x01) == 0) {
				break;
			}
		}

		Address += SECTOR_SIZE;
	}
}


int FlashReadID(void)
{
	int Status;


	WriteBuffer[COMMAND_OFFSET]   = READ_ID;
	WriteBuffer[ADDRESS_1_OFFSET] = 0x23;		/* 3 dummy bytes */
	WriteBuffer[ADDRESS_2_OFFSET] = 0x08;
	WriteBuffer[ADDRESS_3_OFFSET] = 0x09;

	Status = XQspiPs_PolledTransfer(&QspiInstance, WriteBuffer, ReadBuffer,
			RD_ID_SIZE);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	xil_printf("FlashID=0x%x 0x%x 0x%x\n\r", ReadBuffer[1], ReadBuffer[2],
			ReadBuffer[3]);

	return XST_SUCCESS;
}


void print_percent(int percent)
{
	switch(percent)
	{
	case 0 : xil_printf("0%%..") ; break ;
	case 1 : xil_printf("10%%..") ; break ;
	case 2 : xil_printf("20%%..") ; break ;
	case 3 : xil_printf("30%%..") ; break ;
	case 4 : xil_printf("40%%..") ; break ;
	case 5 : xil_printf("50%%..") ; break ;
	case 6 : xil_printf("60%%..") ; break ;
	case 7 : xil_printf("70%%..") ; break ;
	case 8 : xil_printf("80%%..") ; break ;
	case 9 : xil_printf("90%%..") ; break ;
	case 10 : xil_printf("100%..") ; break ;
	default : break ;
	}
}

