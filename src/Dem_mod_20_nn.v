`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 01:55:36 PM
// Design Name: 
// Module Name: Dem_mod_20_nn
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


module Dem_mod_20_nn(
    input   ckht, rst, cdb_up, cdb_dw, ena2hz,
    input   [1:0] gt_mod,
    output  [4:0] q,
    output  [11:0] ena_12led
    );
    
reg [4:0]   q_r, q_n;
reg [11:0]  ena_r, ena_n;

initial ena_r = 12'b111111111111;
    
//state register
 always @(negedge ckht)
    if(rst)
        begin
            q_r = 0;  
            ena_r = 12'b110110110110;
        end
    else
        begin
            q_r = q_n;
            ena_r = ena_n;
        end


//next state logic
always @*
    begin
        ena_n = ena_r;
        q_n = q_r;
        if(gt_mod == 2'b01)
            if((cdb_up == 0)&&(cdb_dw == 0))
                begin
                    if(ena2hz)
                        begin
                            ena_n[5:4] = ~ena_r[5:4];
                            q_n = q_r +1;
                        end
                end
            else
                begin
                    ena_n = 12'b110110110110;
                    q_n = 0;
                end
        else if(gt_mod == 2'b10)
            if((cdb_up == 0)&&(cdb_dw == 0))
                begin
                    if(ena2hz)
                        begin
                            ena_n[8:7] = ~ena_r[8:7];
                            q_n = q_r +1;
                        end
                    end
            else
                begin
                    ena_n = 12'b110110110110;
                    q_n = 0;
                end

        else if(gt_mod == 2'b11)
            if((cdb_up == 0)&&(cdb_dw == 0))
                begin
                    if(ena2hz)
                        begin
                            ena_n[11:10] = ~ena_r[11:10];
                            q_n = q_r +1;
                        end
                    end
            else
                begin
                    ena_n = 12'b110110110110;
                    q_n = 0;
                end
        else
            begin
                q_n = 0;
                ena_n = 12'b110110110110;
            end
       end
//output logic
    assign q = q_r;
    assign ena_12led = ena_r;
                                                  
endmodule
