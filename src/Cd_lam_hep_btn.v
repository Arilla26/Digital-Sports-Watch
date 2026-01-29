`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 08:19:15 PM
// Design Name: 
// Module Name: Cd_lam_hep_btn
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


module Cd_lam_hep_btn(
    input ckht, btn,
    output xcdlh
    );
wire xcd;   
Debounce_btn    U1  (
        .ckht(ckht),
        .btn(btn),
        .db_tick(xcd)
        );
Lam_hep_xung    U2  (
        .ckht(ckht),
        .d(xcd),
        .q(xcdlh)
        );
endmodule
