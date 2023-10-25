//input-data has 2bit width
//output-data has 8bit width

module  data_consolidation
    (
        input           clk ,
        input           rstn ,
        input [1:0]     din ,           //data in
        input           din_en ,
        output [7:0]    dout ,
        output          dout_en        //data out
     );

   // data shift and counter
   reg [7:0]            data_r ;
   reg [1:0]            state_cnt ;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         state_cnt      <= 'b0 ;
         data_r         <= 'b0 ;
      end
      else if (din_en) begin
         state_cnt <= state_cnt + 1'b1 ;
         data_r         <= {data_r[5:0], din} ;
      end
      else begin
         state_cnt <= 'b0 ;
      end
   end
   assign dout          = data_r ;

   // data output en
   reg                  dout_en_r ;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         dout_en_r       <= 'b0 ;
      end
      else if (din_en & state_cnt == 2'd3) begin
         dout_en_r       <= 1'b1 ;
      end
      else begin
         dout_en_r       <= 1'b0 ;
      end
   end
   assign dout_en       = dout_en_r;


endmodule
