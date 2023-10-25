`timescale 1 ns/100 ps
module counter_tb (); 
	reg Clk=0,Reset=0;
	wire [3:0]Count; 
	initial 
		begin
			Reset=0;
			#5 Reset =1;
			#115 Reset=0; 
			#760 $stop;
		end
	always #26.5 Clk=~Clk;
	Counter U1(Clk,Reset,Count);
endmodule