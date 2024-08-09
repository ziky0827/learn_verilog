//---带进位信号和溢出信号的全加器---//
module adder3 (cin,x,y,s,cout,overflow);
    parameter n = 32;
    input cin;
    input [n-1:0]x,y;
    output reg [n-1:0]s;
    output reg cout,overflow;

    always@(cin,x,y)
    begin
        s = x+y+cin;
        cout = (x[n-1]&y[n-1] | (x[n-1])&s[n-1]) | (y[n-1]&s[n-1]);     //考虑溢出时，进位信号也要考虑是否有效
        overflow = (x[n-1]&y[n-1]&~s[n-1]) | (~x[n-1]&~y[n-1]&s[n-1]);      //最高的进位与符号的进位不同则溢出；两个加数有相同的符号而和与他们不同则溢出
    end
//    assign s = x+y+cin;     //该语句也一样
    
    
    
endmodule