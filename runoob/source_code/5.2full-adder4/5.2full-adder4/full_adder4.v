module full_adder4(
    input [3:0]   a ,   //adder1
    input [3:0]   b ,   //adder2
    input         c ,   //input carry bit

    output [3:0]  so ,  //adding result
    output        co    //output carry bit
    );

   wire [3:0]    co_temp ;

   full_adder1  u_adder0(
        .Ai     (a[0]),
        .Bi     (b[0]),
        .Ci     (c==1'b1 ? 1'b1 : 1'b0),
        .So     (so[0]),
        .Co     (co_temp[0]));

   genvar        i ;
   generate
      for(i=1; i<=3; i=i+1) begin: adder_gen
         full_adder1  u_adder(
             .Ai     (a[i]),
             .Bi     (b[i]),
             .Ci     (co_temp[i-1]),
             .So     (so[i]),
             .Co     (co_temp[i]));
      end
   endgenerate

   assign co    = co_temp[3] ;

endmodule




module full_adder4_man(
    input [3:0]   a ,   //adder1
    input [3:0]   b ,   //adder2
    input         c ,   //input carry bit

    output [3:0]  so ,  //adding result
    output        co    //output carry bit
    );

   wire [3:0]    co_temp ;
   wire          so_bit0 ;
   wire          so_bit1 ;
   wire          so_bit2 ;
   wire          so_bit3 ;

   full_adder1  u_adder0(
        .Ai     (a[0]),
        .Bi     (b[0]),
        .Ci     (c==1'b1 ? 1'b1 : 1'b0),
        .So     (so_bit0),
        .Co     (co_temp[0]));

   full_adder1  u_adder1(
        a[1], b[1], co_temp[0], so_bit1, co_temp[1]);


   full_adder1  u_adder2(
        .Ai     (a[2]),
        .Bi     (b[2]),
        .Ci     (co_temp[1]),
        .So     (so_bit2),
        .Co     (co_temp[2]));


   full_adder1  u_adder3(
        .Ai     (a[3]),
        .Bi     (b[3]),
        .Ci     (co_temp[2]),
        .So     (so_bit3),
        .Co     (co_temp[3]));

   assign so    = {so_bit3, so_bit2, so_bit1, so_bit0};
   assign co    = co_temp[3] ;

endmodule
