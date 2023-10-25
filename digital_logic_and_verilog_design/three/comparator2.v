//!比较器的通用结构,利用减法进行比较（加法器）

module comparator2 (x,y,V,N,Z);
    parameter n = 32;
    input [n-1:0]x,y;       //!比较的数
    output reg Z,       //!结果是0，z=1
               V,       //!结果是负数，v=1
               N;       //!发生溢出，n=1
    reg [n-1:0]s;
    reg[n:0]c;

    integer k;      //!循环变量

    always@(x,y)
    begin
        c[0] = 1'b1;
        for(k=0;k<n;k=k+1)
            begin
                s[k] = x[k]^~y[k]^c[k];
                c[k+1] = (x[k]^~y[k]) | (x[k]&c[k]) | (~y[k]^c[k]);
            end
        V = c[n]^c[n-1];
        N = s[n-1];
        Z = !s;
    end

endmodule