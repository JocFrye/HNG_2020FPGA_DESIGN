#include <stdio.h>
#include "xparameters.h"
#include "netif/xadapter.h"
#include "platform.h"
#include "platform_config.h"
#if defined (__arm__) || defined(__aarch64__)
#include "xil_printf.h"
#endif
#include "lwip/err.h"
#include "lwip/tcp.h"
#include "xil_cache.h"
#include "qspi_ctrl/qspi.h"
#include "main.h"

extern XQspiPs QspiInstance;

char FlashRxBuffer[MAX_FLASH_LEN] ;
unsigned int ReceivedCount = 0 ;

int StartUpdate = 0 ;

static struct tcp_pcb *tcp_pcb = NULL;


void print_app_header();
int start_application();
int transfer_data();
void tcp_fasttmr(void);
void tcp_slowtmr(void);


void lwip_init();


extern volatile int TcpFastTmrFlag;
extern volatile int TcpSlowTmrFlag;
static struct netif server_netif;
struct netif *echo_netif;

int transfer_data() {
	return 0;
}

void print_app_header()
{
	xil_printf("\n\r\n\r-----lwIP TCP Remote Update ------\n\r");
	xil_printf("TCP packets receive from port 8080\n\r");
}

void
print_ip(char *msg, struct ip_addr *ip) 
{
	print(msg);
	xil_printf("%d.%d.%d.%d\n\r", ip4_addr1(ip), ip4_addr2(ip), 
			ip4_addr3(ip), ip4_addr4(ip));
}

void
print_ip_settings(struct ip_addr *ip, struct ip_addr *mask, struct ip_addr *gw)
{

	print_ip("Board IP: ", ip);
	print_ip("Netmask : ", mask);
	print_ip("Gateway : ", gw);
}





int main()
{
	i2c_init(&ps_i2c0, XPAR_XIICPS_0_DEVICE_ID,100000);
	i2c_init(&ps_i2c1, XPAR_XIICPS_1_DEVICE_ID,100000);

	sensor_rst(&cmos_rstn, XPAR_CMOS_RST_DEVICE_ID);

	adv7511_init(&ps_i2c0) ;

	sensor_init(&ps_i2c0);
	sensor_init(&ps_i2c1);

	Xil_Out32((XPAR_OBJDET_0_S_AXI_AXILITES_BASEADDR + XOBJDET_AXILITES_ADDR_THRESHOLD_DATA), 40);
	Xil_Out32((XPAR_OBJDET_1_S_AXI_AXILITES_BASEADDR + XOBJDET_AXILITES_ADDR_THRESHOLD_DATA), 40);

	CamVdmaWriteInit();

	DisplayInitialize(&dispCtrl,  DISP_VTC_ID, DYNCLK_BASEADDR, DEMO_STRIDE);
	DisplayStart(&dispCtrl);

	FrameVdmaReadStart(&dispCtrl);
	gpio_init();

	int Status ;
	struct ip_addr ipaddr, netmask, gw;

	unsigned char mac_ethernet_address[] =
	{ 0x00, 0x0a, 0x35, 0x01, 0x01, 0x02 };

	echo_netif = &server_netif;

	IP4_ADDR(&ipaddr,  192, 168,   1, 10);
	IP4_ADDR(&netmask, 255, 255, 255,  0);
	IP4_ADDR(&gw,      192, 168,   1,  1);
	print_app_header();
	lwip_init();

	if (!xemac_add(echo_netif, &ipaddr, &netmask,
			&gw, mac_ethernet_address,
			PLATFORM_EMAC_BASEADDR)) {
		xil_printf("Error adding N/W interface\n\r");
		return -1;
	}
	netif_set_default(echo_netif);
	platform_enable_interrupts();
	netif_set_up(echo_netif);
	print_ip_settings(&ipaddr, &netmask, &gw);
	start_application();

	while (1) {

		int x0 ,  x1 ;
		int absdis;

		x0   = Xil_In32((XPAR_LOCATE_0_BASEADDR + 0x000));
		x1   = Xil_In32((XPAR_LOCATE_0_BASEADDR + 0x004));

		absdis = (x0 - x1) > 0 ? (x0 - x1) : (x1 - x0);
		Xil_Out32((XPAR_LOCATE_0_BASEADDR + 0x008), 100);

        if(3014/absdis > 30){
        	gpio_set_led();
        }
        else{
        	gpio_reset_led();
        }

        printf("the distance is %d CM\n",3014/absdis);
        sleep(1);


		if (TcpFastTmrFlag) {
			tcp_fasttmr();
			TcpFastTmrFlag = 0;
		}
		if (TcpSlowTmrFlag) {
			tcp_slowtmr();
			TcpSlowTmrFlag = 0;
		}
		xemacif_input(echo_netif);
		if (StartUpdate)
		{
			Status = update_qspi(&QspiInstance, QSPI_DEVICE_ID, ReceivedCount, FlashRxBuffer) ;
			if (Status != XST_SUCCESS)
				xil_printf("Update Flash Error!\r\n") ;

			StartUpdate = 0 ;
			ReceivedCount = 0;
		}

	}


	return 0;
}



err_t recv_callback(void *arg, struct tcp_pcb *tpcb,
		struct pbuf *p, err_t err)
{
	char *pData;

	if (!p) {
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
		return ERR_OK;
	}

	tcp_recved(tpcb, p->len);

	pData = (char *) p->payload;

	int udp_len = p->len ;


	if (!(memcmp("update", p->payload + p->len - 6, 6)))
	{
		memcpy(&FlashRxBuffer[ReceivedCount], pData, udp_len - 6);
		ReceivedCount += udp_len - 6 ;
		xil_printf("Received Size is %u Bytes\r\n", ReceivedCount) ;
		xil_printf("Initialization done, programming the memory\r\n") ;
		StartUpdate = 1 ;
	}
	else
	{
		memcpy(&FlashRxBuffer[ReceivedCount], pData, udp_len);
		ReceivedCount += udp_len ;
	}

	pbuf_free(p);

	return ERR_OK;
}

err_t accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err)
{
	static int connection = 1;

	tcp_recv(newpcb, recv_callback);

	tcp_arg(newpcb, (void*)(UINTPTR)connection);

	connection++;

	return ERR_OK;
}


int start_application()
{
	err_t err;
	unsigned port = 8080;

	tcp_pcb = tcp_new();
	if (!tcp_pcb) {
		xil_printf("Error creating PCB. Out of Memory\n\r");
		return -1;
	}

	err = tcp_bind(tcp_pcb, IP_ADDR_ANY, port);
	if (err != ERR_OK) {
		xil_printf("Unable to bind to port %d: err = %d\n\r", port, err);
		return -2;
	}

	tcp_arg(tcp_pcb, NULL);

	tcp_pcb = tcp_listen(tcp_pcb);
	if (!tcp_pcb) {
		xil_printf("Out of memory while tcp_listen\n\r");
		return -3;
	}

	tcp_accept(tcp_pcb, accept_callback);

	xil_printf("TCP echo server started @ port %d\n\r", port);

	return 0;
}


