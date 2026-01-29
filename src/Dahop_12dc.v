`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2024 12:50:27 AM
// Design Name: 
// Module Name: Dahop_12dc
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


module Dahop_12dc(
    input   i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,
    input   [3:0] s,
    output  o
    );
    
reg ot;
assign o = ot;
always @*
    case(s)
        0: ot = i0;
        1: ot = i1;
        2: ot = i2;
        3: ot = i3;
        4: ot = i4;
        5: ot = i5;
        6: ot = i6;
        7: ot = i7;
        8: ot = i8;
        9: ot = i9;
        10: ot = i10;
        11: ot = i11; 
    endcase
endmodule
