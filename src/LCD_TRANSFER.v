`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2024 12:50:27 PM
// Design Name: 
// Module Name: LCD_TRANSFER
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

module LCD_TRANSFER(
    input [159:0] lcd_data,
    input rst,
    input save,
    input ckht,
    output [7:0] lcd_db,
    output lcd_rs,
    output lcd_e,
    output lcd_p
);


wire [159:0] lcd_h0;
wire [159:0] lcd_h1;
wire [159:0] lcd_h2;
wire [159:0] lcd_h3;

wire cdb_save;

assign lcd_p = 1;

Debounce_btn K0 (
                .btn(save),
                .ckht(ckht),
                .db_tick(cdb_save)
                );

LCD_GAN_DU_LIEU K1 ( .save(cdb_save),
                     .lcd_data(lcd_data),
                     .lcd_h0(lcd_h0),
                     .lcd_h1(lcd_h1),
                     .lcd_h2(lcd_h2),
                     .lcd_h3(lcd_h3)
                    );

LCD_HIENTHI     K2 ( .ckht(ckht),
                     .rst(rst),
                     .lcd_h0(lcd_h0),
                     .lcd_h1(lcd_h1),
                     .lcd_h2(lcd_h2),
                     .lcd_h3(lcd_h3),
                     .lcd_rs(lcd_rs),
                     .lcd_e(lcd_e),
                     .lcd_db(lcd_db)                        
                    );                   
       

endmodule
