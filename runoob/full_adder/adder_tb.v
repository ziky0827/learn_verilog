`timescale 1ns/1ns
`include "adder.v"
module adder_tb;
    reg Ai, Bi, Ci; //!input
    wire So,Co; //!output
    initial
    begin
        {Ai, Bi, Ci} = 3'b0;
        forever
        begin
            #10;
            {Ai, Bi, Ci} = {Ai, Bi, Ci} + 1'b1;
        end
    end

    adder adder_test (
              .Ai (Ai ),
              .Bi (Bi ),
              .Ci (Ci ),
              .So (So ),
              .Co  (Co));

    initial
    begin
        forever
        begin
            #100;
            $display("---gyc---%d",$time);
            if ($time >=1000)
            begin
                $finish;
            end
        end
    end

    initial
    begin
        $dumpfile("wave.vcd");
        $dumpvars(0, adder_tb);
    end

endmodule
