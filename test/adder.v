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
