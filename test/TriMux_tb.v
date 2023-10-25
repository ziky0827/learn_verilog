`timescale 1ns/100ps
	module TriMux_tb;
	reg i0 = 0,i1 = 0,s = 0;
	wire  y;
	TriMux MUT(i0,i1,s,y);
	initial begin
		#15 i1 = 1'b1;
		#15 s = 1'b1;
		#15 s = 1'b0;
		#15 i0 = 1'b1;
		#15 i0 = 1'b0;
		#15 $stop;
	end
endmodule
