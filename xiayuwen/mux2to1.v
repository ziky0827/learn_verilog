module mux2to1(out,a,b,sel);
    input a,b,sel;//��ע�������sel�������źţ���������źţ����Բ���reg����
    output out;//��ע�������out������źţ����������źţ����Բ���wire����
    reg out;
    
always @ (a or b or sel)
    begin
        if (sel == 1'b0) out = a;
        else out = b;
    end
endmodule