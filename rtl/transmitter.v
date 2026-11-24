`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2026 10:53:03 PM
// Design Name: 
// Module Name: transmitter
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


module transmitter(
    input clk,
    input wr_en,
    input tx_enb,
    input rst,
    input [7:0] data_in,
    output reg tx,
    output busy
);

parameter idle_state  = 2'b00;
parameter start_state = 2'b01;
parameter data_state  = 2'b10;
parameter stop_state  = 2'b11;

reg [7:0] data;
reg [2:0] index;
reg [1:0] state = idle_state;

always @(posedge clk)
begin
    if(rst)
        tx <= 1'b1;
end

always @(posedge clk)
begin
    if(rst)
    begin
        state <= idle_state;
        data <= 0;
        index <= 0;
    end
    else
    begin
        case(state)

        idle_state:
        begin
            tx <= 1'b1;

            if(wr_en)
            begin
                state <= start_state;
                data <= data_in;
                index <= 0;
            end
        end

        start_state:
        begin
            if(tx_enb)
            begin
                tx <= 1'b0;
                state <= data_state;
            end
        end

        data_state:
        begin
            if(tx_enb)
            begin
                tx <= data[index];

                if(index == 7)
                    state <= stop_state;
                else
                    index <= index + 1'b1;
            end
        end

        stop_state:
        begin
            if(tx_enb)
            begin
                tx <= 1'b1;
                state <= idle_state;
            end
        end

        default:
        begin
            tx <= 1'b1;
            state <= idle_state;
        end

        endcase
    end
end

assign busy = (state != idle_state);

endmodule
