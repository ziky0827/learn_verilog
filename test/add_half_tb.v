`timescale 1ns/10ps
module add_half_tb();
	wire sum,c_out;
	reg a,b;
	add_half M1(sum,c_out,a,b);
	initial begin
		#100 $finish;
	end
	initial begin
		#10 a = 0;b = 0;
		#10 b = 1;
		#10 a = 1;
		#10 b = 0;
	end
endmodule