//! Code comment
`include "adder.v"    //��������ģ��
`timescale 1ns/100ps

module adder_tb();
    reg [0:1] A , B;
    reg Cin;
    output [0:1]S;
    output Cout;

    adder U(
            .X(A),  //!�˿�
            .Y(B),
            .Cin(Cin),
            .Cout(Cout),
            .S(S)
            );

    initial
    begin
        A = 0;
        B = 2;
        Cin = 1;
        #10 A = 1;
        #10 Cin = 1;
        #10 B = 0;
        #20 A = 3;
        #30 Cin = 0;
        #40 B = 3;
        #50 Cin = 1;
    end

    initial
    begin
        $monitor($time,,,"part:%b  %b", S, Cout);
        #70
        $finish;
    end
    /*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //���ɵ�vcd�ļ�����
        $dumpvars(0);    //tbģ������
    end
    /*iverilog */

endmodule
//!adder.v:44: $finish called at 70 (1s)��֪����������ʲô��˼
