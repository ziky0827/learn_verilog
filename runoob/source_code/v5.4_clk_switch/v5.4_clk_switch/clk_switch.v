module clk_switch(
    input               rstn ,
    input               clk1,
    input               clk2,
    input               sel_clk1 , // 1 clk1, 0 clk2
    output              clk_out
    );

   reg [2:0]            sel_clk1_r ;
   reg [1:0]            sel_clk1_neg_r ;
   reg [2:0]            sel_clk2_r ;
   reg [1:0]            sel_clk2_neg_r ;

   //sync sel clk1 signal from different clk domain, use 3 clap
   always @(posedge clk1 or negedge rstn) begin
      if (!rstn) begin
         sel_clk1_r     <= 3'b111 ;
      end
      else begin
         //sel clk1, and not sel clk2
         sel_clk1_r     <= {sel_clk1_r[1:0], sel_clk1 & (!sel_clk2_neg_r[1])} ;
      end
   end

   //at negedge capture sel clk1 signal, use 2 clap
   always @(negedge clk1 or negedge rstn) begin
      if (!rstn) begin
         sel_clk1_neg_r <= 2'b11 ;
      end
      else begin
         sel_clk1_neg_r <= {sel_clk1_neg_r[0], sel_clk1_r[2]} ;
      end
   end

   //sync sel clk2 signal from different clk domain, use 3 clap
   always @(posedge clk2 or negedge rstn) begin
      if (!rstn) begin
         sel_clk2_r     <= 3'b0 ;
      end
      else begin
         //sel clk2, and not sel clk1
         sel_clk2_r     <= {sel_clk2_r[1:0], !sel_clk1 & (!sel_clk1_neg_r[1])} ;
      end
   end

   //at negedge capture sel clk1 signal, use 2 clap
   always @(negedge clk2 or negedge rstn) begin
      if (!rstn) begin
         sel_clk2_neg_r <= 2'b0 ;
      end
      else begin
         sel_clk2_neg_r <= {sel_clk2_neg_r[0], sel_clk2_r[2]} ;
      end
   end

   //output clk
   wire clk1_gate, clk2_gate ;
   and (clk1_gate, clk1, sel_clk1_neg_r[1]) ;
   and (clk2_gate, clk2, sel_clk2_neg_r[1]) ;
   or  (clk_out, clk1_gate, clk2_gate) ;

endmodule
