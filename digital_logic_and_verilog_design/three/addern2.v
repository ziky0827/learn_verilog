//---利用生成模块generate循环例化全加器//
module adder2 (carryin,x,y,s,carryout);
    parameter n = 2;
    input carryin;
    input [n-1:0]x,y;
    output [n-1:0]s;
    output carryout;
    wire [n:0]c;
    genvar i;   //生成模块的变量定义

    assign c[0] = carryin;
    assign carryout = c[n];

    generate
        for(i=0;i<n;i=i+1)
        begin:addbit
            fulladd stage(c[i],x[i],y[i],s[i],c[i+1]);
        end
    endgenerate
endmodule

module fulladd(cin,X,Y,S,cout);
    input cin,X,Y;
    output S,cout;
    assign S = X^Y^cin;
    assign cout = (X&Y) | (X&cin) | (Y&cin);
endmodule