module mux2to1(out,a,b,sel);
    input a,b,sel;//！注意这里的sel是输入信号，不是输出信号，所以不用reg声明
    output out;//！注意这里的out是输出信号，不是输入信号，所以不用wire声明
    reg out;
    
always @ (a or b or sel)
    begin
        if (sel == 1'b0) out = a;
        else out = b;
    end
endmodule