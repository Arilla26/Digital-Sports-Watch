`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2024 12:18:18 AM
// Design Name: 
// Module Name: Gm_ht_12led
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


module Gm_ht_12led(
    input   ckht,ena1khz,
    input   [3:0] led70, led71, led72, led73,
    input   [3:0] led74, led75, led76, led77,
    input   [3:0] led78, led79, led80, led81,
    input   [11:0] dc_12led,
    input   [11:0] ena_12led,
    output  [7:0] sseg,
    output  [11:0] cathode 
    );
    
wire [3:0] s4b;
wire [3:0] so_gma;
wire dc_1led;
wire ena_1led;

Dem_4bit    K1  (
            .ckht(ckht),
            .ena1khz(ena1khz),
            .q(s4b)
            );
            
Dahop_12kenh    K2  (
            .i0(led70),
            .i1(led71),
            .i2(led72),
            .i3(led73),
            .i4(led74),
            .i5(led75),
            .i6(led76),
            .i7(led77),
            .i8(led78),
            .i9(led79),
            .i10(led80),
            .i11(led81),
            .o(so_gma),
            .s(s4b)
            );

Dahop_12ena     K3  (
            .i0(ena_12led[0]),
            .i1(ena_12led[1]),
            .i2(ena_12led[2]),
            .i3(ena_12led[3]),
            .i4(ena_12led[4]),
            .i5(ena_12led[5]),
            .i6(ena_12led[6]),
            .i7(ena_12led[7]),
            .i8(ena_12led[8]),
            .i9(ena_12led[9]),
            .i10(ena_12led[10]),
            .i11(ena_12led[11]),
            .o(ena_1led),
            .s(s4b)
            );
            
Dahop_12dc      K4  (
            .i0(dc_12led[0]),
            .i1(dc_12led[1]),
            .i2(dc_12led[2]),
            .i3(dc_12led[3]),
            .i4(dc_12led[4]),
            .i5(dc_12led[5]),
            .i6(dc_12led[6]),
            .i7(dc_12led[7]),
            .i8(dc_12led[8]),
            .i9(dc_12led[9]),
            .i10(dc_12led[10]),
            .i11(dc_12led[11]),
            .o(dc_1led),
            .s(s4b)
            );            

Giaima_48h      K5  (
            .i(s4b),
            .o(cathode)
            );
            
Giaima_7doan_ena_dp K6  (
            .so_gma(so_gma),
            .sseg(sseg),
            .ena(ena_1led),
            .dp(dc_1led)
            );           

endmodule
