//!状态机,自动售卖机的功能描述如下：
//!饮料单价 2 元，该售卖机只能接受 0.5 元、1 元的硬币。
//!考虑找零和出货。投币和出货过程都是一次一次的进行，不会出现一次性投入多币或一次性出货多瓶饮料的现象。
//!每一轮售卖机接受投币、出货、找零完成后，才能进入到新的自动售卖状态。

//`include "vending_machine_3.v"
`timescale 1ns/1ps
module test;

    //!Ports
    reg clk = 0;
    reg rstn = 0;
    reg [1:0] coin;
    wire [1:0] change;
    wire sell;

    //!clock generating
    parameter    CYCLE_200MHz = 10 ; //5ns rolling period
    always
    begin
        clk = 0 ;
        #(CYCLE_200MHz/2) ;
        clk = 1 ;
        #(CYCLE_200MHz/2) ;
    end

    //!motivation generating
    reg [9:0] buy_oper; //!store state of the buy operation
    initial
    begin
        buy_oper = 10'b0;
        coin = 2'b0;
        rstn = 1'b0;
        #8 rstn = 1'b1;
        @(negedge clk);     //!wait for the negedge clk

        //!case(1) 0.5 -> 0.5 -> 0.5 -> 0.5
        #16 buy_oper = 10'b00_0101_0101;
        repeat(5)
        begin
            @(negedge clk);
            coin = buy_oper[1:0];
            buy_oper = buy_oper >> 2;   //!shift 2 bits to the right
        end

        //!case(2) 1 -> 0.5 -> 1, taking change
        #16 buy_oper = 10'b00_0010_0110;
        repeat(5)
        begin
            @(negedge clk);
            coin = buy_oper[1:0];
            buy_oper = buy_oper >> 2;
        end

        //!case(3) 0.5 -> 1 -> 0.5
        #16 buy_oper = 10'b00_0001_1001;
        repeat(5)
        begin
            @(negedge clk);
            coin = buy_oper[1:0];
            buy_oper = buy_oper >> 2;
        end

        //!case(4) 0.5 -> 0.5 -> 0.5 -> 1, taking change
        #16 buy_oper = 10'b00_1001_0101;
        repeat(5)
        begin
            @(negedge clk);
            coin = buy_oper[1:0];
            buy_oper = buy_oper >> 2;
        end
    end

    vending_machine_3 u1(
                          .clk(clk),
                          .rstn(rstn),
                          .coin(coin),
                          .change(change),
                          .sell(sell)
                      );


    always
    begin
        #100;
        if ($time >= 10000)
            $finish;
    end

    initial
    begin
        $fsdbDumpfile("tb.fsdb");//这个是产生名为tb.fsdb的文件
        $fsdbDumpvars;
    end

endmodule
