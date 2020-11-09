


#ifndef SRC_QSPI_H_
#define SRC_QSPI_H_


#include "xparameters.h"
#include "xqspips.h"
#include "xil_printf.h"



#define QSPI_DEVICE_ID		XPAR_XQSPIPS_0_DEVICE_ID


#define MAX_FLASH_LEN   32*1024*1024

#define WRITE_STATUS_CMD	0x01
#define WRITE_CMD		0x02
#define READ_CMD		0x03
#define WRITE_DISABLE_CMD	0x04
#define READ_STATUS_CMD		0x05
#define WRITE_ENABLE_CMD	0x06
#define FAST_READ_CMD		0x0B
#define DUAL_READ_CMD		0x3B
#define QUAD_READ_CMD		0x6B
#define BULK_ERASE_CMD		0xC7
#define	SEC_ERASE_CMD		0xD8
#define READ_ID			0x9F


#define COMMAND_OFFSET		0
#define ADDRESS_1_OFFSET	1
#define ADDRESS_2_OFFSET	2
#define ADDRESS_3_OFFSET	3
#define DATA_OFFSET		4
#define DUMMY_OFFSET		4

#define DUMMY_SIZE		1

#define RD_ID_SIZE		4
#define BULK_ERASE_SIZE		1
#define SEC_ERASE_SIZE		4


#define OVERHEAD_SIZE		4


#define SECTOR_SIZE		0x20000
#define NUM_SECTORS		0x100
#define NUM_PAGES		0x10000
#define PAGE_SIZE		512


#define PAGE_COUNT		16


#define TEST_ADDRESS		0x00055000
#define UNIQUE_VALUE		0x05

#define MAX_DATA		PAGE_COUNT * PAGE_SIZE



#define LQSPI_CR_FAST_QUAD_READ		0x0000006B /* Fast Quad Read output */
#define LQSPI_CR_1_DUMMY_BYTE		0x00000100 /* 1 Dummy Byte between */

#define DUAL_QSPI_CONFIG		(XQSPIPS_LQSPI_CR_TWO_MEM_MASK | \
					 XQSPIPS_LQSPI_CR_SEP_BUS_MASK | \
					 LQSPI_CR_1_DUMMY_BYTE | \
					 LQSPI_CR_FAST_QUAD_READ)





int update_qspi(XQspiPs *QspiInstancePtr, u16 QspiDeviceId, unsigned int TotoalLen, char *FlashDataToSend) ;

#endif
