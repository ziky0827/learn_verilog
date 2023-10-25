
src = $(wildcard *.sv *.v)
# src = time_delay_tb.v time_delay.v 
#需要把仿真时间的模块放在前面，否则后面文件中出现了仿真延时的文件都需要指定仿真时间

# all:$(obj)

all:clean comp gtk

comp:
	iverilog  -o wave.out $(src)
	vvp -n wave.out -lxt2
gtk:
	gtkwave wave.vcd
clean:
	del *.out *.vcd
.PHONY:clean all
