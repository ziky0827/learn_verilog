//!#()，实现不同加法器的参数输入

`include "addern4.v"    //包含的子模块，需要编译，可不用管报错
module adder_hier2(a,b,c,d,s,t,overflow);
    input [15:0]a,b;        //!实现16位加法器
    input [7:0]c,d;    
    output [16:0]s;        //!最高位用于进位输出
    output [8:0]t;
    output overflow;
    wire o1,o2;     //!用于存放溢出信号
    
    addern4 #(16)U1 (1'b0,a,b,s[15:0],s[16],o1);
    addern4 #(8)U2 (1'b0,c,d,t[7:0],t[8],o2);
    addern4 #(.n(16))U3 (.cin(1'b0),.x(a),.y(b),.s(s[15:0]),.cout(s[16]),.overflow(o1));
    addern4 #(.n(8))U4 (.cin(1'b0),.x(c),.y(d),.s(t[7:0]),.cout(t[8]),.overflow(o2));
    
    assign overflow = o1|o2;

endmodule

//module addern4(cin,x,y,s,cout,overflow);
//    parameter n = 32;
//    input cin;
//    input [n-1:0]x,y;
//    output reg [n-1:0]s;
//    output reg cout,overflow;
//
//    always @(cin,x,y) 
//    begin
//        {cout,s} = x+y+cin;     //利用拼接运算符，直接将计算结果赋给和与进位
//        overflow = (x[n-1]&y[n-1]&~s[n-1]) | (~x[n-1]&~y[n-1]&s[n-1]);    //加数与和的符号不同则发生溢出
//    end
//endmodule