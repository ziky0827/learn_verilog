//!全加器的通用结构

module addern (carryin,x,y,s,carryout);
    parameter n = 2;
    input carryin;
    input [n-1:0]x,y;
    output reg carryout;
    output reg [n-1:0]s;
    reg [n:0]c;
    integer k;  // 循环变量的定义
    always@(x,y,carryin)
    begin
        c[0] = carryin;
        for(k=0;k<n;k=k+1)
            begin
                s[k] = x[k]^y[k]^c[k];
                c[k+1] = (x[k]&y[k]) | (x[k]&c[k]) | (y[k]&c[k]);
            end
        carryout = c[k];
    end 

endmodule