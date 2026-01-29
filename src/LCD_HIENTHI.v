`timescale 1ns / 1ps

module LCD_HIENTHI(
    input ckht,rst,
    input [159:0] lcd_h0,
    input [159:0] lcd_h1,
    input [159:0] lcd_h2,
    input [159:0] lcd_h3,
    output lcd_rs, lcd_e,
    output [7:0] lcd_db
    );

parameter [3:0]
LCD_INITIAL = 4'b0000,
LCD_ADDR_L0 = 4'b0001,
LCD_DATA_L0 = 4'b0010,    
LCD_ADDR_L1 = 4'b0011,
LCD_DATA_L1 = 4'b0100,
LCD_ADDR_L2 = 4'b0101,
LCD_DATA_L2 = 4'b0110,    
LCD_ADDR_L3 = 4'b0111,
LCD_DATA_L3 = 4'b1000,
LCD_STOP    = 4'b1001;

wire [7:0] lcd_h0b[0:19];
wire [7:0] lcd_h1b[0:19];
wire [7:0] lcd_h2b[0:19];
wire [7:0] lcd_h3b[0:19];

reg [3:0] state;
reg [19:0] slx;
reg [4:0] ptr;

reg lcd_rsr;
reg lcd_er;
reg [7:0] lcd_dbr;

wire [7:0] lcd_cmd [0:5];

assign lcd_e = lcd_er;
assign lcd_rs = lcd_rsr;
assign lcd_db = lcd_dbr;

assign lcd_cmd[0] = 8'h00;
assign lcd_cmd[1] = 8'h3c;  
assign lcd_cmd[2] = 8'h0c;
assign lcd_cmd[3] = 8'h01;  
assign lcd_cmd[4] = 8'h02;  
assign lcd_cmd[5] = 8'h06;

generate
genvar i;
for (i = 1; i < 21; i = i+1)
    begin: for_name
        assign lcd_h0b[20-i] = lcd_h0[i*8-1:i*8-8];
        assign lcd_h1b[20-i] = lcd_h1[i*8-1:i*8-8];
        assign lcd_h2b[20-i] = lcd_h2[i*8-1:i*8-8];
        assign lcd_h3b[20-i] = lcd_h3[i*8-1:i*8-8];
    end
endgenerate

always @(negedge ckht)
if (rst)
    begin
        state = LCD_INITIAL;
        slx   = 0;
        ptr   = 0;
        lcd_er = 1'b0;
        lcd_rsr = 1'b0;
        lcd_dbr = 8'h00;
    end
else
    case (state)
        LCD_INITIAL:
            begin
                slx = slx+1;
                lcd_dbr = lcd_cmd[ptr];
                lcd_rsr = 1'b0;
                if (slx == 10) lcd_er = 1'b1;
                else if (slx == 30) lcd_er = 1'b0;
                else if (slx == 164000)
                    begin
                        slx = 0;
                        if (ptr == 5) state = LCD_ADDR_L0;
                        else ptr = ptr + 1;
                    end  
            end
        LCD_ADDR_L0:
            begin
                slx = slx+1;
                lcd_dbr = 8'h80;
                lcd_rsr = 1'b0;
                if (slx == 10) lcd_er = 1'b1;
                else if (slx == 30) lcd_er = 1'b0;
                else if (slx == 5000)
                    begin
                        slx = 0;
                        ptr = 0; 
                        state = LCD_DATA_L0;
                    end  
            end
        LCD_DATA_L0:
            begin
                slx = slx+1;
                lcd_dbr = lcd_h0b[ptr];
                lcd_rsr = 1'b1;
                if (slx == 10) lcd_er = 1'b1;
                else if (slx == 30) lcd_er = 1'b0;
                else if (slx == 5000)
                    begin
                        slx = 0;
                        if (ptr == 19) state = LCD_ADDR_L1;
                        else ptr = ptr + 1;
                    end  
            end
        LCD_ADDR_L1:
            begin
                slx = slx+1;
                lcd_dbr = 8'hc0;
                lcd_rsr = 1'b0;
                if (slx == 10) lcd_er = 1'b1;
                else if (slx == 30) lcd_er = 1'b0;
                else if (slx == 5000)
                    begin
                        slx = 0;
                        ptr = 0; 
                        state = LCD_DATA_L1;
                    end  
            end
         LCD_DATA_L1:
            begin
                slx = slx+1;
                lcd_dbr = lcd_h1b[ptr];
                lcd_rsr = 1'b1;
                if (slx == 10) lcd_er = 1'b1;
                else if (slx == 30) lcd_er = 1'b0;
                else if (slx == 5000)
                    begin
                        slx = 0;
                        if (ptr == 19) state = LCD_ADDR_L2;
                        else ptr = ptr + 1;
                    end  
            end  
         LCD_ADDR_L2:
            begin
                slx = slx+1;
                lcd_dbr = 8'h94;
                lcd_rsr = 1'b0;
                if (slx == 10) lcd_er = 1'b1;
                else if (slx == 30) lcd_er = 1'b0;
                else if (slx == 5000)
                    begin
                        slx = 0;
                        ptr = 0; 
                        state = LCD_DATA_L2;
                    end  
            end
         LCD_DATA_L2:
            begin
                slx = slx+1;
                lcd_dbr = lcd_h2b[ptr];
                lcd_rsr = 1'b1;
                if (slx == 10) lcd_er = 1'b1;
                else if (slx == 30) lcd_er = 1'b0;
                else if (slx == 5000)
                    begin
                        slx = 0;
                        if (ptr == 19) state = LCD_ADDR_L3;
                        else ptr = ptr + 1;
                    end  
            end
         LCD_ADDR_L3:
            begin
                slx = slx+1;
                lcd_dbr = 8'hd4;
                lcd_rsr = 1'b0;
                if (slx == 10) lcd_er = 1'b1;
                else if (slx == 30) lcd_er = 1'b0;
                else if (slx == 5000)
                    begin
                        slx = 0;
                        ptr = 0; 
                        state = LCD_DATA_L3;
                    end  
            end
         LCD_DATA_L3:
            begin
                slx = slx+1;
                lcd_dbr = lcd_h3b[ptr];
                lcd_rsr = 1'b1;
                if (slx == 10) lcd_er = 1'b1;
                else if (slx == 30) lcd_er = 1'b0;
                else if (slx == 5000)
                    begin
                        slx = 0;
                        if (ptr == 19) state = LCD_STOP;
                        else ptr = ptr + 1;
                    end  
            end                
         LCD_STOP:
            begin
                slx = slx+1;
                if (slx == 1000000)
                    begin
                        slx = 0;
                        state = LCD_ADDR_L0;
                    end
            end            
     endcase
endmodule