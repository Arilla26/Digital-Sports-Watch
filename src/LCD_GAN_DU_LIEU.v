`timescale 1ns / 1ps

module LCD_GAN_DU_LIEU (
  input  wire save,
  input  wire [159:0] lcd_data,
  output wire [159:0] lcd_h0,
  output wire [159:0] lcd_h1,
  output wire [159:0] lcd_h2,
  output wire [159:0] lcd_h3  
);
  
  reg [159:0] lcd_h0r;
  reg [159:0] lcd_h1r;
  reg [159:0] lcd_h2r;
  reg [159:0] lcd_h3r;


  always @(posedge save) 
  begin
    if (save) 
        begin
          lcd_h1r <= lcd_h2r;
          lcd_h2r <= lcd_h3r;
          lcd_h3r <= lcd_data;
        end
  end
  
  assign lcd_h0 = "  Dong Ho The Thao  "; 
  assign lcd_h1 = lcd_h1r;
  assign lcd_h2 = lcd_h2r;
  assign lcd_h3 = lcd_h3r;
  

endmodule
