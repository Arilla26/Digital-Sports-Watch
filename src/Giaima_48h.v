`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2024 01:06:21 AM
// Design Name: 
// Module Name: Giaima_48h
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


module Giaima_48h(
    input   [3:0] i,
    output  [11:0] o
    );
    
reg [11:0] ot;
assign o = ot;

always @*
    case(i)
        0: ot = 12'b000000000001;
        1: ot = 12'b000000000010;
        2: ot = 12'b000000000100;
        3: ot = 12'b000000001000;
        4: ot = 12'b000000010000;
        5: ot = 12'b000000100000;
        6: ot = 12'b000001000000;
        7: ot = 12'b000010000000;
        8: ot = 12'b000100000000;
        9: ot = 12'b001000000000;
        10: ot = 12'b010000000000;
        11: ot = 12'b100000000000;
    endcase
endmodule
