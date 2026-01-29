`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 08:38:51 PM
// Design Name: 
// Module Name: Lam_hep_xung
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


module Lam_hep_xung(
    input ckht,
    input d,
    output q
    );
    
reg qff;

always @(negedge ckht)
    qff = d;
    
assign q = (~qff)&d;
endmodule
