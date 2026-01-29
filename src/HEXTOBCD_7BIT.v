`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 11:00:38 AM
// Design Name: 
// Module Name: HEXTOBCD_7BIT
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


module HEXTOBCD_7BIT(
    input  [6:0] sohex7bit,
    output [3:0] chuc, donvi
    );
integer i;
reg [14:0] bcdhex;
always @*
    begin
        bcdhex = {8'b00000000,sohex7bit};
        for (i=0; i<6; i=i+1)
        begin
            bcdhex = {bcdhex[13:0],1'b0};
            if (bcdhex[10:7]>=5)
                bcdhex[10:7]= bcdhex[10:7]+3;
            if (bcdhex[14:11]>=5)
                bcdhex[14:11]= bcdhex[14:11]+3;
        end        
        bcdhex = {bcdhex[13:0], 1'b0};
    end    
    assign chuc  = bcdhex [14:11];
    assign donvi = bcdhex [10:7];
     
endmodule
