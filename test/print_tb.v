/*
 * @Author       : ziky
 * @Date         : 2023-10-11 20:29:31
 * @Version      : V1.0.0
 * @LastEditTime : 2024-08-09 21:12:24
 * @LastEditors  : ziky
 * @FilePath     : \verilog_prj\test\print_tb.v
 * @Description  : ≤‚ ‘ ‰≥ˆ¥Ú”°display
 */

module print_tb();

    reg [3:0] a;
    reg [3:0] b;
    reg [4:0] d;
    initial begin
    a = 4'ha;
    b = 4'hc;
    d= a+b;
    $display("%d",d);
    end
    reg signed [3:0] data_i;
    reg signed [3:0] data_q;
    reg signed [7:0] data_o;
    initial begin
    data_i=4'sh3;
    data_q=4'shE;
    data_o=$signed(data_i[3:0])*$signed(data_q[3:0]) ;
    $display("%d",data_o);
    end
    
    initial begin
        $display("Hello, World!");
        $finish;
    end
endmodule