`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 10:38:12 AM
// Design Name: 
// Module Name: Chia_10ena
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


module Chia_10ena(
    input   ckht,
    input   [1:0] sw,
    output  ena2hz, ena5hz, ena1khz, ena_db
    );

wire ena1hz;
wire ena20hz;
wire ena50hz;
wire ena100hz;
    
Chia_10     IIC (
            .ckht(ckht),
            .ena2hz(ena2hz),
            .ena5hz(ena5hz),
            .ena1khz(ena1khz),
            .ena1hz(ena1hz),
            .ena20hz(ena20hz),
            .ena50hz(ena50hz),
            .ena100hz(ena100hz)
            );

Dahop_4kenh_1bit    IIC2    (
            .ena1hz(ena1hz),
            .ena20hz(ena20hz),
            .ena50hz(ena50hz),
            .ena100hz(ena100hz),
            .sw(sw[1:0])
            );
endmodule
