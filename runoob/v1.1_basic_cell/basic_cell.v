//===========================================


module mux4to1_gate(
    input       A, B, C, D ,
    input       S0, S1,
    output      F );

   //reversing
   wire         S0R, S1R ;
   not  (S0R, S0) ;
   not  (S1R, S1) ;

   //logic and
   wire         AAND, BAND, CAND, DAND ;
   and  (AAND, A, S1R, S0R);
   and  (BAND, B, S1R, S0);
   and  (CAND, C, S1,  S0R);
   and  (DAND, D, S1,  S0);

   //logic or
   or (F, AAND, BAND, CAND, DAND) ;

endmodule


module mux4to1_behavior(
    input       A, B, C, D ,
    input       S0, S1,
    output      F );

   assign F = {S1, S0} == 2'b00 ? A :
              {S1, S0} == 2'b01 ? B :
              {S1, S0} == 2'b10 ? C :
              {S1, S0} == 2'b11 ? D : 0 ;

endmodule




module  mul_input
    (
        input           IN1, IN2, IN3 ,
        output          OUTX, OUTY, OUTZ,
        output          OUTX1, OUTY1, OUTZ1);

   //basic gate instantiation
   and  a1      (OUTX,  IN1, IN2) ;
   nand na1     (OUTX1, IN1, IN2) ;
   or   or1     (OUTY,  IN1, IN2) ;
   nor  nor1    (OUTY1, IN1, IN2) ;

   //3 input
   xor xor1     (OUTZ,  IN1, IN2, IN3) ;
   //no instantiation name
   xnor         (OUTZ1, IN1, IN2) ;

endmodule



module  mul_output
    (
        input           IN1, IN2, IN3 ,
        output          OUTX, OUTY, OUTZ,
        output          OUTX1);

   //buf
   buf buf1     (OUTX, IN1) ;
   //2 output
   buf buf2     (OUTY, OUTY1, IN2) ;
   //no instantiation name
   not          (OUTZ, IN3) ;

endmodule // mul_output



module tristate_gate
    (
        input           IN1,
        input           CTRL1, CTRL2, CTRL3, CTRL4,
        output          OUTX, OUTY, OUTZ,
        output          OUTX1, OUTY1, OUTZ1);

   //tri
   bufif1 buf1     (OUTX, IN1, CTRL1) ;
   bufif0 buf2     (OUTY, IN1, CTRL2) ;
   notif1 buf3     (OUTZ, IN1, CTRL3) ;
   //no instantiation name
   notif0          (OUTX1, IN1, CTRL4) ;

   pullup  p1      (IN1);
   pulldown        (OUTX);

endmodule
