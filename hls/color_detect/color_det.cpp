#include <hls_stream.h>
#include <hls_video.h>
#include <ap_axi_sdata.h>
#include "color_det.hpp"

void color_det(ustream_t& back0,ustream_t& src_axi0,ustream_t& dst_axi0,
		unsigned char thre_r_min,unsigned char thre_g_min,unsigned char thre_b_min,
		unsigned char thre_r_max,unsigned char thre_g_max,unsigned char thre_b_max,
		unsigned int* x_out) {

#pragma HLS INTERFACE axis register both port=x_out
#pragma HLS INTERFACE axis port=back0
#pragma HLS INTERFACE axis port=src_axi0
#pragma HLS INTERFACE axis port=dst_axi0

#pragma HLS INTERFACE s_axilite port=thre_r_min
#pragma HLS INTERFACE s_axilite port=thre_g_min
#pragma HLS INTERFACE s_axilite port=thre_b_min
#pragma HLS INTERFACE s_axilite port=thre_r_max
#pragma HLS INTERFACE s_axilite port=thre_g_max
#pragma HLS INTERFACE s_axilite port=thre_b_max

#pragma HLS INTERFACE ap_ctrl_none port=return

    RgbImage back0_image;
    RgbImage rgb_image0;


    RgbImage res_image0;

#pragma HLS DATAFLOW

    hls::AXIvideo2Mat(back0, back0_image);
    hls::AXIvideo2Mat(src_axi0, rgb_image0);

    unsigned int xmin0 , xmax0 , ymin0 , ymax0;

    for (int row = 0; row < MAX_HEIGHT; row++){
        for (int col = 0; col < MAX_WIDTH; col++){
        	#pragma HLS pipeline II = 1 off

        	RgbPixel src_data0;

        	rgb_image0 >> src_data0;

        	if(row==0 && col==0){
        		xmin0 = MAX_WIDTH;
        		xmax0 = 0;
        		ymin0 = MAX_HEIGHT;
        		ymax0 = 0;

        	}

            if(src_data0.val[2] > thre_r_min && src_data0.val[2] < thre_r_max &&
               src_data0.val[1] > thre_g_min && src_data0.val[1] < thre_g_max &&
			   src_data0.val[0] > thre_b_min && src_data0.val[0] < thre_b_max){

                if(xmin0 > col)
                    xmin0 = col;
                if(xmax0 < col)
                    xmax0 = col;
                if(ymin0 > row)
                    ymin0 = row;
                if(ymax0 < row)
                  	ymax0 = row;
            }

            if(row == MAX_HEIGHT-1 && col == MAX_WIDTH-1){
                *x_out = (xmin0 + xmax0) / 2;

            }

        }
    }

    for (int row = 0; row < MAX_HEIGHT; row++){

       		for (int col = 0; col < MAX_WIDTH; col++)
       		{
                #pragma HLS pipeline II = 1 off

       			RgbPixel back_data0;

       			back0_image >> back_data0;


                if(row == ymin0 && col >= xmin0 && col <= xmax0){
                   	back_data0.val[0] = 0;
   					back_data0.val[1] = 0;
   					back_data0.val[2] = 255;
                }
                else if(row > ymin0 && row < ymax0 && (col == xmin0  || col == xmax0)){
                   	back_data0.val[0] = 0;
   					back_data0.val[1] = 0;
   					back_data0.val[2] = 255;
                }
   				else if(row == ymax0 && col >= xmin0 && col <= xmax0){
                   	back_data0.val[0] = 0;
   					back_data0.val[1] = 0;
   					back_data0.val[2] = 255;
       		    }

                   res_image0 << back_data0;
       		}
    }



    hls::Mat2AXIvideo(res_image0, dst_axi0);


}



