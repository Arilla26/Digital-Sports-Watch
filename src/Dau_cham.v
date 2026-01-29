`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 07:06:08 PM
// Design Name: 
// Module Name: Dau_cham
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


module Dau_cham(
    input   [1:0] gt_mod,
    output  [7:0] dc_12led
    );

reg [7:0] dc12;
assign  dc_12led = dc12;

always @*
    case(gt_mod)
        2'b00: dc12 = 12'b000000000000; //d?u ch?m c?a 8 led t?t h?t, không ch?nh
        2'b01: dc12 = 12'b000000001000; //ch?m led ??n v? giây sáng, ch?nh giây
        2'b10: dc12 = 12'b000001000000; //ch?m led ??n v? phút sáng, ch?nh phút
        2'b11: dc12 = 12'b001000000000; //ch?m led ??n v? gi? sáng, ch?nh gi?
    endcase
endmodule
