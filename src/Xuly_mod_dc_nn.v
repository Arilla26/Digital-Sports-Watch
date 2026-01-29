`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 11:50:32 PM
// Design Name: 
// Module Name: Xuly_mod_dc_nn
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


module Xuly_mod_dc_nn(
    input ckht, rst, btn_mod, cdb_up, cdb_dw, ena2hz,
    output [1:0] gt_mod,
    output [11:0] dc_12led, ena_12led
    );
    
wire[1:0] gt_mod_t;
wire[4:0] tg_nn;

assign gt_mod = gt_mod_t;

Dem_2bit_btn    N1 (
        .ckht(ckht),
        .rst(rst),
        .tg_nn(tg_nn),
        .btn(btn_mod),
        .q(gt_mod_t)
        );
        
Dau_cham        N2  (
        .gt_mod(gt_mod_t),
        .dc_12led(dc_12led)
        );
        
Dem_mod_20_nn   N3  (
        .ckht(ckht),
        .rst(rst),
        .cdb_up(cdb_up),
        .cdb_dw(cdb_dw),
        .ena2hz(ena2hz),
        .gt_mod(gt_mod_t),
        .ena_12led(ena_12led),
        .q(tg_nn)
        );
            
endmodule

