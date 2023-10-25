ChatGPT
-------

You
---

 

自动售卖机的功能描述如下： 饮料单价 2 元，该售卖机只能接受 0.5 元、1 元的硬币。考虑找零和出货。投币和出货过程都是一次一次的进行，不会出现一次性投入多币或一次性出货多瓶饮料的现象。每一轮售卖机接受投币、出货、找零完成后，才能进入到新的自动售卖状态。根据这个描述，写一个Verilog的3段式状态机。

ChatGPT
-------

Verilog 3段式状态机实现自动售卖机
=====================

功能描述
----

本自动贩卖机的单价为2元，只接受0.5和1元的硬币。考虑找零和出货。

思路
--

根据上述功能描述，我们可以将自动贩卖机分成三个状态：等待投币、已投币和出货状态。在等待投币状态时，如果接收到合法硬币，进入已投币状态；已投币状态时，如果用户要求出货，则检查用户是否已经足够投币后进行出货，并进行找零操作；出货状态直接进入等待投币状态，重新开始下一次交易。

Verilog代码实现
-----------

以下为Verilog代码实现：

```verilog
module vending_machine(input clk, rst, coin_in, btn_out, drink_out);

    enum states { WAIT_COIN, HAS_COIN, DISPENSE };

    reg [1:0] state;
    reg [3:0] change_count;

    always @(posedge clk) begin
        if (rst == 1'b1) begin //复位至等待硬币
            state <= WAIT_COIN;
            drink_out <= 1'b0;
            btn_out   <= 1'b0;
            change_count <= 4'h0;
        end else begin
            case (state)
                WAIT_COIN: begin
                    if (coin_in == 2'h1) begin // 投入0.5元硬币
                        state <= HAS_COIN; // 进入已投币状态
                    end else if (coin_in == 2'h2) begin // 投入1元硬币
                        state <= HAS_COIN;
                    end else begin // 等待投币
                        state <= WAIT_COIN;
                    end
                end
                
                HAS_COIN: begin
                    btn_out <= 1'b1; // 准备出货
                    if (coin_in == 2'h3 && change_count >= 2) begin // 投入0.5元硬币并可找零
                        drink_out <= 1'b1; // 出货
                        state     <= DISPENSE; // 进入出货状态
                        change_count <= change_count - 2; // 找零操作
                    end else if (coin_in == 2'h4 && change_count >= 1) begin // 投入1元硬币并可找零
                        drink_out <= 1'b1;
                        state     <= DISPENSE; // 进入出货状态
                        change_count <= change_count - 1;
                    end else if (coin_in == 2'h5) begin // 退币
                        state    <= WAIT_COIN; // 提前结束本次购买，进入等待硬币状态
                        coin_out <= change_count; // 返回用户投入的硬币
                        change_count <= 4'h0; // 清空存储的找零金额
                    end else begin // 等待用户选择操作
                        state <= HAS_COIN;
                    end
                end
                
                DISPENSE: begin
                    if (coin_in == 2'h0) begin
                        state <= WAIT_COIN;
                    end else begin
                        state <= DISPENSE;
                    end
                end
            endcase
        end
    end
    
    assign coin_out = (state == WAIT_COIN) ?coin_in :change_count;

endmodule
```

### 参数解释：

*   `clk`: 表示时钟输入端口
*   `rst`: 外部复位信号
*   `coin_in`:表示用户投入的金额
*   `btn_out`: 出货按钮输出
*   `drink_out`: 表示是否有饮料出货
*   `state`：标记当前状态机所处的状态（WAIT\_COIN等待硬币，HAS\_COIN正在处理、DISPENSE出货状态）
*   `change_count`: 存储当前找零金额

### 状态转换说明：

*   从“等待硬币”状态开始，若收到0.5元或1元硬币，进入“已投币”状态。
*   在“已投币”状态中，如果按下出货按钮，且用户已经足够投入对应金额，会进入“