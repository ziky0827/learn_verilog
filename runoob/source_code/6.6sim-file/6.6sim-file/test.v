`timescale 1ns/1ps

   //============== (1) ==================
   //signals declaration
module test ;

   reg          clk;
   reg          rstn ;
   reg [1:0]    din ;
   reg          din_en ;
   wire [7:0]   dout ;
   wire         dout_en ;

   //============== (2) ==================
   //clock generating
   real         CYCLE_200MHz = 5 ; //
   always begin
      clk = 0 ; #(CYCLE_200MHz/2) ;
      clk = 1 ; #(CYCLE_200MHz/2) ;
   end

   //============== (3) ==================
   //reset generating
   initial begin
      rstn      = 1'b0 ;
      #8 rstn      = 1'b1 ;
   end

   //============== (4) ==================
   //motivation
   /*
   reg [1:0]    data_mem [39:0] ;
   reg [7:0]    data_in_temp ;  //for self check
   integer      k1 ;
   initial begin
      din_en    = 1'b0 ;
      din       = 'b0 ;
      $readmemh("../tb/data_in.dat", data_mem);
      wait (rstn) ;
      # CYCLE_200MHz ;

      //read data from file
      for(k1=0; k1<40; k1=k1+1)  begin
         @(negedge clk) ;
         din    = data_mem[k1] ;
         data_in_temp = {data_in_temp[5:0], din} ;
         din_en = 1'b1 ;
      end

      //stop data
      @(posedge clk) ;
      #2 din_en = 1'b0 ;
   end
   */

   //============== (4) ==================
   //motivation
   int          fd_rd ;
   reg [7:0]    data_in_temp ;  //for self check
   reg [15:0]   read_temp ;     //8bit ascii data, 8bit \n
   initial begin
      din_en    = 1'b0 ;
      din       = 'b0 ;
      open_file("../tb/data_in.dat", "r", fd_rd);
      wait (rstn) ;
      # CYCLE_200MHz ;

      //read data from file
      while (! $feof(fd_rd) ) begin
         @(negedge clk) ;
         $fread(read_temp, fd_rd);
         din    = read_temp[9:8] ;
         //ret_rd = $fread(din, fd_rd);
         data_in_temp = {data_in_temp[5:0], din} ;
         din_en = 1'b1 ;
      end

      //stop data
      @(posedge clk) ;
      #2 din_en = 1'b0 ;
   end


   //open task
   task open_file;
      input string      file_dir_name ;
      input string      rw ;
      output int        fd ;

      fd = $fopen(file_dir_name, rw);
      if (! fd) begin
         $display("--- iii --- Failed to open file: %s", file_dir_name);
      end
      else begin
         $display("--- iii --- %s has been opened successfully.", file_dir_name);
      end
   endtask

   //============== (5) ==================
   //module instantiation
   data_consolidation    u_data_process
     (
      .clk              (clk),
      .rstn             (rstn),
      .din              (din),
      .din_en           (din_en),
      .dout             (dout),
      .dout_en          (dout_en)
      );

   //============== (6) ==================
   //auto check
   reg  [7:0]           err_cnt ;
   int                  fd_wr ;

   initial begin
      err_cnt   = 'b0 ;
      open_file("../tb/data_out.dat", "w", fd_wr);
      forever begin
         @(negedge clk) ;
         if (dout_en) begin
            $fdisplay(fd_wr, "%h", dout);
         end
      end
   end

   always @(posedge clk) begin
      #1 ;
      if (dout_en) begin
         if (data_in_temp != dout) begin
            err_cnt = err_cnt + 1'b1 ;
         end
      end
   end

   //============== (7) ==================
   //simulation finish
   always begin
      #100;
      if ($time >= 10000)  begin
         if (!err_cnt) begin
            $display("-----------------------------------------");
            $display("Data process is OK!!!");
            $display("-----------------------------------------");
         end
         else begin
            $display("-----------------------------------------");
            $display("Error occurs in data process!!!");
            $display("-----------------------------------------");
         end
         #1 ;
         $finish ;
      end
   end

endmodule // test
