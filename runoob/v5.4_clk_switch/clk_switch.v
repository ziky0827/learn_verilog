/*
sel_clk1_r: 这是一个三位的寄存器，用于缓存时钟选择信号sel_clk1。它在clk1的上升沿更新，每次将sel_clk1_r的低两位左移一位，
然后将sel_clk1和sel_clk2_neg_r[1]的"与"结果赋值给sel_clk1_r的最高位。
这样做的目的是为了同步另一个时钟控制信号sel_clk2_neg_r[1]和本时钟控制信号sel_clk1，避免时钟切换时出现冲突或抖动。
sel_clk1_neg_r: 这是一个两位的寄存器，用于缓存时钟选择信号sel_clk1_r[2]。
它在clk1的下降沿更新，每次将sel_clk1_neg_r的低一位左移一位，然后将sel_clk1_r[2]赋值给sel_clk1_neg_r的最高位。
这样做的目的是为了延迟一个半周期，使得在clk_out上出现时钟切换时，能够保证clk_out的上升沿和下降沿都是完整的。
*/
/*
sel_clk2_r: 这是一个三位的寄存器，用于缓存时钟选择信号!sel_clk1。它在clk2的上升沿更新，每次将sel_clk2_r的低两位左移一位，
然后将!sel_clk1和!sel_clk1_neg_r[1]的"与"结果赋值给sel_clk2_r的最高位。
这样做的目的是为了同步另一个时钟控制信号!sel_clk1_neg_r[1]和本时钟控制信号!sel_clk1，避免时钟切换时出现冲突或抖动。
sel_clk2_neg_r: 这是一个两位的寄存器，用于缓存时钟选择信号sel_clk2_r[2]。它在clk2的下降沿更新，每次将sel_clk2_neg_r的低一位左移一位，
然后将sel_clk2_r[2]赋值给sel_clk2_neg_r的最高位。这样做的目的是为了延迟一个半周期，使得在clk_out上出现时钟切换时，能够保证clk_out的上升沿和下降沿都是完整的
*/
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
