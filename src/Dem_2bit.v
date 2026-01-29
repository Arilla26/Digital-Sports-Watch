`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 06:50:14 PM
// Design Name: 
// Module Name: Dem_2bit
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


module Dem_2bit(
    input   ckht,rst,ena_db,
    input   [4:0] tg_nn,
    output  [1:0] q
    );
    
reg [1:0] q_r, q_n;
//state register
always @(negedge ckht)
    if(rst) q_r = 0;
    else    q_r = q_n;
//next state logic
always @*
    if(ena_db) q_n = q_r +1; // ki?m tra tín hi?u ena_db( có nh?n btn_mod hay k)
    // gi? s? q_r = 0, thì bây h = 1 gán cho q_n, ch? xung c?p nh?t q_r, chuy?n m?ch sang tr?ng thái ch?nh giây 2'b01
    // q_r = 2, t?c 2'b10, sang ch?nh phút
    else if(tg_nn == 20) q_n = 0;
    else q_n = q_r;
//output logic
assign q = q_r;

endmodule

