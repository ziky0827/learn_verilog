`timescale 1ns/1ns

module test ;
   reg  [3:0]   a ;
   reg  [3:0]   b ;
   //reg          c ;
   wire [3:0]   so ;
   wire         co ;

   initial begin
      a = 4'd5 ;
      b = 4'd2 ;
      #10 ;
      a = 4'd10 ;
      b = 4'd8 ;
   end

   full_adder4  u_adder4(
   //full_adder4  u_adder4_man(
               .a      (a),
               .b      (b),
               .c      (1'b0),
               .so     (so),
               .co     (co));

   initial begin
      forever begin
         #100;
         if ($time >= 1000)  $finish ;
      end
   end

endmodule // test
