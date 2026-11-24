`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2026 10:54:26 PM
// Design Name: 
// Module Name: uart_top
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


module uart_top(
    input clk,
    input rst,
    input wr_en,
    input rx,
    input rdy_clr,
    input [7:0] data_in,

    output tx,
    output busy,
    output rdy,
    output [7:0] data_out
);

wire tx_enb;
wire rx_enb;

baud_rate_generator bg(
    .clk(clk),
    .rst(rst),
    .tx_enb(tx_enb),
    .rx_enb(rx_enb)
);

transmitter ts(
    .clk(clk),
    .wr_en(wr_en),
    .tx_enb(tx_enb),
    .rst(rst),
    .data_in(data_in),
    .tx(tx),
    .busy(busy)
);

receiver rs(
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .rdy_clr(rdy_clr),
    .rx_enb(rx_enb),
    .data_out(data_out),
    .rdy(rdy)
);

endmodule
