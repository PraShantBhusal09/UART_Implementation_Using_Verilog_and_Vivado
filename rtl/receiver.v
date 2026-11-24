`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2026 10:53:46 PM
// Design Name: 
// Module Name: receiver
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


module receiver(
    input clk,
    input rst,
    input rx,
    input rdy_clr,
    input rx_enb,
    output reg [7:0] data_out,
    output reg rdy
);

parameter start_state = 2'b00;
parameter data_out_state = 2'b01;
parameter stop_state = 2'b10;

reg [1:0] state = start_state;
reg [3:0] sample = 0;
reg [2:0] index = 0;
reg [7:0] temp_register = 0;

always @(posedge clk)
begin
    if(rst)
    begin
        rdy <= 0;
        data_out <= 0;
        state <= start_state;
        sample <= 0;
        index <= 0;
        temp_register <= 0;
    end
    else
    begin

        if(rdy_clr)
            rdy <= 0;

        if(rx_enb)
        begin
            case(state)

            start_state:
            begin
                if(rx == 0)
                    sample <= sample + 1'b1;

                if(sample == 7)
                begin
                    state <= data_out_state;
                    index <= 0;
                    sample <= 0;
                    temp_register <= 0;
                end
            end

            data_out_state:
            begin
                sample <= sample + 1'b1;

                if(sample == 15)
                begin
                    temp_register[index] <= rx;
                    sample <= 0;

                    if(index == 7)
                    begin
                        state <= stop_state;
                    end
                    else
                    begin
                        index <= index + 1'b1;
                    end
                end
            end

            stop_state:
            begin
                sample <= sample + 1'b1;

                if(sample == 15)
                begin
                    state <= start_state;
                    data_out <= temp_register;
                    rdy <= 1'b1;
                    sample <= 0;
                end
            end

            default:
            begin
                state <= start_state;
            end

            endcase
        end
    end
end

endmodule
