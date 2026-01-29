`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 10:03:46 PM
// Design Name: 
// Module Name: Dem_GPG_MUD1
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


module Dem_GPG_MUD1(
    input ckht, rst, ena_db,
    input ena_up, ena_dw, ena_ps, ena5hz,
    input   [1:0] gt_mod,
    output  [6:0] gio,phut,giay,ptgiay
    );
    
reg [6:0] ptgiay_r, ptgiay_n;
reg [6:0] giay_r, giay_n;
reg [6:0] phut_r, phut_n;
reg [6:0] gio_r, gio_n;

//state register
always @(negedge ckht)
    if(rst)
        begin
            ptgiay_r = 0;
            giay_r = 0;
            phut_r = 0;
            gio_r = 0;
        end
    else
        begin
            ptgiay_r = ptgiay_n;
            giay_r = giay_n;
            phut_r = phut_n;
            gio_r = gio_n;
        end
//Next state logic
always @*
    begin
        ptgiay_n = ptgiay_r;
        if(ena_db)
            if(ptgiay_r == 99) ptgiay_n =0;
            else ptgiay_n = ptgiay_r +1;
     end   
always @*
    begin
        giay_n = giay_r;
        if((ena_db)&&(ptgiay_r == 99))
            if(giay_r == 59) giay_n = 0;
            else giay_n = giay_r +1;
        else if((gt_mod == 2'b01)&&(ena5hz))
            if(ena_up)
                if(giay_r == 59) giay_n = 0;
                else giay_n = giay_r +1;
        else if(ena_dw)
            if(giay_r == 0) giay_n = 59;
            else giay_n = giay_r -1;
    end
always @*
    begin
        phut_n = phut_r;
        if((ena_db)&&(ptgiay_r == 99)&&(giay_r == 59))
            if(phut_r == 59) phut_n = 0;
            else phut_n = phut_r +1;           
        else if((gt_mod == 2'b10)&&(ena5hz))
            if(ena_up)
                if(phut_r == 59) phut_n = 0;
                else phut_n = phut_r +1;
            else if(ena_dw)
                if(phut_r == 0) phut_n = 59;
                else phut_n = phut_r -1;
    end
always @*
    begin
        phut_n = phut_r;
        if((ena_db)&&(giay_r == 59)&&(phut_r == 59)&&(ptgiay == 99))
            if(gio_r == 23) gio_n = 0;
            else gio_n = gio_r +1;           
        else if((gt_mod == 2'b11)&&(ena5hz))
            if(ena_up)
                if(gio_r == 23) gio_n = 0;
                else gio_n = gio_r +1;
            else if(ena_dw)
                if(gio_r == 0) gio_n = 59;
                else gio_n = gio_r -1;
    end
//Output logic
    assign ptgiay = giay_r;
    assign giay = giay_r;
    assign phut = phut_r;
    assign gio = gio_r;
           
endmodule
