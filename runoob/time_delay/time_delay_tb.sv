//!仿真线性时延
`timescale 1ns/1ns
// `include "time_delay.v"

module time_delay_tb;

reg  ai,bi; //!input
wire so_nomal,so_get,so_lose; //!output

initial
    begin
        ai = 0;
        #25 ai = 1; //!25ns
        #35 ai = 0; //!60ns
        #40 ai = 1; //!100ns
        #10 ai = 0; //!110ns
    end

initial
    begin
        bi = 1;
        #70 bi = 0; //!70ns
        #20 bi = 1; //!90ns
    end

//！实列化模块
time_delay u_time_delay (
    .ai      (ai      ),
    .bi      (bi      ),
    
    .so_nomal(so_nomal),
    .so_get  (so_get  ),
    .so_lose (so_lose )
);


initial
    begin
        forever begin
            #100;
            //$display("---gyc---%d", $time);
            if ($time >= 1000) begin
                $finish ;
            end
        end
    end

initial
    begin
        $dumpfile("wave.vcd");
        $dumpvars(0);
    end

endmodule
/*仿真结果
信号 so_normal 为正常的与逻辑。

由于所有的时延均大于 5ns，所以信号 so_get 的结果为与操作后再延迟 5ns 的结果。

信号 so_lose 前一段是与操作后再延迟 20ns 的结果。

由于信号 ai 第二个高电平持续时间小于 20ns，so_lose 信号会因惯性时延而漏掉对这个脉冲的延时检测，所以后半段 so_lose 信号仍然为 0。
*/