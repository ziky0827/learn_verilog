`timescale 1ns/1ns

module loop ;

   //(1) while-loop sentense
   reg [3:0]    counter ;
   initial begin
      counter = 'b0 ;
      while (counter<=10) begin
         #10 ;
         counter = counter + 1'b1 ;
      end

   end

   //(2) for-loop sentense
   integer      i ;
   reg [3:0]    counter2 ;
   initial begin
      counter2 = 'b0 ;
      for (i=0; i<=10; i=i+1) begin
         #10 ;
         counter2 = counter2 + 1'b1 ;
      end
   end

   //(3) repeat-loop sentense
   reg [3:0]    counter3 ;
   initial begin
      counter3 = 'b0 ;
      repeat (11) begin
         #10 ;
         counter3 = counter3 + 1'b1 ;
      end
   end

   //(3)
   reg          clk ;
   reg          rstn ;
   reg          enable ;
   reg [3:0]    buffer [7:0] ;
   integer      j ;

   initial begin
      clk       = 0 ;
      rstn      = 1 ;
      enable    = 0 ;
      #3;
      rstn      = 0 ;
      #3;
      rstn      = 1 ;
      enable    = 1 ;
      forever begin
         clk = ~clk ;
         #5 ;
      end
   end

   always @(posedge clk or negedge rstn) begin
      j = 0  ;
      if (!rstn) begin
         repeat (8) begin
            buffer[j]   <= 'b0 ;
            j = j + 1 ;
         end
      end
      else if (enable) begin
         repeat (8) begin
            @(posedge clk) buffer[j]    <= counter3 ;
            j = j + 1 ;
         end
      end
   end



   //stop the simulation
   always begin
      #10 ;
      if ($time >= 1000) $finish ;
   end
   initial begin
    $dumpfile("loop.vcd");
    $dumpvars(0,loop);
   end

endmodule
