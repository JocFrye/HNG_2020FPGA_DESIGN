// (c) Copyright 1995-2020 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:hls:SkinDetect:1.0
// IP Revision: 2011022128

(* X_CORE_INFO = "SkinDetect,Vivado 2017.4" *)
(* CHECK_LICENSE_TYPE = "mov_obj_det_SkinDetect_0_1,SkinDetect,{}" *)
(* CORE_GENERATION_INFO = "mov_obj_det_SkinDetect_0_1,SkinDetect,{x_ipProduct=Vivado 2017.4,x_ipVendor=xilinx.com,x_ipLibrary=hls,x_ipName=SkinDetect,x_ipVersion=1.0,x_ipCoreRevision=2011022128,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_S_AXI_AXILITES_ADDR_WIDTH=6,C_S_AXI_AXILITES_DATA_WIDTH=32}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module mov_obj_det_SkinDetect_0_1 (
  s_axi_AXILiteS_AWADDR,
  s_axi_AXILiteS_AWVALID,
  s_axi_AXILiteS_AWREADY,
  s_axi_AXILiteS_WDATA,
  s_axi_AXILiteS_WSTRB,
  s_axi_AXILiteS_WVALID,
  s_axi_AXILiteS_WREADY,
  s_axi_AXILiteS_BRESP,
  s_axi_AXILiteS_BVALID,
  s_axi_AXILiteS_BREADY,
  s_axi_AXILiteS_ARADDR,
  s_axi_AXILiteS_ARVALID,
  s_axi_AXILiteS_ARREADY,
  s_axi_AXILiteS_RDATA,
  s_axi_AXILiteS_RRESP,
  s_axi_AXILiteS_RVALID,
  s_axi_AXILiteS_RREADY,
  ap_clk,
  ap_rst_n,
  background_TVALID,
  background_TREADY,
  background_TDATA,
  background_TKEEP,
  background_TSTRB,
  background_TUSER,
  background_TLAST,
  background_TID,
  background_TDEST,
  src_axi0_TVALID,
  src_axi0_TREADY,
  src_axi0_TDATA,
  src_axi0_TKEEP,
  src_axi0_TSTRB,
  src_axi0_TUSER,
  src_axi0_TLAST,
  src_axi0_TID,
  src_axi0_TDEST,
  src_axi1_TVALID,
  src_axi1_TREADY,
  src_axi1_TDATA,
  src_axi1_TKEEP,
  src_axi1_TSTRB,
  src_axi1_TUSER,
  src_axi1_TLAST,
  src_axi1_TID,
  src_axi1_TDEST,
  dst_axi_TVALID,
  dst_axi_TREADY,
  dst_axi_TDATA,
  dst_axi_TKEEP,
  dst_axi_TSTRB,
  dst_axi_TUSER,
  dst_axi_TLAST,
  dst_axi_TID,
  dst_axi_TDEST,
  x_out_TVALID,
  x_out_TREADY,
  x_out_TDATA
);

(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS AWADDR" *)
input wire [5 : 0] s_axi_AXILiteS_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS AWVALID" *)
input wire s_axi_AXILiteS_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS AWREADY" *)
output wire s_axi_AXILiteS_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS WDATA" *)
input wire [31 : 0] s_axi_AXILiteS_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS WSTRB" *)
input wire [3 : 0] s_axi_AXILiteS_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS WVALID" *)
input wire s_axi_AXILiteS_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS WREADY" *)
output wire s_axi_AXILiteS_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS BRESP" *)
output wire [1 : 0] s_axi_AXILiteS_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS BVALID" *)
output wire s_axi_AXILiteS_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS BREADY" *)
input wire s_axi_AXILiteS_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS ARADDR" *)
input wire [5 : 0] s_axi_AXILiteS_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS ARVALID" *)
input wire s_axi_AXILiteS_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS ARREADY" *)
output wire s_axi_AXILiteS_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS RDATA" *)
output wire [31 : 0] s_axi_AXILiteS_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS RRESP" *)
output wire [1 : 0] s_axi_AXILiteS_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS RVALID" *)
output wire s_axi_AXILiteS_RVALID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi_AXILiteS, ADDR_WIDTH 6, DATA_WIDTH 32, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, FREQ_HZ 142857132, ID_WIDTH 0, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_AXILiteS RREADY" *)
input wire s_axi_AXILiteS_RREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_clk, ASSOCIATED_BUSIF s_axi_AXILiteS:background:src_axi0:src_axi1:dst_axi:x_out, ASSOCIATED_RESET ap_rst_n, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}, FREQ_HZ 142857132, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ap_clk CLK" *)
input wire ap_clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ap_rst_n, POLARITY ACTIVE_LOW, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {RST {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 ap_rst_n RST" *)
input wire ap_rst_n;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 background TVALID" *)
input wire background_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 background TREADY" *)
output wire background_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 background TDATA" *)
input wire [23 : 0] background_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 background TKEEP" *)
input wire [2 : 0] background_TKEEP;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 background TSTRB" *)
input wire [2 : 0] background_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 background TUSER" *)
input wire [0 : 0] background_TUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 background TLAST" *)
input wire [0 : 0] background_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 background TID" *)
input wire [0 : 0] background_TID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME background, TDATA_NUM_BYTES 3, TDEST_WIDTH 1, TID_WIDTH 1, TUSER_WIDTH 1, LAYERED_METADATA undef, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 142857132, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 background TDEST" *)
input wire [0 : 0] background_TDEST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi0 TVALID" *)
input wire src_axi0_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi0 TREADY" *)
output wire src_axi0_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi0 TDATA" *)
input wire [23 : 0] src_axi0_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi0 TKEEP" *)
input wire [2 : 0] src_axi0_TKEEP;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi0 TSTRB" *)
input wire [2 : 0] src_axi0_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi0 TUSER" *)
input wire [0 : 0] src_axi0_TUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi0 TLAST" *)
input wire [0 : 0] src_axi0_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi0 TID" *)
input wire [0 : 0] src_axi0_TID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME src_axi0, TDATA_NUM_BYTES 3, TDEST_WIDTH 1, TID_WIDTH 1, TUSER_WIDTH 1, LAYERED_METADATA undef, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 142857132, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi0 TDEST" *)
input wire [0 : 0] src_axi0_TDEST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi1 TVALID" *)
input wire src_axi1_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi1 TREADY" *)
output wire src_axi1_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi1 TDATA" *)
input wire [23 : 0] src_axi1_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi1 TKEEP" *)
input wire [2 : 0] src_axi1_TKEEP;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi1 TSTRB" *)
input wire [2 : 0] src_axi1_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi1 TUSER" *)
input wire [0 : 0] src_axi1_TUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi1 TLAST" *)
input wire [0 : 0] src_axi1_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi1 TID" *)
input wire [0 : 0] src_axi1_TID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME src_axi1, TDATA_NUM_BYTES 3, TDEST_WIDTH 1, TID_WIDTH 1, TUSER_WIDTH 1, LAYERED_METADATA undef, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 142857132, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 src_axi1 TDEST" *)
input wire [0 : 0] src_axi1_TDEST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst_axi TVALID" *)
output wire dst_axi_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst_axi TREADY" *)
input wire dst_axi_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst_axi TDATA" *)
output wire [23 : 0] dst_axi_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst_axi TKEEP" *)
output wire [2 : 0] dst_axi_TKEEP;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst_axi TSTRB" *)
output wire [2 : 0] dst_axi_TSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst_axi TUSER" *)
output wire [0 : 0] dst_axi_TUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst_axi TLAST" *)
output wire [0 : 0] dst_axi_TLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst_axi TID" *)
output wire [0 : 0] dst_axi_TID;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME dst_axi, TDATA_NUM_BYTES 3, TDEST_WIDTH 1, TID_WIDTH 1, TUSER_WIDTH 1, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 24} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}} TDATA_WIDTH 24 TUSER {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}} TUSER_WIDTH 1}, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 142857132, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 dst_axi TDEST" *)
output wire [0 : 0] dst_axi_TDEST;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 x_out TVALID" *)
output wire x_out_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 x_out TREADY" *)
input wire x_out_TREADY;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME x_out, TDATA_NUM_BYTES 4, TUSER_WIDTH 0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}} TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}} TDATA_WIDTH 32}, TDEST_WIDTH 0, TID_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 142857132, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 x_out TDATA" *)
output wire [31 : 0] x_out_TDATA;

  SkinDetect #(
    .C_S_AXI_AXILITES_ADDR_WIDTH(6),
    .C_S_AXI_AXILITES_DATA_WIDTH(32)
  ) inst (
    .s_axi_AXILiteS_AWADDR(s_axi_AXILiteS_AWADDR),
    .s_axi_AXILiteS_AWVALID(s_axi_AXILiteS_AWVALID),
    .s_axi_AXILiteS_AWREADY(s_axi_AXILiteS_AWREADY),
    .s_axi_AXILiteS_WDATA(s_axi_AXILiteS_WDATA),
    .s_axi_AXILiteS_WSTRB(s_axi_AXILiteS_WSTRB),
    .s_axi_AXILiteS_WVALID(s_axi_AXILiteS_WVALID),
    .s_axi_AXILiteS_WREADY(s_axi_AXILiteS_WREADY),
    .s_axi_AXILiteS_BRESP(s_axi_AXILiteS_BRESP),
    .s_axi_AXILiteS_BVALID(s_axi_AXILiteS_BVALID),
    .s_axi_AXILiteS_BREADY(s_axi_AXILiteS_BREADY),
    .s_axi_AXILiteS_ARADDR(s_axi_AXILiteS_ARADDR),
    .s_axi_AXILiteS_ARVALID(s_axi_AXILiteS_ARVALID),
    .s_axi_AXILiteS_ARREADY(s_axi_AXILiteS_ARREADY),
    .s_axi_AXILiteS_RDATA(s_axi_AXILiteS_RDATA),
    .s_axi_AXILiteS_RRESP(s_axi_AXILiteS_RRESP),
    .s_axi_AXILiteS_RVALID(s_axi_AXILiteS_RVALID),
    .s_axi_AXILiteS_RREADY(s_axi_AXILiteS_RREADY),
    .ap_clk(ap_clk),
    .ap_rst_n(ap_rst_n),
    .background_TVALID(background_TVALID),
    .background_TREADY(background_TREADY),
    .background_TDATA(background_TDATA),
    .background_TKEEP(background_TKEEP),
    .background_TSTRB(background_TSTRB),
    .background_TUSER(background_TUSER),
    .background_TLAST(background_TLAST),
    .background_TID(background_TID),
    .background_TDEST(background_TDEST),
    .src_axi0_TVALID(src_axi0_TVALID),
    .src_axi0_TREADY(src_axi0_TREADY),
    .src_axi0_TDATA(src_axi0_TDATA),
    .src_axi0_TKEEP(src_axi0_TKEEP),
    .src_axi0_TSTRB(src_axi0_TSTRB),
    .src_axi0_TUSER(src_axi0_TUSER),
    .src_axi0_TLAST(src_axi0_TLAST),
    .src_axi0_TID(src_axi0_TID),
    .src_axi0_TDEST(src_axi0_TDEST),
    .src_axi1_TVALID(src_axi1_TVALID),
    .src_axi1_TREADY(src_axi1_TREADY),
    .src_axi1_TDATA(src_axi1_TDATA),
    .src_axi1_TKEEP(src_axi1_TKEEP),
    .src_axi1_TSTRB(src_axi1_TSTRB),
    .src_axi1_TUSER(src_axi1_TUSER),
    .src_axi1_TLAST(src_axi1_TLAST),
    .src_axi1_TID(src_axi1_TID),
    .src_axi1_TDEST(src_axi1_TDEST),
    .dst_axi_TVALID(dst_axi_TVALID),
    .dst_axi_TREADY(dst_axi_TREADY),
    .dst_axi_TDATA(dst_axi_TDATA),
    .dst_axi_TKEEP(dst_axi_TKEEP),
    .dst_axi_TSTRB(dst_axi_TSTRB),
    .dst_axi_TUSER(dst_axi_TUSER),
    .dst_axi_TLAST(dst_axi_TLAST),
    .dst_axi_TID(dst_axi_TID),
    .dst_axi_TDEST(dst_axi_TDEST),
    .x_out_TVALID(x_out_TVALID),
    .x_out_TREADY(x_out_TREADY),
    .x_out_TDATA(x_out_TDATA)
  );
endmodule
