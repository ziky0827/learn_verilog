//!�Ƚ�����һ��ṹ,���ü������бȽϣ��ӷ�����

module comparator2 (x,y,V,N,Z);
parameter n = 32;
input [n-1:0]x,y;       //!�Ƚϵ���
output reg Z,       //!�����0��z=1
           V,       //!����Ǹ�����V=1
           N;       //!���������N=1
reg [n-1:0]s;
reg[n:0]c;

endmodule