
`timescale 1ns/1ns
`include "counter10.v"

module test;
    reg rstn;
    reg clk;
    reg D;
    wire [3:0] cnt; //!wire 或 reg 型变量都可以。
    wire cout;
    wire Q1,Q2;

    counter10 u_counter(
        .rstn(rstn),
        .clk(clk),
        .cnt(cnt),
        .cout(cout)
    );

    dff_normal u_dff_normal(
        .rstn(rstn),
        .clk(clk),
        .D(D),
        .Q1(Q1)
    );

    dff_assign u_dff_assign(
        .rstn(rstn),
        .clk(clk),
        .D(D),
        .Q2(Q2)
    );

    initial begin
        clk = 0;
        rstn = 0;
        #10 rstn = 1'b1;
        wait (test.u_counter.cnt_temp == 4'd4);
        @(negedge clk);
        force test.u_counter.cnt_temp = 4'd6;
        force test.u_counter.cout = 1'd1;
        #40;
        @(negedge clk);
        release test.u_counter.cnt_temp;
        release test.u_counter.cout;
        #50 rstn = 1'b0;
        #20 rstn = 1'b1;
    end


    initial begin 
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        D = 1'b1;
        #10 D = 1'b0;
        #20 D = 1'b1;
        #100 D = 1'b0;
        #50 D = 1'b1;
    end
    
    //!finish
    initial begin
        #1000 $finish;
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0,test);
    end
        
    endmodule