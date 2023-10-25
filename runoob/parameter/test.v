`timescale 1ns/1ns
`include "ram.v"

module test;

    parameter AW = 4;
    parameter DW = 4;

    reg clk;
    reg [AW:0] a;
    reg [DW-1:0] d;
    reg en;
    reg wr;
    wire [DW-1:0] q;

    //!clock generating
    always begin
        #15 clk = 0;
        #15 clk = 1;
    end

    initial begin
        a = 10;
        d = 2;
        en = 1'b0;
        wr = 1'b0;
        repeat(10) begin
            @(negedge clk); //!等待时钟下降沿
            en = 1'b1;
            a = a + 1;
            wr = 1'b1;  //!可写
            d = d + 1;
        end
        a = 10;
        repeat(10) begin
            @(negedge clk);
            a = a + 1;
            wr = 1'b0;  //!可读
        end
    end

    defparam u_ram.MASK = 7;
    ram #(.AW(AW),.DW(DW)) u_ram(
        .CLK(clk),
        .A(a[AW-1:0]),
        .D(d),
        .EN(en),
        .WR(wr),
        .Q(q)
    );

    defparam u_ram4x4.MASK = 7;
    ram_4x4 u_ram4x4(
        .CLK(clk),
        .A(a[AW-1:0]),
        .D(d),
        .EN(en),
        .WR(wr),
        .Q(q)
    );

    initial begin
        forever begin
            #100;
            if($time >= 1000)
                $finish;
        end
    end

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, test);
    end


endmodule