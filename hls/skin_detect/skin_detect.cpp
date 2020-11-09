#include <hls_stream.h>
#include <hls_video.h>
#include <ap_axi_sdata.h>
#include "skin_detect.hpp"

void SkinDetect (ustream_t& background,ustream_t& src_axi0, ustream_t& src_axi1,ustream_t& dst_axi,
		unsigned char Ymin,unsigned char Ymax,unsigned char Cbmin,unsigned char Cbmax,unsigned char Crmin,unsigned char Crmax,
		unsigned int* x_out) {

#pragma HLS INTERFACE axis register both port=x_out
#pragma HLS INTERFACE axis port=background
#pragma HLS INTERFACE axis port=src_axi0
#pragma HLS INTERFACE axis port=src_axi1
#pragma HLS INTERFACE axis port=dst_axi
#pragma HLS INTERFACE s_axilite port=Cbmin
#pragma HLS INTERFACE s_axilite port=Cbmax
#pragma HLS INTERFACE s_axilite port=Crmin
#pragma HLS INTERFACE s_axilite port=Crmax
#pragma HLS INTERFACE s_axilite port=Ymin
#pragma HLS INTERFACE s_axilite port=Ymax
#pragma HLS INTERFACE ap_ctrl_none port=return

	RgbImage background_image;
    RgbImage rgb_image0;
    RgbImage rgb_image1;
    RgbImage res;

    int i,j;
#pragma HLS DATAFLOW

    hls::AXIvideo2Mat(background, background_image);
    hls::AXIvideo2Mat(src_axi0, rgb_image0);
    hls::AXIvideo2Mat(src_axi1, rgb_image1);

    unsigned int xmin , xmax , ymin , ymax;


    for (int row = 0; row < MAX_HEIGHT; row++){

    	for (int col = 0; col < MAX_WIDTH; col++){

    	#pragma HLS pipeline II = 1 off

    			RgbPixel src_data0;
    			RgbPixel src_data1;
    			RgbPixel dst_data;


    			if (row < MAX_HEIGHT && col < MAX_WIDTH)
    			{
    				rgb_image0 >> src_data0;
    				rgb_image1 >> src_data1;
    			}


    			unsigned char B0 = src_data0.val[0];
    			unsigned char G0 = src_data0.val[1];
    			unsigned char R0 = src_data0.val[2];

    			unsigned char Y0 = (76 * R0 + 150 * G0 + 29 * B0) >> 8;
    			unsigned char Cb0 = ((128 * B0 - 43 * R0 - 85 * G0) >> 8) + 128;
    			unsigned char Cr0 = ((128 * R0 - 107 * G0 - 21 * B0) >> 8) + 128;

    			unsigned char B1 = src_data1.val[0];
    			unsigned char G1 = src_data1.val[1];
    			unsigned char R1 = src_data1.val[2];

    			unsigned char Y1 = (76 * R1 + 150 * G1 + 29 * B1) >> 8;
    			unsigned char Cb1 = ((128 * B1 - 43 * R1 - 85 * G1) >> 8) + 128;
    			unsigned char Cr1 = ((128 * R1 - 107 * G1 - 21 * B1) >> 8) + 128;

    			if(row==0 && col==0){
    				xmin = MAX_WIDTH;
					xmax = 0;
					ymin = MAX_HEIGHT;
					ymax = 0;
    			}

    		    if(Y0 > Ymin && Y0 < Ymax && Cb0 > Cbmin && Cb0 < Cbmax && Cr0 > Crmin && Cr0 < Crmax && Y1 > Ymin && Y1 < Ymax && Cb1 > Cbmin && Cb1 < Cbmax && Cr1 > Crmin && Cr1 < Crmax){
                    if(xmin > col)
                        xmin = col;
                    if(xmax < col)
                        xmax = col;
                    if(ymin > row)
                        ymin = row;
                    if(ymax < row)
                    	ymax = row;
    		    }
    		    if(row == MAX_HEIGHT-1 && col == MAX_WIDTH-1){
    		   	    *x_out = (xmin + xmax) / 2;

    		   	 }

    	}
    }


    for (int row = 0; row < MAX_HEIGHT; row++){

    		for (int col = 0; col < MAX_WIDTH; col++)
    		{
                #pragma HLS pipeline II = 1 off

    			RgbPixel back_data;

    			if (row < MAX_HEIGHT && col < MAX_WIDTH)
    			{
    				background_image >> back_data;

    			}

                if(row == ymin && col >= xmin && col <= xmax){
                	back_data.val[0] = 0;
					back_data.val[1] = 0;
					back_data.val[2] = 255;
                }
                else if(row > ymin && row < ymax && (col == xmin  || col == xmax)){
                	back_data.val[0] = 0;
					back_data.val[1] = 0;
					back_data.val[2] = 255;
                }
				else if(row == ymax && col >= xmin && col <= xmax){
                	back_data.val[0] = 0;
					back_data.val[1] = 0;
					back_data.val[2] = 255;
    		    }

                res << back_data;

    		}
    	}


    hls::Mat2AXIvideo(res, dst_axi);

}
