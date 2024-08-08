/*
 * @Author       : ziky
 * @Date         : 2024-08-08 22:30:03
 * @Version      : V1.0.0
 * @LastEditTime : 2024-08-08 22:39:48
 * @LastEditors  : ziky
 * @FilePath     : \verilog_prj\test\my_design_tb.v
 * @Description  : ЬѕМўБрвы
 */
`timescale 1ns/1ps

#include "my_design.v"
module tb;
    reg clk, d, rstn;
    wire q;
    reg [3:0] delay;

    my_design u0 ( .clk(clk), .d(d),
`ifdef INCLUDE_RSTN
                    .rstn(rstn),
`endif
                    .q(q)
                );

    always #10 clk = ~clk;

    initial begin
        integer i;

        {d, rstn, clk} <= 0;

        #20 rstn <= 1;
        for (i = 0 ; i < 20; i=i+1) begin
            delay = $random;
            #(delay) d <= $random;
        end

        #20 $finish;
    end
endmodule