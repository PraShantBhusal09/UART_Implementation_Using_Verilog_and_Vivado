`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2026 10:55:39 PM
// Design Name: 
// Module Name: uart_tb
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


module uart_tb;

reg clk;
reg rst;
reg wr_en;
reg [7:0] data_in;
reg rdy_clr;

wire tx;
wire rx;
wire busy;
wire rdy;
wire [7:0] data_out;

uart_top uut(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rx(rx),
    .rdy_clr(rdy_clr),
    .data_in(data_in),
    .tx(tx),
    .busy(busy),
    .rdy(rdy),
    .data_out(data_out)
);

assign rx = tx;

initial
begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial
begin

    rst = 1;
    wr_en = 0;
    data_in = 8'h00;
    rdy_clr = 0;

    #100;
    rst = 0;

    #100;
    data_in = 8'h41;
    wr_en = 1;

    #20;
    wr_en = 0;

    wait(rdy == 1);

    $display("Received data is %h", data_out);

    if(data_out == 8'h41)
        $display("FIRST TEST PASSED");
    else
        $display("FIRST TEST FAILED");

    #40;
    rdy_clr = 1;

    #20;
    rdy_clr = 0;

    
    #100;
    data_in = 8'h55;
    wr_en = 1;

    #20;
    wr_en = 0;

    wait(rdy == 1);

    $display("Received data is %h", data_out);

    if(data_out == 8'h55)
        $display("SECOND TEST PASSED");
    else
        $display("SECOND TEST FAILED");

   #200000;
    $finish;

end


initial
begin
    #5000000;
    $display("Simulation Timeout");
    $finish;
end

endmodule
