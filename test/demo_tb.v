/*
 * @Author       : ziky
 * @Date         : 2023-03-06 18:59:13
 * @Version      : V1.0.0
 * @LastEditTime : 2024-08-09 21:09:51
 * @LastEditors  : ziky
 * @FilePath     : \verilog_prj\test\demo_tb.v
 * @Description  : ≤‚ ‘ ‰≥ˆ¥Ú”°
 */

module demo_tb;
  reg [5:0]var1,var2;
  integer i = 0;
  integer sum = 0;

  initial
  begin
    $display("Hello Welcome to use Modelsim to Simulink");

    for(i=0; i<20; i=i+1)
    begin
      sum = sum + i;
      $display("i is: %d", i);
    end
    $display("sum is: %d", sum);

    var1 = 10;
    var2 = 20;
    $display("var1+var2: %d", var1+var2);
  end

endmodule
