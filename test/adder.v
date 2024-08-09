/*
 * @Author       : ziky
 * @Date         : 2023-03-06 18:59:13
 * @Version      : V1.0.0
 * @LastEditTime : 2024-08-09 21:09:06
 * @LastEditors  : ziky
 * @FilePath     : \verilog_prj\test\adder.v
 * @Description  : È«¼ÓÆ÷
 */
//£¡Module description

module adder(X, Y, Cin, Cout, S);

  input [0:1] X;  //!input
  input [0:1] Y;
  input Cin;
  output reg [0:1]S;
  output reg Cout;
//£¡always
  always @(X , Y , Cin)
  begin
    {Cout , S} = X + Y + Cin;   //!pinjie
  end
endmodule
