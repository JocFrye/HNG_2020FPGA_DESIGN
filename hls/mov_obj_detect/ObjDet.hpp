

#include "hls_video.h"

#define MAX_WIDTH  960
#define MAX_HEIGHT 540

#define BREADTH 5
#define THRESHOLD 40
#define DISTANCE 10

typedef ap_uint<24> int24;
typedef	ap_uint<8> int8;

typedef ap_axiu<24, 1, 1, 1> us_pixel_t;
typedef hls::stream<us_pixel_t> ustream_t;

typedef hls::Mat<MAX_HEIGHT, MAX_WIDTH, HLS_8UC3> RgbImage;
typedef hls::Mat<MAX_HEIGHT, MAX_WIDTH, HLS_8UC1> GrayImage;

typedef hls::Scalar<3, unsigned char>  RgbPixel;
typedef hls::Scalar<1, unsigned char>  GrayPixel;

void ObjDet(ustream_t& src_axi0,ustream_t& src_axi1, ustream_t& dst_axi);



