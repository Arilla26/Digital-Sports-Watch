`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 06:38:08 PM
// Design Name: 
// Module Name: Dem_2bit_btn
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


module Dem_2bit_btn(
    input ckht,rst,btn,
    input [4:0] tg_nn,
    output [1:0] q
    );

wire xcdlh;

Cd_lam_hep_btn  M1(
        .ckht(ckht),
        .btn(btn),
        .xcdlh(xcdlh)
        );
Dem_2bit        M2(
        .ckht(ckht),
        .rst(rst),
        .ena_db(xcdlh),
        .tg_nn(tg_nn),
        .q(q)
        );

endmodule
