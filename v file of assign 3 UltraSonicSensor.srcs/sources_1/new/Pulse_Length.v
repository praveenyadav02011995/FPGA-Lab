`timescale 1ns / 1ps

module Pulse_Length 
(
    input clk,             //20 ns
    input reset,
    input pulse,
    output [9:0] length
);
    
parameter FACTOR = 32'd1473174;

reg[63:0] counter = 0;

            
assign length = (counter * FACTOR)>>>32; 

always @(posedge clk)begin
    if (reset) begin
        counter <= 0;
    end
    if (pulse) begin
        counter <= counter + 1;
    end
end

endmodule
