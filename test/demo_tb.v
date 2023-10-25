//输出测试信息
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
