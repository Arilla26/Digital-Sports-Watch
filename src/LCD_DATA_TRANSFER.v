`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2024 01:39:20 PM
// Design Name: 
// Module Name: LCD_DATA_TRANSFER
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


module LCD_DATA_TRANSFER(
  input [3:0] dv_ptgiay,
  input [3:0] ch_ptgiay,
  input [3:0] dv_giay,
  input [3:0] ch_giay,
  input [3:0] dv_phut,
  input [3:0] ch_phut,
  input [3:0] dv_gio,
  input [3:0] ch_gio,
  output [159:0] lcd_data
);

  wire [7:0] padding = 8'h20;
  wire [7:0] dv_ptgiay_ext = {4'd0, dv_ptgiay};
  wire [7:0] ch_ptgiay_ext = {4'd0, ch_ptgiay};
  wire [7:0] dv_giay_ext = {4'd0, dv_giay};
  wire [7:0] ch_giay_ext = {4'd0, ch_giay};
  wire [7:0] dv_phut_ext = {4'd0, dv_phut};
  wire [7:0] ch_phut_ext = {4'd0, ch_phut};
  wire [7:0] dv_gio_ext = {4'd0, dv_gio};
  wire [7:0] ch_gio_ext = {4'd0, ch_gio};
  
  assign lcd_data[7:0]    = padding;
  assign lcd_data[15:8]   = padding;
  assign lcd_data[23:16]  = padding;
  assign lcd_data[31:24]  = padding;
  assign lcd_data[39:32]  = padding;
  assign lcd_data[47:40]  = dv_ptgiay_ext;
  assign lcd_data[55:48]  = ch_ptgiay_ext;
  assign lcd_data[63:56]  = padding;
  assign lcd_data[71:64]  = dv_giay_ext;
  assign lcd_data[79:72]  = ch_giay_ext;
  assign lcd_data[87:80]  = padding;
  assign lcd_data[95:88]  = dv_phut_ext;
  assign lcd_data[103:96] = ch_phut_ext;
  assign lcd_data[111:104] = padding;
  assign lcd_data[119:112] = dv_gio_ext;  
  assign lcd_data[127:120] = ch_gio_ext;
  assign lcd_data[135:128] = padding;
  assign lcd_data[143:136] = padding;
  assign lcd_data[151:144] = padding;
  assign lcd_data[159:152] = padding;
  
endmodule
