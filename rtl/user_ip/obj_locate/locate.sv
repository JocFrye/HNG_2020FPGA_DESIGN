module locate(
  input  wire         clk
 ,input  wire         rst
 
 ,input  wire  [31:0] c0_axis_tdata
 ,input  wire         c0_axis_tvalid
 ,output wire         c0_axis_tready
 
 ,input  wire  [31:0] c1_axis_tdata
 ,input  wire         c1_axis_tvalid
 ,output wire         c1_axis_tready
 
 //****************************************
 ,(* dont_touch = "yes" *) input  logic [31:0] axil_s_awaddr
 ,(* dont_touch = "yes" *) input  logic [2:0]  axil_s_awprot
 ,(* dont_touch = "yes" *) input  logic        axil_s_awvalid
 ,(* dont_touch = "yes" *) output logic        axil_s_awready
						   
 ,(* dont_touch = "yes" *) input  logic [31:0] axil_s_wdata
 ,(* dont_touch = "yes" *) input  logic        axil_s_wvalid
 ,(* dont_touch = "yes" *) input  logic [3:0]  axil_s_wstrb
 ,(* dont_touch = "yes" *) output logic        axil_s_wready
						   
 ,(* dont_touch = "yes" *) output logic [1:0]  axil_s_bresp
 ,(* dont_touch = "yes" *) output logic        axil_s_bvalid
 ,(* dont_touch = "yes" *) input  logic        axil_s_bready
						   
 ,(* dont_touch = "yes" *) input  logic [31:0] axil_s_araddr
 ,(* dont_touch = "yes" *) input  logic [2:0]  axil_s_arprot
 ,(* dont_touch = "yes" *) input  logic        axil_s_arvalid
 ,(* dont_touch = "yes" *) output logic        axil_s_arready
						   
 ,(* dont_touch = "yes" *) output logic [31:0] axil_s_rdata
 ,(* dont_touch = "yes" *) output logic [1:0]  axil_s_rresp
 ,(* dont_touch = "yes" *) output logic        axil_s_rvalid
 ,(* dont_touch = "yes" *) input  logic        axil_s_rready
 
 
);
  
  localparam C0_LOC   = 'h000;
  localparam C1_LOC   = 'h004;
  
  localparam LED_TRIG = 'h008;
  
  reg  [31:0]  c0_loc;
  reg  [31:0]  c1_loc;

  
  wire arhandshake;
  wire rhandshake;
  assign arhandshake = axil_s_arready && axil_s_arvalid;
  assign rhandshake  = axil_s_rready  && axil_s_rvalid;

  reg read_state_cur;
  reg read_state_next;
  localparam AR_STATE = 1'b0, R_STATE = 1'b1;
  
  always @ (posedge clk) begin
    if (rst)
      read_state_cur <= AR_STATE;
    else
      read_state_cur <= read_state_next;
  end
  
  always @ (*) begin
    case(read_state_cur)
      AR_STATE: begin
        if (arhandshake)
          read_state_next = R_STATE;
        else
          read_state_next = AR_STATE;
      end
      R_STATE: begin
        if (rhandshake)
          read_state_next = AR_STATE;
        else
          read_state_next = R_STATE;
      end
      default: begin
        read_state_next = AR_STATE;
      end
    endcase;
  end
  
  reg [31 : 0] ar_data;
  
  always @ (posedge clk) begin
    if (rst) begin
      ar_data   <= 0;    
    end
    else begin
      if (arhandshake) begin
        case(axil_s_araddr[11:0])
          C0_LOC:
            ar_data <= c0_loc;
          C1_LOC:
            ar_data <= c1_loc;		
          default:
            ar_data <= 32'h0;
        endcase
      end   
    end
  end
  
  assign axil_s_arready = (read_state_cur == AR_STATE);
  assign axil_s_rdata   = ar_data;
  assign axil_s_rresp   = 2'b00;
  assign axil_s_rvalid  = (read_state_cur == R_STATE);
  
  
  wire awhandshake;
  wire whandshake;
  wire bhandshake;

  assign awhandshake = (axil_s_awvalid && axil_s_awready);
  assign whandshake  = (axil_s_wvalid && axil_s_wready);
  assign bhandshake  = (axil_s_bvalid && axil_s_bready);


  reg [1 : 0] write_state_cur;
  reg [1 : 0] write_state_next;

  localparam AW_STATE = 2'd0, W_STATE = 2'd1,
             B_STATE  = 2'd2;

  always @ (*) begin
    case(write_state_cur)
      AW_STATE: begin
        if (awhandshake)
          write_state_next = W_STATE;
        else
          write_state_next = AW_STATE;
      end
      W_STATE: begin
        if (whandshake)
          write_state_next = B_STATE;
        else
          write_state_next = W_STATE;
      end
      B_STATE: begin
        if (bhandshake)
          write_state_next = AW_STATE;
        else
          write_state_next = B_STATE;
      end
      default: begin
        write_state_next   = AW_STATE;
      end
    endcase
  end


  always @ (posedge clk) begin
    if (rst)
      write_state_cur <= AW_STATE;
    else
      write_state_cur <= write_state_next;
  end

  reg [31 : 0] aw_addr;
  always @ (posedge clk) begin : P_WADDR_LOAD_N_INC
    if (rst) begin
      aw_addr <= 0;
    end
    else begin
      case(write_state_cur)
        AW_STATE: begin
          if (awhandshake)
            aw_addr <= axil_s_awaddr[31 : 0];
        end
      endcase
    end
  end
  
  reg [31:0] led_trig_thre;
  
  
  always @ (posedge clk) begin 
    if (rst) begin    
      led_trig_thre  <= 'd0;
    end
    else begin
      if (whandshake) begin
        case(aw_addr[31 : 0])
          LED_TRIG:
            led_trig_thre <= axil_s_wdata;
        endcase
      end
    end
  end
  
  assign axil_s_awready = (write_state_cur == AW_STATE);
  assign axil_s_wready  = (write_state_cur == W_STATE);
  assign axil_s_bvalid  = (write_state_cur == B_STATE);
  assign axil_s_bresp   = 2'b00;
  

  assign c0_axis_tready = 1'b1;
  assign c1_axis_tready = 1'b1;
  
  always @ (posedge clk) begin
    
      if (c0_axis_tvalid) begin
        c0_loc <= c0_axis_tdata;
      end   
    
  end
  
  always @ (posedge clk) begin
    
      if (c1_axis_tvalid) begin
        c1_loc <= c1_axis_tdata;
      end   
    
  end
  


endmodule

