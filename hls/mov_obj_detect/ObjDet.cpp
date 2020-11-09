#include <hls_stream.h>
#include <hls_video.h>
#include <ap_axi_sdata.h>
#include "ObjDet.hpp"



void ObjDet(ustream_t& background,ustream_t& src_axi0,ustream_t& src_axi1, ustream_t& dst_axi, unsigned char threshold
		, unsigned int* x_out) {
#pragma HLS INTERFACE axis register both port=x_out
#pragma HLS INTERFACE axis port=background
#pragma HLS INTERFACE axis port=src_axi0
#pragma HLS INTERFACE axis port=src_axi1
#pragma HLS INTERFACE axis port=dst_axi
#pragma HLS INTERFACE s_axilite port=threshold
#pragma HLS INTERFACE ap_ctrl_none port=return

	RgbImage background_image;
    RgbImage rgb_image0;
    RgbImage rgb_image1;

    GrayImage gray_image0;
    GrayImage gray_image1;

    GrayImage diff_image;
    GrayImage binaryzation_image;

    RgbImage res;

    hls::Window<3,3,char> dilate_kernel;

    int i,j;

#pragma HLS DATAFLOW

    hls::AXIvideo2Mat(background, background_image);
    hls::AXIvideo2Mat(src_axi0, rgb_image0);
    hls::AXIvideo2Mat(src_axi1, rgb_image1);

    hls::CvtColor<HLS_RGB2GRAY>(rgb_image0, gray_image0);
    hls::CvtColor<HLS_RGB2GRAY>(rgb_image1, gray_image1);

    hls::AbsDiff(gray_image0,gray_image1,diff_image);
    hls::Threshold(diff_image,binaryzation_image,threshold,255,HLS_THRESH_BINARY);


    
    GrayPixel lastin_pix;
    unsigned int xmin0 , xmax0 , ymin0 , ymax0;

    for (int row = 0; row < MAX_HEIGHT; row++)
	    {
	     	    lastin_pix.val[0] = 0;
	     		for (int col = 0; col < MAX_WIDTH; col++)
	     		{

	     			GrayPixel curin_pix;
	     			RgbPixel out_pix;

	     			binaryzation_image >> curin_pix;

                    if(row==0 && col==0){
        				xmin0 = MAX_WIDTH;
        				xmax0 = 0;
        				ymin0 = MAX_HEIGHT;
        				ymax0 = 0;
        			}

	     			if ((curin_pix.val[0] == 0 && lastin_pix.val[0] == 255) || (curin_pix.val[0] == 255 && lastin_pix.val[0] == 0))
	     			{
	     				if(xmin0 > col)
                            xmin0 = col;
                        if(xmax0 < col)
                            xmax0 = col;
                        if(ymin0 > row)
                            ymin0 = row;
                        if(ymax0 < row)
                        	ymax0 = row;
	     			}
	     			
	     			lastin_pix.val[0] = curin_pix.val[0];

	                if(row == MAX_HEIGHT-1 && col == MAX_WIDTH-1){
	                    *x_out = (xmin0 + xmax0) / 2;

	                }

	     		}
	     }

    RgbPixel background_pix;

    for (int row = 0; row < MAX_HEIGHT; row++){
	    for (int col = 0; col < MAX_WIDTH; col++){

	    		background_image >>  background_pix;
	    		

                if(row == ymin0 && col >= xmin0 && col <= xmax0){
                   	background_pix.val[0] = 0;
   					background_pix.val[1] = 0;
   					background_pix.val[2] = 255;
                }
                else if(row > ymin0 && row < ymax0 && (col == xmin0  || col == xmax0)){
                   	background_pix.val[0] = 0;
   					background_pix.val[1] = 0;
   					background_pix.val[2] = 255;
                }
   				else if(row == ymax0 && col >= xmin0 && col <= xmax0){
                   	background_pix.val[0] = 0;
   					background_pix.val[1] = 0;
   					background_pix.val[2] = 255;
       		    }

	    		res << background_pix;
	    }

	}


    hls::Mat2AXIvideo(res, dst_axi);

}



