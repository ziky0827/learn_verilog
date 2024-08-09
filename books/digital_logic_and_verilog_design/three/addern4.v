/*---n位加法器的简化实现---*/
module addern4(cin,x,y,s,cout,overflow);
    parameter n = 32;
    input cin;
    input [n-1:0]x,y;
    output reg [n-1:0]s;
    output reg cout,overflow;

    always @(cin,x,y) 
    begin
        {cout,s} = x+y+cin;     //利用拼接运算符，直接将计算结果赋给和与进位
        overflow = (x[n-1]&y[n-1]&~s[n-1]) | (~x[n-1]&~y[n-1]&s[n-1]);    //加数与和的符号不同则发生溢出
    end
endmodule