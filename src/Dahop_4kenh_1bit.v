`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 04:03:35 PM
// Design Name: 
// Module Name: Dahop_4kenh_1bit
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


module Dahop_4kenh_1bit(
    input   ena1hz, ena20hz, ena50hz, ena100hz,
    input   [1:0] sw,
    output  ena_db
    );
    
assign ena_db = (sw == 2'b00) ? ena1hz : (sw == 2'b01) ? ena20hz : (sw == 2'b10) ? ena50hz : ena100hz;   
    
endmodule
