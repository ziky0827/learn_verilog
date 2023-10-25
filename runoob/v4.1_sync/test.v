`timescale 1ns/1ns

module test ;
   reg          clk_fast, clk_slow ;
   reg          rstn ;

   initial begin
      clk_fast = 0 ;
      clk_slow = 0 ;
      rstn = 0 ;
      #11 rstn = 1 ;
   end
   always #10   clk_fast = ~clk_fast ;
   always @(posedge clk_fast)
     clk_slow = ~clk_slow ;

   top_slow2f u_top_slow2f(
       .rstn    (rstn),
       .clk1    (clk_slow),
       .clk2    (clk_fast),
       .sig2    ());

   top_fast2s u_top_fast2s(
       .rstn    (rstn),
       .clk1    (clk_fast),
       .clk2    (clk_slow),
       .sig22   ());

   initial begin
      forever begin
         #100;
         if ($time >= 1000)  $finish ;
      end
   end

   initial begin
      $dumpfile("wave.vcd");
      $dumpvars();
   end
endmodule // test
