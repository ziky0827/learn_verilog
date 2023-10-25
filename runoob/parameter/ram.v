//!带参数例化

module ram(
    input CLK,
    input [AW-1:0] A,
    input [DW-1:0] D,
    input EN,
    input WR,   //!1 for write and 0 for read
    output reg [DW-1:0] Q
    );

    parameter AW = 2;
    parameter DW = 3;

    parameter MASK = 3;

    reg [DW-1:0] mem [0:(1<<AW)-1]; //!2*AW个DW位寄存器
    always@(posedge CLK) begin
        if(EN && WR) begin 
            mem[A] <= D;
        end
        else if(EN && !WR) begin
            Q <= mem[A];
        end
    end

endmodule

module ram_4x4(
    input CLK,
    input [4-1:0] A,
    input [4-1:0] D,
    input EN,
    input WR,   //!1 for write and 0 for read
    output reg [4-1:0] Q
    );
    parameter MASK = 3;
    reg [4-1:0] mem [0:(1<<4)-1];
    always@(posedge CLK) begin
        if(EN && WR) begin 
            mem[A] <= D & MASK;
        end
        else if(EN && !WR) begin
            Q <= mem[A] & MASK;
        end
    end
endmodule