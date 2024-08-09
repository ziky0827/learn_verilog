//---����λ�źź�����źŵ�ȫ����---//
module adder3 (cin,x,y,s,cout,overflow);
    parameter n = 32;
    input cin;
    input [n-1:0]x,y;
    output reg [n-1:0]s;
    output reg cout,overflow;

    always@(cin,x,y)
    begin
        s = x+y+cin;
        cout = (x[n-1]&y[n-1] | (x[n-1])&s[n-1]) | (y[n-1]&s[n-1]);     //�������ʱ����λ�ź�ҲҪ�����Ƿ���Ч
        overflow = (x[n-1]&y[n-1]&~s[n-1]) | (~x[n-1]&~y[n-1]&s[n-1]);      //��ߵĽ�λ����ŵĽ�λ��ͬ�������������������ͬ�ķ��Ŷ��������ǲ�ͬ�����
    end
//    assign s = x+y+cin;     //�����Ҳһ��
    
    
    
endmodule