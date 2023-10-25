//！线性时延
// `timescale 1ns/1ns
module time_delay(ai,bi,so_nomal,so_get,so_lose);
    input ai,bi;    //!输入信号
    output so_nomal,so_get,so_lose; //!输出信号
    assign #20 so_lose = ai & bi;
    assign #5 so_get = ai & bi;
    assign so_nomal = ai & bi;
endmodule