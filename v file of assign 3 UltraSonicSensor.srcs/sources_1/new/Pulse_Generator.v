`timescale 1ns / 1ps

module Pulse_Generator
#(
    parameter PULSE_LENGTH = 10 // In multiples of 20ns(1/50Mhz)
)
(
    input clk,
    input trig,
    output reg pulse
);

reg [63:0] counter = 0;

always @(posedge clk) begin
    if(trig) begin
        if (counter < PULSE_LENGTH) begin        
            pulse <= 1;
            counter <= counter + 1; 
        end
        else begin
            pulse <= 0;
        end
    end
    else begin
        counter <= 0;
    end
end
endmodule
