//!1λbcd�ӷ���
module bcdadd(cin,x,y,s,cout);
    input cin;
    input [3:0]x,y;
    output reg [3:0]s;
    output reg cout;
    reg [4:0]z;      //�洢�м�ֵ���ж��Ƿ���ҪУ��
    
    always@(cin,x,y)
    begin
        z = x+y+cin;
        if(z<10)
            {cout,s} = z;
        else
            {cout,s} = z+6;     //���������ʮ��Ҫ��6���н���

    end

endmodule