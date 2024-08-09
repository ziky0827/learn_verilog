//!�Ƚ�����ͨ�ýṹ,���ü������бȽϣ��ӷ�����

module comparator2 (x,y,V,N,Z);
    parameter n = 32;
    input [n-1:0]x,y;       //!�Ƚϵ���
    output reg Z,       //!�����0��z=1
               V,       //!����Ǹ�����v=1
               N;       //!���������n=1
    reg [n-1:0]s;
    reg[n:0]c;

    integer k;      //!ѭ������

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