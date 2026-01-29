`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 11:24:54 AM
// Design Name: 
// Module Name: Chia_10
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


module Chia_10(
    input ckht,
    output  ena2hz, ena5hz, ena1hz, ena20hz,
    output  ena50hz, ena100hz, ena1khz
    );
    
integer d2hz_r, d2hz_n;  
integer d5hz_r, d5hz_n;  
integer d1hz_r, d1hz_n;  
integer d20hz_r, d20hz_n;  
integer d50hz_r, d50hz_n;  
integer d100hz_r, d100hz_n;  
integer d1khz_r, d1khz_n;  

parameter N = 50000000;
initial
    begin
    d2hz_n = 0; d2hz_r = 0;
    d5hz_n = 0; d5hz_r = 0;
    d1hz_n = 0; d1hz_r = 0;
    d20hz_n = 0; d20hz_r = 0;
    d50hz_n = 0; d50hz_r = 0;
    d100hz_n = 0; d100hz_r = 0;
    d1khz_n = 0; d1khz_r = 0;
    end
    
//state register
always @(negedge ckht)
    begin
        d2hz_r = d2hz_n;
        d5hz_r = d5hz_n;
        d1hz_r = d1hz_n;
        d20hz_r = d20hz_n;
        d50hz_r = d50hz_n;
        d100hz_r = d100hz_n;
        d1khz_r = d1khz_n;    
    end
 
always @* 
    begin
        d1hz_n = d1hz_r;
        if(d1hz_r == N-1)   d1hz_n = 0;
        else
            d1hz_n = d1hz_r +1;
//2hz
        d2hz_n = d2hz_r;
        if(d2hz_r == N/2 -1)    d2hz_n = 0;
        else
            d2hz_n = d2hz_r +1;
//5hz
        d5hz_n = d5hz_r;
        if(d5hz_r == N/5 -1)    d5hz_n = 0;
        else
            d5hz_n = d5hz_r +1;
//20hz
        d20hz_n = d20hz_r;
        if(d20hz_r == N/20 -1)    d20hz_n = 0;
        else
             d20hz_n = d20hz_r +1;
//50hz
        d50hz_n = d50hz_r;
        if(d50hz_r == N/50 -1)    d50hz_n = 0;
        else
            d50hz_n = d50hz_r +1;
//100hz
         d100hz_n = d100hz_r;
         if(d100hz_r == N/100 -1)    d100hz_n = 0;
         else
             d100hz_n = d100hz_r +1;              
 //1khz
         d1khz_n = d1khz_r;
         if(d1khz_r == N/1000 -1)    d1khz_n = 0;
         else
             d1khz_n = d1khz_r +1;   
    end
    
//output logic
assign ena1hz = (d1hz_r == N/2) ? 1'b1: 1'b0;
assign ena2hz = (d1hz_r == N/(2*2)) ? 1'b1: 1'b0;
assign ena5hz = (d1hz_r == N/(2*5)) ? 1'b1: 1'b0;
assign ena20hz = (d1hz_r == N/(2*20)) ? 1'b1: 1'b0;
assign ena50hz = (d1hz_r == N/(2*50)) ? 1'b1: 1'b0;
assign ena100hz = (d1hz_r == N/(2*100)) ? 1'b1: 1'b0;
assign ena1khz = (d1hz_r == N/(2*1000)) ? 1'b1: 1'b0;
endmodule
