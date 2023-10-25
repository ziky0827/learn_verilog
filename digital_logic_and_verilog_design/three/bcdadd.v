//!1位bcd加法器
module bcdadd(cin,x,y,s,cout);
    input cin;
    input [3:0]x,y;
    output reg [3:0]s;
    output reg cout;
    reg [4:0]z;      //存储中间值，判断是否需要校正
    
    always@(cin,x,y)
    begin
        z = x+y+cin;
        if(z<10)
            {cout,s} = z;
        else
            {cout,s} = z+6;     //！结果超过十需要＋6进行矫正

    end

endmodule