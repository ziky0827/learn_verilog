/*---nλ�ӷ����ļ�ʵ��---*/
module addern4(cin,x,y,s,cout,overflow);
    parameter n = 32;
    input cin;
    input [n-1:0]x,y;
    output reg [n-1:0]s;
    output reg cout,overflow;

    always @(cin,x,y) 
    begin
        {cout,s} = x+y+cin;     //����ƴ���������ֱ�ӽ����������������λ
        overflow = (x[n-1]&y[n-1]&~s[n-1]) | (~x[n-1]&~y[n-1]&s[n-1]);    //������͵ķ��Ų�ͬ�������
    end
endmodule