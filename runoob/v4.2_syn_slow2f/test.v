`timescale 1ns/1ps

module test ;
   reg          clk_100mhz, clk_20mhz, clk_999khz ;
   reg          rstn ;

   initial begin
      clk_100mhz = 0 ;
      clk_20mhz  = 0 ;
      clk_999khz = 0;
      rstn = 0 ;
      #11 rstn = 1 ;
   end
   always #(10/2)   clk_100mhz  = ~clk_100mhz ;
   always #(50/2)   clk_20mhz   = ~clk_20mhz ;
   always #(1001/2) clk_999khz  = ~clk_999khz ;

   //====================================================================
   //delay clap sample
   reg [31:0]           din1 ;
   reg                  din1_en ;
   always @(posedge clk_20mhz or negedge rstn) begin
      if (!rstn) begin
         din1           <= 32'h5555aaaa ;
         din1_en        <= 1'b0 ;
      end
      else begin
         din1           <= din1 + 32'h4321 ;
         din1_en        <= ~din1_en ;
      end
   end

   delay_sample u_delay_sample(
       .rstn            (rstn),
       .clk1            (clk_20mhz),
       .din             (din1),
       .din_en          (din1_en),
       .clk2            (clk_100mhz),
       .dout            (),
       .dout_en         ());

   //====================================================================
   //delay cnt sample
   reg [31:0]           din2 ;
   reg                  din2_en ;
   always @(posedge clk_999khz or negedge rstn) begin
      if (!rstn) begin
         din2           <= 32'h5555aaaa ;
         din2_en        <= 1'b0 ;
      end
      else begin
         din2           <= din2 + 32'h4321 ;
         din2_en        <= 1'b1 ;
      end
   end

   delay_cnt_sample u_delay_cnt_sample(
       .rstn            (rstn),
       .clk1            (clk_999khz),
       .din             (din2),
       .din_en          (din2_en),
       .clk2            (clk_100mhz),
       .dout            (),
       .dout_en         ());

   initial begin
      forever begin
         #100;
         if ($time >= 10000)  $finish ;
      end
   end

   initial begin
      $dumpfile("wave.vcd");
      $dumpvars();
   end
endmodule // test
