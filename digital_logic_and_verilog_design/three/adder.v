module adder4 (
    input carryin,
    input [3:0]X,Y,
    output carryout,
    output [3:0]S  
);
    wire [3:1]C;
    
    fulladd stage0(carryin,X[0],Y[0],S[0],C[1]);
    fulladd stage1(C[1],X[1],Y[1],S[1],C[2]);
    fulladd stage2(C[2],X[2],Y[2],S[2],C[3]);
    fulladd stage3(C[3],X[3],Y[3],S[3],carryout);
    
endmodule

module fulladd(cin,x,y,s,cout);
input cin,x,y;
output cout,s;

assign s = cin^x^y;
assign cout = (x&y)|(x&cin)|(y&cin);

endmodule