//!---deparam��ʵ�ֲ�ͬ�ӷ����Ĳ�������---

`include "addern4.v"    //��������ģ�飬��Ҫ���룬�ɲ��ùܱ���
module adder_hier2(a,b,c,d,s,t,overflow);
    input [15:0]a,b;        //!ʵ��16λ�ӷ���
    input [7:0]c,d;    
    output [16:0]s;        //!���λ���ڽ�λ���
    output [8:0]t;
    output overflow;
    wire o1,o2;     //!���ڴ������ź�
    
    addern4 U1 (1'b0,a,b,s[15:0],s[16],o1);
    defparam U1.n = 16;

    addern4 U2 (1'b0,c,d,t[7:0],t[8],o2);
    defparam U2.n = 8;

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
//        {cout,s} = x+y+cin;     //����ƴ���������ֱ�ӽ����������������λ
//        overflow = (x[n-1]&y[n-1]&~s[n-1]) | (~x[n-1]&~y[n-1]&s[n-1]);    //������͵ķ��Ų�ͬ�������
//    end
//endmodule