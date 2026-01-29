`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 09:10:28 AM
// Design Name: 
// Module Name: Dem_GPG_NN
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


module Dem_GPG_NN(
    input ckht, ena2hz,ena5hz,ena_db,
    input rst, btn_up, btn_mod, btn_dw, btn_ps,
    output [11:0] dc_12led, ena_12led,
    output [6:0] gio, phut, giay, ptgiay
    );
    
    wire [1:0] gt_mod;
    wire cdb_up, cdb_dw, cdb_ps;
    
Debounce_btn    K1  (
        .ckht(ckht),
        .btn(btn_up),
        .db_tick(cdb_up)
        );
        
Debounce_btn    K2  (
        .ckht(ckht),
        .btn(btn_dw),
        .db_tick(cdb_dw)
        );

Debounce_btn    K3  (
        .ckht(ckht),
        .btn(btn_ps),
        .db_tick(cdb_ps)
        );

Xuly_mod_dc_nn  K4   (
        .ckht(ckht), .rst(rst),
        .btn_mod(btn_mod),
        .cdb_up(cdb_up), .cdb_dw(cdb_dw), .cdb_ps(cdb_ps),
        .ena2hz(ena2hz),
        .gt_mod(gt_mod),
        .dc_12led(dc_12led),
        .ena_12led(ena_12led)
        );          

Dem_GPG_MUD1     K5  (
        .ckht(ckht), .rst(rst),
        .ena_db(ena_db),
        .ena5hz(ena5hz),
        .gt_mod(gt_mod),
        .ena_up(cdb_up),
        .ena_dw(cdb_dw),
        .ena_ps(cdb_ps),
        .ptgiay(ptgiay),
        .giay(giay),
        .phut(phut),
        .gio(gio)
        );

endmodule
