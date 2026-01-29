`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 10:42:06 AM
// Design Name: 
// Module Name: HEXTOBCD_GPGPT
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


module HEXTOBCD_GPGPT(
    input  [6:0] ptgiay, giay, phut, gio,
    output [3:0] dv_ptgiay, ch_ptgiay,
    output [3:0] dv_giay, ch_giay,
    output [3:0] dv_phut, ch_phut,
    output [3:0] dv_gio, ch_gio
    );

HEXTOBCD_7BIT K1 (
            .sohex7bit(ptgiay),
            .donvi(dv_ptgiay),
            .chuc(ch_ptgiay)
            );
    
HEXTOBCD_7BIT K2 (
            .sohex7bit(giay),
            .donvi(dv_giay),
            .chuc(ch_giay)
            );
            
HEXTOBCD_7BIT K3 (
            .sohex7bit(phut),
            .donvi(dv_phut),
            .chuc(ch_phut)
            );
            
HEXTOBCD_7BIT K4 (
            .sohex7bit(gio),
            .donvi(dv_gio),
            .chuc(ch_gio)
            );
endmodule
