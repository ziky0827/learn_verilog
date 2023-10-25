//!循环语句

`timescale 1ns/1ns

module test_loop;

    //! while-loop
    reg [3:0] counter;
    initial 
    begin
        counter = 0;
        while(counter <= 10)
            begin
                #10;
                counter = counter + 1'b1;
            end
    end

    //! for-loop
    integer i;
    reg [3:0] counter2;
    initial 
    begin
        counter2 = 0;
        for(i = 0; i < 10; i = i + 1)
            begin
                #10;
                counter2 = counter2 + 1'b1;
            end
    end

    //!repeat-loop
    reg [3:0] counter3;
    initial 
    begin
        counter3 = 0;
        repeat (11)
            begin
                #10;
                counter3 = counter3 + 1'b1;
            end
    end

    //!连续存储8位数据
    reg [3:0] buffer [7:0];
    reg clk;
    reg rstn;
    reg enable;
    integer j;

    initial 
    begin
        clk = 0;
        rstn = 1;
        enable = 0;

        #3;
        rstn = 0;
        #3;
        rstn = 1;
        enable = 1;
        forever
        begin
            clk = ~clk;
            #5;
        end
    end

    always@(posedge clk or negedge rstn)
    begin
        j = 0;
        if(!rstn)
        begin
            repeat (8)
            begin 
                buffer[j] <= 'b0;
                j = j + 1;
            end
        end
        else if(enable)
            begin
                repeat (8)
                begin
                    @(posedge clk) buffer[j] <= counter3;   //!只执行一次，相当于wait
                    j = j + 1;
                end
            end
    end


    //!stop
    always 
    begin
        #10;
        if ($time >=1000)
            begin
                $finish;
            end
    end

    initial begin
        $dumpfile("test_loop.vcd");
        $dumpvars(0,test_loop);
    end
endmodule
