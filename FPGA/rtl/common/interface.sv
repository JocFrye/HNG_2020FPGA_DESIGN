// Copyright @2018 Pony AI Inc. All rights reserved.
// Authors: Stephen Lee (stephen@pony.ai)

////////////////////////////////////////////////////////
// Module        : Interface.sv
// Description   : This module writes counting values to
//                 ddr4 after a read transaction is
//                 completed
// -----------------------------------------------------
// Parameter     :
////////////////////////////////////////////////////////


`timescale 1ns / 1ps

interface axi4_stream_if #(
  parameter DATA_BYTE_WIDTH = 4,
  parameter TID_WIDTH       = 4,
  parameter TDEST_WIDTH     = 0,
  parameter TUSER_WIDTH     = 0
)();

  localparam TID_WIDTH_   = (TID_WIDTH   < 1) ? 1 : TID_WIDTH;
  localparam TDEST_WIDTH_ = (TDEST_WIDTH < 1) ? 1 : TDEST_WIDTH;
  localparam TUSER_WIDTH_ = (TUSER_WIDTH < 1) ? 1 : TUSER_WIDTH;

  logic                         tvalid;
  logic                         tready;
  logic [8*DATA_BYTE_WIDTH-1:0] tdata;
  logic [DATA_BYTE_WIDTH-1:0]   tstrb;
  logic                         tlast;
  logic [DATA_BYTE_WIDTH-1:0]   tkeep;
  logic [TID_WIDTH_-1:0]        tid;
  logic [TDEST_WIDTH_-1:0]      tdest;
  logic [TUSER_WIDTH_-1:0]      tuser;

  // AXI4Stream master
  modport master (
    output tvalid,
    input  tready,
    output tdata,
    output tstrb,
    output tkeep,
    output tlast,
    output tid,
    output tdest,
    output tuser
  );

  modport slave (
    input  tvalid,
    output tready,
    input  tdata,
    input  tstrb,
    input  tkeep,
    input  tlast,
    input  tid,
    input  tdest,
    input  tuser
  );

  modport monitor (
    input  tvalid,
    input  tready,
    input  tdata,
    input  tstrb,
    input  tkeep,
    input  tlast,
    input  tid,
    input  tdest,
    input  tuser
  );
endinterface

interface axi4_lite_if #(
  parameter DATA_BYTE_WIDTH = 4,
  parameter ADDR_WIDTH      = 32
)();

  logic    [ADDR_WIDTH-1:0]        awaddr;
  logic    [2:0]                   awprot;
  logic                            awvalid;
  logic                            awready;

  logic    [8*DATA_BYTE_WIDTH-1:0] wdata;
  logic                            wvalid;
  logic                            wready;
  logic    [DATA_BYTE_WIDTH-1:0]   wstrb;

  logic    [1:0]                   bresp;
  logic                            bvalid;
  logic                            bready;

  logic    [ADDR_WIDTH-1:0]        araddr;
  logic    [2:0]                   arprot;
  logic                            arvalid;
  logic                            arready;

  logic    [8*DATA_BYTE_WIDTH-1:0] rdata;
  logic    [1:0]                   rresp;
  logic                            rvalid;
  logic                            rready;

  modport master(
    output awaddr,
    output awvalid,
    output awprot,
    input  awready,

    output wdata,
    output wvalid,
    output wstrb,
    input  wready,

    input  bresp,
    input  bvalid,
    output bready,

    output araddr,
    output arprot,
    output arvalid,
    input  arready,

    input  rdata,
    input  rresp,
    input  rvalid,
    output rready
  );

  modport slave(
    input  awaddr,
    input  awvalid,
    input  awprot,
    output awready,

    input  wdata,
    input  wvalid,
    input  wstrb,
    output wready,

    output bresp,
    output bvalid,
    input  bready,

    input  araddr,
    input  arprot,
    input  arvalid,
    output arready,

    output rdata,
    output rresp,
    output rvalid,
    input  rready
  );

  modport monitor(
    input  awaddr,
    input  awvalid,
    input  awprot,
    input  awready,

    input  wdata,
    input  wvalid,
    input  wstrb,
    input  wready,

    input  bresp,
    input  bvalid,
    input  bready,

    input  araddr,
    input  arprot,
    input  arvalid,
    input  arready,

    input  rdata,
    input  rresp,
    input  rvalid,
    input  rready
  );

endinterface

interface axi4_if #(
  parameter DATA_BYTE_WIDTH = 4,
  parameter ADDR_WIDTH      = 12,
  parameter ID_WIDTH        = 1,
  parameter AWUSER_WIDTH    = 1,
  parameter ARUSER_WIDTH    = 1,
  parameter WUSER_WIDTH     = 1,
  parameter BUSER_WIDTH     = 1,
  parameter RUSER_WIDTH     = 1
  );

  localparam ID_WIDTH_     = (ID_WIDTH     < 1) ? 1 : ID_WIDTH;
  localparam AWUSER_WIDTH_ = (AWUSER_WIDTH < 1) ? 1 : AWUSER_WIDTH;
  localparam ARUSER_WIDTH_ = (ARUSER_WIDTH < 1) ? 1 : ARUSER_WIDTH;
  localparam WUSER_WIDTH_  = (WUSER_WIDTH  < 1) ? 1 : WUSER_WIDTH;
  localparam BUSER_WIDTH_  = (BUSER_WIDTH  < 1) ? 1 : BUSER_WIDTH;
  localparam RUSER_WIDTH_  = (RUSER_WIDTH  < 1) ? 1 : RUSER_WIDTH;

  logic    [ID_WIDTH_-1:0]         awid;
  logic    [ADDR_WIDTH-1:0]        awaddr;
  logic    [7:0]                   awlen;
  logic    [2:0]                   awsize;
  logic    [1:0]                   awburst;
  logic                            awlock;
  logic    [3:0]                   awcache;
  logic    [2:0]                   awprot;
  logic    [3:0]                   awqos;
  logic    [3:0]                   awregion;
  logic    [AWUSER_WIDTH_-1:0]     awuser;
  logic                            awvalid;
  logic                            awready;

  logic    [ID_WIDTH_-1:0]         wid;
  logic    [8*DATA_BYTE_WIDTH-1:0] wdata;
  logic    [DATA_BYTE_WIDTH-1:0]   wstrb;
  logic                            wlast;
  logic    [WUSER_WIDTH_-1:0]      wuser;
  logic                            wvalid;
  logic                            wready;
    
  logic    [ID_WIDTH_-1:0]         bid;
  logic    [1:0]                   bresp;
  logic    [BUSER_WIDTH_-1:0]      buser;
  logic                            bvalid;
  logic                            bready;
    
  logic    [ID_WIDTH_-1:0]         arid;
  logic    [ADDR_WIDTH-1:0]        araddr;
  logic    [7:0]                   arlen;
  logic    [2:0]                   arsize;
  logic    [1:0]                   arburst;
  logic                            arlock;
  logic    [3:0]                   arcache;
  logic    [2:0]                   arprot;
  logic    [3:0]                   arqos;
  logic    [3:0]                   arregion;
  logic    [ARUSER_WIDTH_-1:0]     aruser;
  logic                            arvalid;
  logic                            arready;
    
  logic    [ID_WIDTH_-1:0]         rid;
  logic    [8*DATA_BYTE_WIDTH-1:0] rdata;
  logic    [1:0]                   rresp;
  logic                            rlast;
  logic    [RUSER_WIDTH-1:0]       ruser;
  logic                            rvalid;
  logic                            rready;

  modport master(
    output awid,
    output awaddr,
    output awlen,
    output awsize,
    output awburst,
    output awlock,
    output awcache,
    output awprot,
    output awqos,
    output awregion,
    output awuser,
    output awvalid,
    input  awready,

    output wid,
    output wdata,
    output wstrb,
    output wlast,
    output wuser,
    output wvalid,
    input  wready,

    input  bid,
    input  bresp,
    input  buser,
    input  bvalid,
    output bready,

    output arid,
    output araddr,
    output arlen,
    output arsize,
    output arburst,
    output arlock,
    output arcache,
    output arprot,
    output arqos,
    output arregion,
    output aruser,
    output arvalid,
    input  arready,

    input  rid,
    input  rdata,
    input  rresp,
    input  rlast,
    input  ruser,
    input  rvalid,
    output rready
  );

  modport slave (
    input  awid,
    input  awaddr,
    input  awlen,
    input  awsize,
    input  awburst,
    input  awlock,
    input  awcache,
    input  awprot,
    input  awqos,
    input  awregion,
    input  awuser,
    input  awvalid,
    output awready,

    input  wid,
    input  wdata,
    input  wstrb,
    input  wlast,
    input  wuser,
    input  wvalid,
    output wready,

    output bid,
    output bresp,
    output buser,
    output bvalid,
    input  bready,

    input  arid,
    input  araddr,
    input  arlen,
    input  arsize,
    input  arburst,
    input  arlock,
    input  arcache,
    input  arprot,
    input  arqos,
    input  arregion,
    input  aruser,
    input  arvalid,
    output arready,

    output rid,
    output rdata,
    output rresp,
    output rlast,
    output ruser,
    output rvalid,
    input rready
  );

  modport master_wr (
    output awid,
    output awaddr,
    output awlen,
    output awsize,
    output awburst,
    output awlock,
    output awcache,
    output awprot,
    output awqos,
    output awregion,
    output awuser,
    output awvalid,
    input  awready,

    output wid,
    output wdata,
    output wstrb,
    output wlast,
    output wuser,
    output wvalid,
    input  wready,

    input  bid,
    input  bresp,
    input  buser,
    input  bvalid,
    output bready
  );

  modport slave_wr (
    input  awid,
    input  awaddr,
    input  awlen,
    input  awsize,
    input  awburst,
    input  awlock,
    input  awcache,
    input  awprot,
    input  awqos,
    input  awregion,
    input  awuser,
    input  awvalid,
    output awready,

    input  wid,
    input  wdata,
    input  wstrb,
    input  wlast,
    input  wuser,
    input  wvalid,
    output wready,

    output bid,
    output bresp,
    output buser,
    output bvalid,
    input  bready
  );

  modport master_rd (
    output arid,
    output araddr,
    output arlen,
    output arsize,
    output arburst,
    output arlock,
    output arcache,
    output arprot,
    output arqos,
    output arregion,
    output aruser,
    output arvalid,
    input  arready,

    input  rid,
    input  rdata,
    input  rresp,
    input  rlast,
    input  ruser,
    input  rvalid,
    output rready
  );

  modport slave_rd (
    input  arid,
    input  araddr,
    input  arlen,
    input  arsize,
    input  arburst,
    input  arlock,
    input  arcache,
    input  arprot,
    input  arqos,
    input  arregion,
    input  aruser,
    input  arvalid,
    output arready,

    output rid,
    output rdata,
    output rresp,
    output rlast,
    output ruser,
    output rvalid,
    input rready
  );

  modport monitor (
    input  awid,
    input  awaddr,
    input  awlen,
    input  awsize,
    input  awburst,
    input  awlock,
    input  awcache,
    input  awprot,
    input  awqos,
    input  awregion,
    input  awuser,
    input  awvalid,
    input  awready,

    input  wid,
    input  wdata,
    input  wstrb,
    input  wlast,
    input  wuser,
    input  wvalid,
    input  wready,

    input  bid,
    input  bresp,
    input  buser,
    input  bvalid,
    input  bready,

    input  arid,
    input  araddr,
    input  arlen,
    input  arsize,
    input  arburst,
    input  arlock,
    input  arcache,
    input  arprot,
    input  arqos,
    input  arregion,
    input  aruser,
    input  arvalid,
    input  arready,

    input  rid,
    input  rdata,
    input  rresp,
    input  rlast,
    input  ruser,
    input  rvalid,
    input  rready
  );

endinterface

interface apb3_if #(
  parameter NUM_SLAVE   = 4,
  parameter ADDR_WIDTH  = 32,
  parameter DATA_WIDTH  = 32
)();

  logic    [ADDR_WIDTH-1:0]        paddr;
  logic    [NUM_SLAVE-1 :0]        psel;
  logic                            penable;
  logic                            pwrite;
  logic    [DATA_WIDTH-1:0]        pwdata;
  logic                            pready;
  logic    [DATA_WIDTH-1:0]        prdata;
  logic                            pslverr;

  modport master(
    output paddr,
    output psel,
    output penable,
    output pwrite,
    output pwdata,
    input  pready,
    input  prdata,
    input  pslverr
    );

  modport slave(
    input  paddr,
    input  psel,
    input  penable,
    input  pwrite,
    input  pwdata,
    output pready,
    output prdata,
    output pslverr
    );
endinterface
