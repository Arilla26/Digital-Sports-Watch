`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2024 06:23:31 PM
// Design Name: 
// Module Name: Dong_ho_the_thao
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


module Dong_ho_the_thao(
    input ckht,
    input   [5:0] btn,
    input   [1:0] sw,
    output  [7:0] sseg,
    output   [11:0] cathode,
    output [7:0] lcd_db,
    output lcd_rs,
    output lcd_e,
    output lcd_p
    );
    
wire rst, ena1khz, ena1hz, ena2hz;
wire ena5hz, ena20hz,ena50hz,ena100hz;

reg ena_db;

wire [11:0] dc_12led;
wire [11:0] ena_12led;

wire [6:0] gio, phut, giay, ptgiay;
wire [3:0] ch_gio, dv_gio;
wire [3:0] ch_phut, dv_phut;
wire [3:0] ch_giay, dv_giay;
wire [3:0] ch_ptgiay, dv_ptgiay;

wire [159:0] lcd_data;

assign rst = btn[0];

always @*
    case(sw)
        2'b00: ena_db = ena1hz;
        2'b01: ena_db = ena20hz;
        2'b10: ena_db = ena50hz;
        2'b11: ena_db = ena100hz;
    endcase

Chia_10ena  IC1 (
        .ckht(ckht),
        .ena1khz(ena1khz),
        .ena1hz(ena1hz),
        .ena2hz(ena2hz),
        .ena5hz(ena5hz),
        .ena20hz(ena20hz),
        .ena50hz(ena50hz),
        .ena100hz(ena100hz)
        );
        
Dem_GPG_NN  IC2 (
        .ckht(ckht),
        .rst(rst),
        .ena_db(ena_db),
        .ena2hz(ena2hz),
        .ena5hz(ena5hz),
        .btn_up(btn[1]),
        .btn_mod(btn[2]),
        .btn_dw(btn[3]),
        .btn_ps(btn[4]),
        .ptgiay(ptgiay),
        .giay(giay),
        .phut(phut),
        .gio(gio),
        .dc12_led(dc_12led),
        .ena_12led(ena_12led)
        );
        
HEXTOBCD_GPGPT IC3 (
        .ptgiay(ptgiay),
        .giay(giay),
        .phut(phut),
        .gio(gio),
        .dv_ptgiay(dv_ptgiay),
        .ch_ptgiay(ch_ptgiay),
        .dv_giay(dv_giay),
        .ch_giay(ch_giay),
        .dv_phut(dv_phut),
        .ch_phut(ch_phut),
        .dv_gio(dv_gio),
        .ch_gio(ch_gio)
        );

Gm_ht_12led     IC4 (
        .ckht(ckht),
        .ena1khz(ena1khz),
        .led70(1),
        .led71(dv_ptgiay),
        .led72(ch_ptgiay),
        .led73(1),
        .led74(dv_giay),
        .led75(ch_ptgiay),
        .led76(1),
        .led77(dv_phut),
        .led78(ch_phut),
        .led79(1),
        .led80(dv_gio),
        .led81(ch_gio),
        .dc_12led(dc_12led),
        .ena_12led(ena_12led),
        .sseg(sseg),
        .cathode(cathode)
        );

LCD_DATA_TRANSFER IC5 (
        .dv_ptgiay(dv_ptgiay),
        .ch_ptgiay(ch_ptgiay),
        .dv_giay(dv_giay),
        .ch_giay(ch_giay),
        .dv_phut(dv_phut),
        .ch_phut(ch_phut),
        .dv_gio(dv_gio),
        .ch_gio(ch_gio),
        .lcd_data(lcd_data)       
        );
        
LCD_TRANSFER IC6 (
                .lcd_data(lcd_data),
                .rst(rst),
                .save(btn[5]),
                .ckht(ckht),
                .lcd_db(lcd_db),
                .lcd_rs(lcd_rs),
                .lcd_e(lcd_e),
                .lcd_p(lcd_p)       
                );

endmodule
