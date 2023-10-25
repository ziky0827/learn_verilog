`timescale 1ns/1ps

   //signals declaration
module test ;


   reg rstn ;
   //reset generating
   initial begin
      rstn      = 1'b0 ;
      #8 rstn      = 1'b1 ;
   end

   mul_input    u_mul_input();
   mul_output    u_mul_output();
   tristate_gate u_tri();

   mux4to1_gate u_mux4_gate();
   mux4to1_behavior u_mux4_behavior();

   //simulation finish
   always begin
      #100;
      if ($time >= 1000)  begin
         #1 ;
         $finish ;
      end
   end
   initial begin
      $dumpfile("wave.vcd");
      $dumpvars(0, test);
   end

endmodule // test
