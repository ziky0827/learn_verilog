//!比较器的一般结构,利用减法进行比较（加法器）

module comparator2 (x,y,V,N,Z);
parameter n = 32;
input [n-1:0]x,y;       //!比较的数
output reg Z,       //!结果是0，z=1
           V,       //!结果是负数，V=1
           N;       //!发生溢出，N=1
reg [n-1:0]s;
reg[n:0]c;

endmodule