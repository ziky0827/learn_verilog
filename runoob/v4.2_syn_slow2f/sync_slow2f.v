/*
module delay_clap(
    input       clk1,
    input       sig1,

    input       rstn,
    input       clk2,
    output      sig2);

   reg [2:0]    sig2_r ;
   always @(posedge clk2 or negedge rstn) begin
     if (!rstn) sig2_r  <= 3'b0 ;
     else       sig2_r  <= {sig2_r[1:0], sig1} ;
   end
   assign sig2 = sig2_r[1] && !sig2_r[2] ;

endmodule
 */

module delay_sample(
    input               rstn,
    input               clk1,
    input [31:0]        din,
    input               din_en,

    input               clk2,
    output [31:0]       dout,
    output              dout_en);

   //sync din_en
   reg [2:0]    din_en_r ;
   always @(posedge clk2 or negedge rstn) begin
     if (!rstn) din_en_r  <= 3'b0 ;
     else       din_en_r  <= {din_en_r[1:0], din_en} ;
   end
   wire din_en_pos = din_en_r[1] && !din_en_r[2] ;

   //sync data
   reg [31:0]           dout_r ;
   reg                  dout_en_r ;
   always @(posedge clk2 or negedge rstn) begin
      if (!rstn)
        dout_r         <= 'b0 ;
      else if (din_en_pos)
        dout_r         <= din ;
   end
   //dout_en delay
   always @(posedge clk2 or negedge rstn) begin
      if (!rstn)        dout_en_r      <= 1'b0 ;
      else              dout_en_r      <= din_en_pos ;
   end
   assign       dout    = dout_r ;
   assign       dout_en = dout_en_r ;

endmodule


module delay_cnt_sample(
    input               rstn,
    input               clk1,
    input [31:0]        din,
    input               din_en,

    input               clk2,
    output [31:0]       dout,
    output              dout_en);

   //sync slow clk
   reg [3:0]    edge_r ;
   always @(posedge clk2 or negedge rstn) begin
     if (!rstn) edge_r  <= 3'b0 ;
     else       edge_r  <= {edge_r[3:0], clk1} ;
   end
   wire edge_pos = edge_r[2] && !edge_r[3] ;

   //delay counter
   reg [5:0] cnt ;
   always @(posedge clk2 or negedge rstn) begin
      if (!rstn)                cnt <= 6'h3f ;
      else if (edge_pos && din_en)
                                cnt <= 6'h0 ;
      else if (cnt != 6'h3f)    cnt <= cnt + 1'b1 ;
   end

   //sync data
   reg [31:0]           dout_r ;
   reg                  dout_en_r ;
   always @(posedge clk2 or negedge rstn) begin
      if (!rstn)
        dout_r         <= 'b0 ;
      else if (din_en && cnt == 47)
        dout_r         <= din ;
   end
   //dout_en delay
   always @(posedge clk2 or negedge rstn) begin
      if (!rstn)        dout_en_r      <= 1'b0 ;
      else if (din_en && cnt==48)
                        dout_en_r      <= 1'b1 ;
      else              dout_en_r      <= 1'b0 ;
   end
   assign       dout    = dout_r ;
   assign       dout_en = dout_en_r ;

endmodule // delay_cnt_sample
