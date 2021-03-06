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


// IP VLNV: xilinx.com:user:locate:1.0
// IP Revision: 2

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module mov_obj_det_locate_0_0 (
  clk,
  rst,
  c0_axis_tdata,
  c0_axis_tvalid,
  c0_axis_tready,
  c1_axis_tdata,
  c1_axis_tvalid,
  c1_axis_tready,
  axil_s_awaddr,
  axil_s_awprot,
  axil_s_awvalid,
  axil_s_awready,
  axil_s_wdata,
  axil_s_wvalid,
  axil_s_wstrb,
  axil_s_wready,
  axil_s_bresp,
  axil_s_bvalid,
  axil_s_bready,
  axil_s_araddr,
  axil_s_arprot,
  axil_s_arvalid,
  axil_s_arready,
  axil_s_rdata,
  axil_s_rresp,
  axil_s_rvalid,
  axil_s_rready
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF c0_axis:c1_axis:axil_s, ASSOCIATED_RESET rst, FREQ_HZ 142857132, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 c0_axis TDATA" *)
input wire [31 : 0] c0_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 c0_axis TVALID" *)
input wire c0_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME c0_axis, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 142857132, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 c0_axis TREADY" *)
output wire c0_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 c1_axis TDATA" *)
input wire [31 : 0] c1_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 c1_axis TVALID" *)
input wire c1_axis_tvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME c1_axis, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 142857132, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {CLK {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0}}}}" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 c1_axis TREADY" *)
output wire c1_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s AWADDR" *)
input wire [31 : 0] axil_s_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s AWPROT" *)
input wire [2 : 0] axil_s_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s AWVALID" *)
input wire axil_s_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s AWREADY" *)
output wire axil_s_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s WDATA" *)
input wire [31 : 0] axil_s_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s WVALID" *)
input wire axil_s_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s WSTRB" *)
input wire [3 : 0] axil_s_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s WREADY" *)
output wire axil_s_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s BRESP" *)
output wire [1 : 0] axil_s_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s BVALID" *)
output wire axil_s_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s BREADY" *)
input wire axil_s_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s ARADDR" *)
input wire [31 : 0] axil_s_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s ARPROT" *)
input wire [2 : 0] axil_s_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s ARVALID" *)
input wire axil_s_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s ARREADY" *)
output wire axil_s_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s RDATA" *)
output wire [31 : 0] axil_s_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s RRESP" *)
output wire [1 : 0] axil_s_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s RVALID" *)
output wire axil_s_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axil_s, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 142857132, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN mov_obj_det_processing_system7_0_0_FCLK_CLK1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axil_s RREADY" *)
input wire axil_s_rready;

  locate inst (
    .clk(clk),
    .rst(rst),
    .c0_axis_tdata(c0_axis_tdata),
    .c0_axis_tvalid(c0_axis_tvalid),
    .c0_axis_tready(c0_axis_tready),
    .c1_axis_tdata(c1_axis_tdata),
    .c1_axis_tvalid(c1_axis_tvalid),
    .c1_axis_tready(c1_axis_tready),
    .axil_s_awaddr(axil_s_awaddr),
    .axil_s_awprot(axil_s_awprot),
    .axil_s_awvalid(axil_s_awvalid),
    .axil_s_awready(axil_s_awready),
    .axil_s_wdata(axil_s_wdata),
    .axil_s_wvalid(axil_s_wvalid),
    .axil_s_wstrb(axil_s_wstrb),
    .axil_s_wready(axil_s_wready),
    .axil_s_bresp(axil_s_bresp),
    .axil_s_bvalid(axil_s_bvalid),
    .axil_s_bready(axil_s_bready),
    .axil_s_araddr(axil_s_araddr),
    .axil_s_arprot(axil_s_arprot),
    .axil_s_arvalid(axil_s_arvalid),
    .axil_s_arready(axil_s_arready),
    .axil_s_rdata(axil_s_rdata),
    .axil_s_rresp(axil_s_rresp),
    .axil_s_rvalid(axil_s_rvalid),
    .axil_s_rready(axil_s_rready)
  );
endmodule
