module slow1(
    input       clk1,
    input       rstn ,
    output      sig1);

   reg [3:0]    cnt ;
   always @(posedge clk1 or negedge rstn) begin
      if (!rstn) begin
         cnt <= 'b0 ;
      end
      else begin
         cnt <= cnt + 1'b1 ;
      end
   end

   reg          sig1_r ;
   always @(posedge clk1 or negedge rstn) begin
     if (!rstn) begin
        sig1_r  <= 1'b0 ;
     end
     else if (cnt == 9) begin
        sig1_r  <= 1'b1 ;
     end
     else begin
        sig1_r  <= 1'b0 ;
     end
   end
   assign sig1 = sig1_r;

endmodule


module fast1(
    input       clk1,
    input       sig1,

    input       rstn,
    input       clk2,
    output      sig2);

   reg [1:0]    sig2_r ;
   reg pos;
   reg data;
   always @(posedge clk2 or negedge rstn) begin
     if (!rstn) sig2_r  <= 2'b0 ;
     else  begin
         sig2_r  <= {sig2_r[0], sig1} ;
         // data <= sig1;
         // pos <= sig1 && ~data;   //自己写的检测sig1的上升沿
     end     
   end
   assign sig2 = sig2_r[0] && !sig2_r[1]; //检测sig2_r[0]的上升沿，00->01

endmodule

module top_slow2f(
    input       rstn,
    input       clk1,
    input       clk2,
    output      sig2);

   wire         sig1 ;
   slow1 u_slow1(
       .rstn    (rstn),
       .clk1    (clk1),
       .sig1    (sig1));

   fast1 u_fast1(
       .rstn    (rstn),
       .clk1    (clk1),
       .sig1    (sig1),
       .clk2    (clk2),
       .sig2    (sig2));

endmodule
