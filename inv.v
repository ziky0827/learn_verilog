// module inv (input [3:0] a,
//             output [3:0] y);
//     assign y = ~a;

// endmodule
module mux2 (
    input [3:0] a,b,
    input       sel,
    output      y
);
    assign y = sel ? a : b;
    
endmodule