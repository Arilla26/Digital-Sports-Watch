`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2024 01:02:18 AM
// Design Name: 
// Module Name: Dem_4bit
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


module Dem_4bit(
    input   ckht,ena1khz,
    output  [3:0] q
    );
    
reg [3:0] q_r, q_n;
//State register
always @(negedge ckht)
    q_r <= q_n;
//Next state logic
always @*
    if(ena1khz)begin
        if(q_r == 11)
            q_n = 4'b0000;
        else
            q_n = q_r +1;
    end
    else begin
        q_n = q_r;
    end
//Output logic
assign q = q_r;
endmodule
