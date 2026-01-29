`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 11:07:12 AM
// Design Name: 
// Module Name: Debounce_btn
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Debounce_btn(
    input ckht,
    input btn,
    output db_tick
    );
    
parameter [1:0]
    zero    = 2'b00,
    wait1   = 2'b01,
    one     = 2'b10,
    wait0   = 2'b11;
    
reg [1:0]   tt_r;
reg [1:0]   tt_n;
reg [19:0]   dl_r;
reg [19:0]   dl_n;
reg tick;
initial
    begin
        dl_r = 0;
        dl_n = 0;
        tt_r = zero;
        tt_n = zero;
    end
always @(negedge ckht)
    begin
        tt_r = tt_n;
        dl_r = dl_n;
    end
always @*
    begin
        tt_n = tt_r;
        dl_n = dl_r;
        tick = 1'b0;
        case (tt_r)
        zero: if(btn)
            begin
                dl_n = 1000000;
                tt_n = wait1;
            end
        wait1:
            begin
                dl_n = dl_r - 1;
                if(dl_r == 0)
                    if(btn) tt_n = one;
                    else    tt_n = zero;
                end
        one:
            begin
                tick = 1'b1;
                if(~btn)
                    begin
                        dl_n = 1000000;
                        tt_n = wait0;
                    end
            end
         wait0:
             begin
                tick = 1'b1;
                dl_n = dl_r - 1;
                if(dl_r == 0)
                    if(~btn) tt_n = zero;
                    else    tt_n = one;
                end
        endcase
    end
    
    assign db_tick = tick;
                   
endmodule
