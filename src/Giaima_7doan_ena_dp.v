`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2024 12:51:13 AM
// Design Name: 
// Module Name: Giaima_7doan_ena_dp
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


module Giaima_7doan_ena_dp(
    input   [3:0] so_gma,
    input   ena, dp,
    output  [7:0] sseg
    );
    
reg [6:0] ssegt;
assign sseg = (ena==1'b1) ? {dp,ssegt} : 8'b00000000;    

always @*
    case(so_gma)
        0: ssegt = 7'b0111111;
        1: ssegt = 7'b0000110;
        2: ssegt = 7'b1011011;
        3: ssegt = 7'b1001111;
        4: ssegt = 7'b1100110;
        5: ssegt = 7'b1101101;
        6: ssegt = 7'b1111101;
        7: ssegt = 7'b0000111;
        8: ssegt = 7'b1111111;
        9: ssegt = 7'b1101111;
        10: ssegt = 7'b1110111; //A
        11: ssegt = 7'b1111100; //B
        12: ssegt = 7'b0111001; //C
        13: ssegt = 7'b1011110; //D
        14: ssegt = 7'b1111001; //E
        15: ssegt = 7'b1110001; //F
    endcase
endmodule
