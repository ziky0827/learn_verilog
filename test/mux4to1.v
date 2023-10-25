module mux4to1 (w0,w1,w2,w3,sel,out);
    input w0,w1,w2,w3;
    input [1:0]sel;
    output reg out;
    always @(*) begin
        if (sel==0) 
            out = w0;
        else if(sel==1)
            out = w1;
        else if(sel==2)
            out = w2;
        else
            out = w3;
    end
endmodule