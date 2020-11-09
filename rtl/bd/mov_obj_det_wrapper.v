//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
//Date        : Thu Nov  5 18:39:03 2020
//Host        : LAPTOP-3F5I417O running 64-bit major release  (build 9200)
//Command     : generate_target mov_obj_det_wrapper.bd
//Design      : mov_obj_det_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mov_obj_det_wrapper
   (DDR_0_addr,
    DDR_0_ba,
    DDR_0_cas_n,
    DDR_0_ck_n,
    DDR_0_ck_p,
    DDR_0_cke,
    DDR_0_cs_n,
    DDR_0_dm,
    DDR_0_dq,
    DDR_0_dqs_n,
    DDR_0_dqs_p,
    DDR_0_odt,
    DDR_0_ras_n,
    DDR_0_reset_n,
    DDR_0_we_n,
    FIXED_IO_0_ddr_vrn,
    FIXED_IO_0_ddr_vrp,
    FIXED_IO_0_mio,
    FIXED_IO_0_ps_clk,
    FIXED_IO_0_ps_porb,
    FIXED_IO_0_ps_srstb,
    cmos1_d,
    cmos1_href,
    cmos1_i2c_scl_io,
    cmos1_i2c_sda_io,
    cmos1_pclk,
    cmos1_vsync,
    cmos2_d,
    cmos2_href,
    cmos2_i2c_scl_io,
    cmos2_i2c_sda_io,
    cmos2_pclk,
    cmos2_vsync,
    cmos_rstn_tri_o,
    hdmi_i2c_scl_io,
    hdmi_i2c_sda_io,
    hdmi_out_clk,
    hdmi_out_data,
    hdmi_out_de,
    hdmi_out_hs,
    hdmi_out_vs,
    led);
  inout [14:0]DDR_0_addr;
  inout [2:0]DDR_0_ba;
  inout DDR_0_cas_n;
  inout DDR_0_ck_n;
  inout DDR_0_ck_p;
  inout DDR_0_cke;
  inout DDR_0_cs_n;
  inout [3:0]DDR_0_dm;
  inout [31:0]DDR_0_dq;
  inout [3:0]DDR_0_dqs_n;
  inout [3:0]DDR_0_dqs_p;
  inout DDR_0_odt;
  inout DDR_0_ras_n;
  inout DDR_0_reset_n;
  inout DDR_0_we_n;
  inout FIXED_IO_0_ddr_vrn;
  inout FIXED_IO_0_ddr_vrp;
  inout [53:0]FIXED_IO_0_mio;
  inout FIXED_IO_0_ps_clk;
  inout FIXED_IO_0_ps_porb;
  inout FIXED_IO_0_ps_srstb;
  input [9:0]cmos1_d;
  input cmos1_href;
  inout cmos1_i2c_scl_io;
  inout cmos1_i2c_sda_io;
  input cmos1_pclk;
  input cmos1_vsync;
  input [9:0]cmos2_d;
  input cmos2_href;
  inout cmos2_i2c_scl_io;
  inout cmos2_i2c_sda_io;
  input cmos2_pclk;
  input cmos2_vsync;
  output [1:0]cmos_rstn_tri_o;
  inout hdmi_i2c_scl_io;
  inout hdmi_i2c_sda_io;
  output hdmi_out_clk;
  output [23:0]hdmi_out_data;
  output hdmi_out_de;
  output hdmi_out_hs;
  output hdmi_out_vs;
  output [3:0]led;

  wire [14:0]DDR_0_addr;
  wire [2:0]DDR_0_ba;
  wire DDR_0_cas_n;
  wire DDR_0_ck_n;
  wire DDR_0_ck_p;
  wire DDR_0_cke;
  wire DDR_0_cs_n;
  wire [3:0]DDR_0_dm;
  wire [31:0]DDR_0_dq;
  wire [3:0]DDR_0_dqs_n;
  wire [3:0]DDR_0_dqs_p;
  wire DDR_0_odt;
  wire DDR_0_ras_n;
  wire DDR_0_reset_n;
  wire DDR_0_we_n;
  wire FIXED_IO_0_ddr_vrn;
  wire FIXED_IO_0_ddr_vrp;
  wire [53:0]FIXED_IO_0_mio;
  wire FIXED_IO_0_ps_clk;
  wire FIXED_IO_0_ps_porb;
  wire FIXED_IO_0_ps_srstb;
  wire [9:0]cmos1_d;
  wire cmos1_href;
  wire cmos1_i2c_scl_i;
  wire cmos1_i2c_scl_io;
  wire cmos1_i2c_scl_o;
  wire cmos1_i2c_scl_t;
  wire cmos1_i2c_sda_i;
  wire cmos1_i2c_sda_io;
  wire cmos1_i2c_sda_o;
  wire cmos1_i2c_sda_t;
  wire cmos1_pclk;
  wire cmos1_vsync;
  wire [9:0]cmos2_d;
  wire cmos2_href;
  wire cmos2_i2c_scl_i;
  wire cmos2_i2c_scl_io;
  wire cmos2_i2c_scl_o;
  wire cmos2_i2c_scl_t;
  wire cmos2_i2c_sda_i;
  wire cmos2_i2c_sda_io;
  wire cmos2_i2c_sda_o;
  wire cmos2_i2c_sda_t;
  wire cmos2_pclk;
  wire cmos2_vsync;
  wire [1:0]cmos_rstn_tri_o;
  wire hdmi_i2c_scl_i;
  wire hdmi_i2c_scl_io;
  wire hdmi_i2c_scl_o;
  wire hdmi_i2c_scl_t;
  wire hdmi_i2c_sda_i;
  wire hdmi_i2c_sda_io;
  wire hdmi_i2c_sda_o;
  wire hdmi_i2c_sda_t;
  wire hdmi_out_clk;
  wire [23:0]hdmi_out_data;
  wire hdmi_out_de;
  wire hdmi_out_hs;
  wire hdmi_out_vs;
  wire [3:0]led;

  IOBUF cmos1_i2c_scl_iobuf
       (.I(cmos1_i2c_scl_o),
        .IO(cmos1_i2c_scl_io),
        .O(cmos1_i2c_scl_i),
        .T(cmos1_i2c_scl_t));
  IOBUF cmos1_i2c_sda_iobuf
       (.I(cmos1_i2c_sda_o),
        .IO(cmos1_i2c_sda_io),
        .O(cmos1_i2c_sda_i),
        .T(cmos1_i2c_sda_t));
  IOBUF cmos2_i2c_scl_iobuf
       (.I(cmos2_i2c_scl_o),
        .IO(cmos2_i2c_scl_io),
        .O(cmos2_i2c_scl_i),
        .T(cmos2_i2c_scl_t));
  IOBUF cmos2_i2c_sda_iobuf
       (.I(cmos2_i2c_sda_o),
        .IO(cmos2_i2c_sda_io),
        .O(cmos2_i2c_sda_i),
        .T(cmos2_i2c_sda_t));
  IOBUF hdmi_i2c_scl_iobuf
       (.I(hdmi_i2c_scl_o),
        .IO(hdmi_i2c_scl_io),
        .O(hdmi_i2c_scl_i),
        .T(hdmi_i2c_scl_t));
  IOBUF hdmi_i2c_sda_iobuf
       (.I(hdmi_i2c_sda_o),
        .IO(hdmi_i2c_sda_io),
        .O(hdmi_i2c_sda_i),
        .T(hdmi_i2c_sda_t));
  mov_obj_det mov_obj_det_i
       (.DDR_0_addr(DDR_0_addr),
        .DDR_0_ba(DDR_0_ba),
        .DDR_0_cas_n(DDR_0_cas_n),
        .DDR_0_ck_n(DDR_0_ck_n),
        .DDR_0_ck_p(DDR_0_ck_p),
        .DDR_0_cke(DDR_0_cke),
        .DDR_0_cs_n(DDR_0_cs_n),
        .DDR_0_dm(DDR_0_dm),
        .DDR_0_dq(DDR_0_dq),
        .DDR_0_dqs_n(DDR_0_dqs_n),
        .DDR_0_dqs_p(DDR_0_dqs_p),
        .DDR_0_odt(DDR_0_odt),
        .DDR_0_ras_n(DDR_0_ras_n),
        .DDR_0_reset_n(DDR_0_reset_n),
        .DDR_0_we_n(DDR_0_we_n),
        .FIXED_IO_0_ddr_vrn(FIXED_IO_0_ddr_vrn),
        .FIXED_IO_0_ddr_vrp(FIXED_IO_0_ddr_vrp),
        .FIXED_IO_0_mio(FIXED_IO_0_mio),
        .FIXED_IO_0_ps_clk(FIXED_IO_0_ps_clk),
        .FIXED_IO_0_ps_porb(FIXED_IO_0_ps_porb),
        .FIXED_IO_0_ps_srstb(FIXED_IO_0_ps_srstb),
        .cmos1_d(cmos1_d),
        .cmos1_href(cmos1_href),
        .cmos1_i2c_scl_i(cmos1_i2c_scl_i),
        .cmos1_i2c_scl_o(cmos1_i2c_scl_o),
        .cmos1_i2c_scl_t(cmos1_i2c_scl_t),
        .cmos1_i2c_sda_i(cmos1_i2c_sda_i),
        .cmos1_i2c_sda_o(cmos1_i2c_sda_o),
        .cmos1_i2c_sda_t(cmos1_i2c_sda_t),
        .cmos1_pclk(cmos1_pclk),
        .cmos1_vsync(cmos1_vsync),
        .cmos2_d(cmos2_d),
        .cmos2_href(cmos2_href),
        .cmos2_i2c_scl_i(cmos2_i2c_scl_i),
        .cmos2_i2c_scl_o(cmos2_i2c_scl_o),
        .cmos2_i2c_scl_t(cmos2_i2c_scl_t),
        .cmos2_i2c_sda_i(cmos2_i2c_sda_i),
        .cmos2_i2c_sda_o(cmos2_i2c_sda_o),
        .cmos2_i2c_sda_t(cmos2_i2c_sda_t),
        .cmos2_pclk(cmos2_pclk),
        .cmos2_vsync(cmos2_vsync),
        .cmos_rstn_tri_o(cmos_rstn_tri_o),
        .hdmi_i2c_scl_i(hdmi_i2c_scl_i),
        .hdmi_i2c_scl_o(hdmi_i2c_scl_o),
        .hdmi_i2c_scl_t(hdmi_i2c_scl_t),
        .hdmi_i2c_sda_i(hdmi_i2c_sda_i),
        .hdmi_i2c_sda_o(hdmi_i2c_sda_o),
        .hdmi_i2c_sda_t(hdmi_i2c_sda_t),
        .hdmi_out_clk(hdmi_out_clk),
        .hdmi_out_data(hdmi_out_data),
        .hdmi_out_de(hdmi_out_de),
        .hdmi_out_hs(hdmi_out_hs),
        .hdmi_out_vs(hdmi_out_vs),
        .led(led));
endmodule
