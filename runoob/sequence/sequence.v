//!命名块，并使用disable语句禁用块
`timescale 1ns/1ns

module sequence;
    reg [3:0] ai_sequen,bi_sequen;
    reg [3:0] ai_paral,bi_paral;
    reg [3:0] ai_nonblk,bi_nonblk;


    //==============================(a)=========================================//
    //sequence and fork block
    //(1)Sequence block
    initial
      begin
        #5 ai_sequen         = 4'd5 ;    //at 5ns
        #5 bi_sequen         = 4'd8 ;    //at 10ns
      end
    //(2)fork block
    initial
      fork
        #5 ai_paral          = 4'd5 ;    //at 5ns
        #5 bi_paral          = 4'd8 ;    //at 5ns
      join
      //(3)non-block block
      initial
        fork
          #5 ai_nonblk         <= 4'd5 ;    //at 5ns
          #5 bi_nonblk         <= 4'd8 ;    //at 5ns
        join

    //================================(b)=======================================//
    // nesting
    reg [3:0]   ai_sequen2, bi_sequen2 ;
    reg [3:0]   ai_paral2,  bi_paral2 ;
    initial
      begin
        ai_sequen2         = 4'd5 ;    //at 0ns
        fork
          #10 ai_paral2          = 4'd5 ;    //at 10ns
          #15 bi_paral2          = 4'd8 ;    //at 15ns
        join
        #20 bi_sequen2      = 4'd8 ;    //at 35ns
      end

    //================================(c)=======================================//
    //named-block
    initial
      begin: runoob //block are named as runoob
        integer    i ;
        i = 0 ;
        forever begin
          #10 i = i + 10 ;       //variable i can be refered by the format: test.runoob.i
        end
      end

    reg stop_flag ;
    initial stop_flag = 1'b0 ;
    always begin : detect_stop
      if (sequence.runoob.i == 100) begin
            $display("Now you can stop the simulation!!!");
            stop_flag = 1'b1 ;
          end
          #10 ;
          end

    //================================(d)=======================================//
    //disable named-block
    initial begin: runoob_d //block are named as runoob
      integer    i_d ;
      i_d = 0 ;
      while(i_d<=100) begin: runoob_d2
        # 10 ;
        if (i_d >= 50) begin       //stop forever block when acculating 5 times
          disable runoob_d3.clk_gen ; //stop exterl named-block
          disable runoob_d2 ;         //stop current named-block
        end
        i_d = i_d + 10 ;
      end
    end

    reg clk ;
    initial begin: runoob_d3
      while (1) begin: clk_gen  //clock generating block
        clk=1 ;      #10 ;
        clk=0 ;      #10 ;
      end
    end

    //stop
    always begin
      #10;
      if ($time >= 150) begin
        $finish ;
      end
    end

    initial
    begin
      $dumpfile("wave.vcd");
      $dumpvars(0,sequence);
    end


endmodule


/*
由图可知，信号 i_d 累加到 50 以后，便不再累加，以后 clk 时钟也不再产生。

可见，disable 退出了当前的 while 块。
*/