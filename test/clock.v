//!HDLBits题目，设计时钟模块，用bcd码，16进制数表示个位十位

/*Create a set of counters suitable for use as a 12-hour clock (with am/pm indicator). Your counters are clocked by a fast-running clk, 
with a pulse on ena whenever your clock should increment (i.e., once per second).
reset resets the clock to 12:00 AM. pm is 0 for AM and 1 for PM. hh, mm, and ss are two BCD (Binary-Coded Decimal) digits each for hours (01-12), minutes (00-59), and seconds (00-59). 
Reset has higher priority than enable, and can occur even when not enabled.
The following timing diagram shows the rollover behaviour from 11:59:59 AM to 12:00:00 PM and the synchronous reset and enable behaviour.
*/

//!应该先判断十位上的数字然后根据十位上的数字来限制个位数字的取值范围

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    always@(posedge clk) begin
        if(reset) begin
            hh<=8'h12;
            mm<=8'h0;
            ss<=8'h0;
            pm<=1'b0;
        end
        else if(ena) begin
            if(pm==1'b0) begin
                if(ss[7:4]<4'h5) begin  //!判断秒数的十位
                    if(ss[3:0]<4'h9) begin  //!判断秒数的个位
                        ss[3:0]<=ss[3:0]+4'h1;
                    end
                    else begin
                        ss[7:4]<=ss[7:4]+4'h1;
                        ss[3:0]<=4'h0;
                    end
                end
                else begin
                    if(ss[3:0]<4'h9) begin
                        ss[3:0]<=ss[3:0]+4'h1;
                    end
                    else begin
                        ss[3:0]<=4'h0;
                        ss[7:4]<=4'h0;
                    end
                end
                
                if(ss==8'h59 & mm[7:4]<4'h5) begin
                    if(mm[3:0]<4'h9) begin
                        mm[3:0]<=mm[3:0]+4'h1;
                    end
                    else begin
                        mm[7:4]<=mm[7:4]+4'h1;
                        mm[3:0]<=4'h0;
                    end
                end
                else if(ss==8'h59 & mm[7:4]==4'h5) begin
                    if(mm[3:0]<4'h9) begin
                        mm[3:0]<=mm[3:0]+4'h1;
                    end
                    else begin
                        mm[3:0]<=4'h0;
                        mm[7:4]<=4'h0;
                    end
                end

                if(ss==8'h59 & mm==8'h59 & hh==8'h12) begin
                        hh[7:4]<=4'h0;
                        hh[3:0]<=4'h1;
                end
                else if(ss==8'h59 & mm==8'h59 & hh[7:4]==4'h0) begin
                    if(hh[3:0]<4'h9) begin
                        hh[3:0]<=hh[3:0]+4'h1;
                    end
                    else begin
                        hh[7:4]<=4'h1;
                        hh[3:0]<=4'h0;
                    end
                end
                else if(ss==8'h59 & mm==8'h59 & hh[7:4]==4'h1) begin
                    if(hh[3:0]<4'h1) begin
                        hh[3:0]<=hh[3:0]+4'h1;
                    end
                    else begin
                        hh<=8'h12;
                        mm<=8'h0;
                        ss<=8'h0;
                        pm<=1'b1;
                    end
                end
            end

            else begin
                if(ss[7:4]<4'h5) begin  //!判断秒数的十位
                    if(ss[3:0]<4'h9) begin  //!判断秒数的个位
                        ss[3:0]<=ss[3:0]+4'h1;
                    end
                    else begin
                        ss[7:4]<=ss[7:4]+4'h1;
                        ss[3:0]<=4'h0;
                    end
                end
                else begin
                    if(ss[3:0]<4'h9) begin
                        ss[3:0]<=ss[3:0]+4'h1;
                    end
                    else begin
                        ss[3:0]<=4'h0;
                        ss[7:4]<=4'h0;
                    end
                end
                
                if(ss==8'h59 & mm[7:4]<4'h5) begin
                    if(mm[3:0]<4'h9) begin
                        mm[3:0]<=mm[3:0]+4'h1;
                    end
                    else begin
                        mm[7:4]<=mm[7:4]+4'h1;
                        mm[3:0]<=4'h0;
                    end
                end
                else if(ss==8'h59 & mm[7:4]==4'h5) begin
                    if(mm[3:0]<4'h9) begin
                        mm[3:0]<=mm[3:0]+4'h1;
                    end
                    else begin
                        mm[3:0]<=4'h0;
                        mm[7:4]<=4'h0;
                    end
                end

                if(ss==8'h59 & mm==8'h59 & hh==8'h12) begin
                        hh[7:4]<=4'h0;
                        hh[3:0]<=4'h1;
                    end
                else if(ss==8'h59 & mm==8'h59 & hh[7:4]==4'h0) begin

                    if(hh[3:0]<4'h9) begin
                        hh[3:0]<=hh[3:0]+4'h1;
                    end
                    else begin
                        hh[7:4]<=4'h1;
                        hh[3:0]<=4'h0;
                    end
                end
                    
                else if(ss==8'h59 & mm==8'h59 & hh[7:4]==4'h1) begin
                    if(hh[3:0]<4'h1) begin
                        hh[3:0]<=hh[3:0]+4'h1;
                    end
                    else begin
                        hh<=8'h12;
                        mm<=8'h0;
                        ss<=8'h0;
                        pm<=1'b0;
                    end
                end
            end
        end
    end

endmodule
