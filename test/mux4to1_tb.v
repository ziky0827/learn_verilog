`timescale 1ns/1ps
`include "mux4to1.v"
module mux4to1_tb ();
    reg w0,w1,w2,w3;
    reg [1:0]sel;
    wire out;
    initial begin
        w0 = 0;w1 = 0;w2 = 0;w3 = 0;sel = 0;
        #10 sel = 2'b01;w3 = 1'b1;
        #10 sel = 2'b11;w2 = 1'b1;
        #10 sel = 2'b10;w1 = 1'b1;
        #10 sel = 2'b01;w1 = 1'b1;
        #10 sel = 2'b00;w3 = 0;w2 = 0;
        #10 sel = 2'b10;
        #10 sel = 2'b01;
        #10 sel = 2'b11;
        #20 $display("the code is running!");
        #100 $stop;

    end
	mux4to1 s(w0,w1,w2,w3,sel,out);
endmodule