//!全加器设计
module adder(Ai,Bi,Ci,So,Co);
    input Ai,Bi,Ci; //!input;
    output So,Co;   //!output;
    assign So = Ai ^ Bi ^ Ci;
    assign Co = (Ai & Bi) | (Bi & Ci) | (Ai & Ci);
endmodule