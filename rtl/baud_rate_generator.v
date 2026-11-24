`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2026 10:52:11 PM
// Design Name: 
// Module Name: baud_rate_generator
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


module baud_rate_generator(
    input clk,
    input rst,
    output reg tx_enb,
    output reg rx_enb
);

reg [12:0] counter_tx;
reg [9:0] counter_rx;

always @(posedge clk)
begin
    if(rst)
    begin
        counter_tx <= 0;
        counter_rx <= 0;
    end
    else
    begin
        if(counter_tx == 5207)
            counter_tx <= 0;
        else
            counter_tx <= counter_tx + 1'b1;

        if(counter_rx == 324)
            counter_rx <= 0;
        else
            counter_rx <= counter_rx + 1'b1;
    end
end

always @(*)
begin
    tx_enb = (counter_tx == 0);
    rx_enb = (counter_rx == 0);
end

endmodule
