`timescale 1ns / 1ps

module Pulse_Length 
(
    input clk,             //20 ns
    input reset,
    input pulse,
    output [12:0] length
);
    

reg[63:0] counter = 0;
wire rclk;

Clock_Divider #(.CYCLES(292)) C0 (clk,rclk);

assign length = counter; 

always @(posedge rclk or posedge reset)begin
    if (reset) begin
        counter <= 0;
    end
    else if (pulse) begin
        counter <= counter + 1;
    end
end

endmodule
