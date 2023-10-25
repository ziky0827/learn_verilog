module fast2(
    input       clk1,
    input       rstn ,
    output      sig11);

   reg [3:0]    cnt ;
   always @(posedge clk1 or negedge rstn) begin
      if (!rstn) begin
         cnt <= 'b0 ;
      end
      else begin
         cnt <= cnt + 1'b1 ;
      end
   end

   reg          sig11_r ;
   always @(posedge clk1 or negedge rstn) begin
     if (!rstn) begin
        sig11_r  <= 1'b0 ;
     end
     else if (cnt == 9) begin
        sig11_r  <= 1'b1 ;
     end
     else begin
        sig11_r  <= 1'b0 ;
     end
   end
   assign sig11 = sig11_r;

endmodule


module slow2(
    input       clk1,
    input       sig11,

    input       rstn,
    input       clk2,
    output      sig22);

   reg [1:0]    sig11_r ;
   always @(posedge clk1 or negedge rstn) begin
     if (!rstn) sig11_r  <= 2'b0 ;
     else       sig11_r  <= {sig11_r[0], sig11} ;
   end

   reg          sig22_r ;
   always @(posedge clk2 or negedge rstn) begin
      if (!rstn)        sig22_r  <= 1'b0 ;
      else              sig22_r  <= |sig11_r ;  //检测sig11_r[1]的上升沿
   end
   assign sig22 = sig22_r ;

endmodule

module top_fast2s(
    input       rstn,
    input       clk1,
    input       clk2,
    output      sig22);

   wire         sig11 ;
   fast2 u_fast2(
       .rstn    (rstn),
       .clk1    (clk1),
       .sig11   (sig11));

   slow2 u_slow2(
       .rstn    (rstn),
       .clk1    (clk1),
       .sig11   (sig11),
       .clk2    (clk2),
       .sig22   (sig22));

endmodule
