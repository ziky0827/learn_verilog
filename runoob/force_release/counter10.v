//!10bit counter
module counter10(rstn,clk,cnt,cout);
    input rstn,clk;
    output [3:0] cnt;   //！计数过程
    output cout;    //！完成一轮计数
    
    reg [3:0] cnt_temp; //!临时变量

    always@(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_temp <= 4'b0;
        end
        else if(cnt_temp == 4'd9) begin
            cnt_temp <= 4'b0;
        end
        else begin
            cnt_temp <= cnt_temp + 1'b1;
        end
    end

    assign cout = (cnt_temp == 4'd9);
    assign cnt = cnt_temp;

endmodule

//！过程连续赋值语句
module dff_normal(
    input rstn,
    input clk,
    input D,
    output reg Q1
);
    always@(posedge clk or negedge rstn) begin
        if(!rstn) begin
            Q1 <= 1'b0;
        end
        else begin
            Q1 <= D;
        end
    end

endmodule

//!过程连续赋值语句
module dff_assign(
    input rstn,
    input clk,
    input D,
    output reg Q2
);
    always@(posedge clk) begin
        Q2 <= D;
    end

    always@(posedge clk) begin
        if(!rstn) begin
            assign Q2 = 1'b0;
        end
        else begin
            deassign Q2;
        end
    end
endmodule