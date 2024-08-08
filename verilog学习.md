# verilog仿真
```verilog
    initial begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0);    //tb模块名称,$dumpvar (0, top); 指定层次数为0，则top模块及其下面各层次的所有信号将被记录
        #100 $finish;    //仿真结束时间,iverilog仿真时需要加入$finish指令，否则会一直运行下去，可以用Ctrl+C终止。
    end
```