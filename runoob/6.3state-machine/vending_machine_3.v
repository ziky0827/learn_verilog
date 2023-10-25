//! vending-machine
//! 2 yuan for a bottle of drink
//! only 2 coins supported: 5 jiao and 1 yuan
//! finish the function of selling and changing

module vending_machine_3 (
    input clk,
    input rstn,
    input [1:0] coin,           //!01 for 0.5 jiao, 10 for 1 yuan
    output [1:0] change,
    output sell                 //!output the drink
    );

    //!machine state decode
    parameter IDLE = 4'b0001;      //!idle state
    parameter GET05 = 4'b0010;     //!get 0.5 jiao
    parameter GET10 = 4'b0100;     //!get 1 jiao
    parameter GET15 = 4'b1000;     //!get 1.5 jiao

    //!machine varible,warning the Bit width
    reg [3:0] st_next;          //!next state
    reg [3:0] st_cur;           //!current state

    //!(1)state transfer
    always@(posedge clk or negedge clk) begin
        if(!rstn) begin
            st_cur <= 2'b0;
        end
        else begin
            st_cur <= st_next;
        end
    end

    //!(2)state swith,using block assignment for combination-logic
    always@(*) begin
        case(st_cur)
            IDLE:
                case(coin)
                    2'b01: st_next = GET05;
                    2'b10: st_next = GET10;
                    default: st_next = IDLE;
                endcase
            GET05:
            case(coin)
                    2'b01: st_next = GET10;
                    2'b10: st_next = GET15;
                    default: st_next = GET05;
            endcase
            GET10:
                case(coin)
                    2'b01: st_next = GET15;
                    2'b10: st_next = IDLE;
                    default: st_next = GET10;
                endcase
            GET15:
                case(coin)
                    2'b01: st_next = IDLE;
                    2'b10: st_next = IDLE;
                    default: st_next = GET15;
                endcase
            default: st_next = IDLE;
        endcase
    end

    //!(3)state output,using non-block,logic operation
    reg [1:0] change_r;      //!always use reg to store the output
    reg sell_r;
    always@(posedge clk or negedge clk) begin
        if(!rstn) begin
            change_r <= 2'b0;
            sell_r <= 1'b0;
        end
        //!11+01,10+10
        else if((st_cur == GET15 && coin == 2'b01) || (st_cur == GET10 && coin ==2'b10))
            begin
                change_r <= 2'b0;
                sell_r <= 1'b1;
            end
        //!11+10,change 01
        else if(st_cur == GET15 && coin == 2'b10) begin
            change_r <= 2'b01;
            sell_r <= 1'b1;
        end
        else begin
            change_r <= 2'b0;
            sell_r <= 1'b0;
        end
    end
    assign sell = sell_r;
    assign change = change_r;    
endmodule

