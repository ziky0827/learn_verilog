/*
 * @Author       : ziky
 * @Date         : 2023-10-26 19:38:17
 * @Version      : V1.0.0
 * @LastEditTime : 2024-08-09 21:13:20
 * @LastEditors  : ziky
 * @FilePath     : \verilog_prj\books\xiayuwen\mux2to1_tb.v
 * @Description  : 输出打印测试strobe,mointor,display
 */
`timescale 1ns/1ps
`include "mux2to1.v"

module mux2_tb;

    // Parameters

    //Ports
    reg  a;
    reg  b;
    reg  sel;
    wire  out;

    initial begin
        a = 0;
        b = 0;
        sel = 0;
    end

    initial
    begin
        #5 a = 1;
        #5 b = 0;
        #5 sel = 1;
        #5 sel = 0;
        #5 a = 0;
        #5 a = 1;
        #5 b = 1;
        #5 sel = 1;
        #5 $finish;
        
    end
    initial 
    begin
        #5
        $strobe("$strobe excuting result: %t", $time);
        $monitor($time,,,"part:%b %b %b %b",a,b,sel,out);
        $display("$display excuting result: %t",$time);
        
        
    end

    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0);    //tb模块名称
    end
    mux2to1  mux2to1_inst (
                .a(a),
                .b(b),
                .sel(sel),
                .out(out)
            );

    //always #5  clk = ! clk ;

endmodule
