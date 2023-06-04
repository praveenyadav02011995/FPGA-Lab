`timescale 1ns / 1ps


module UltraSonicSensor
(
    input clk,
    input echo,
    output [12:0] distance,
    output trig
);

parameter MEASURE_CYCLE = 12500000; // Measures every 250ms 
parameter TRIGGER_LENGTH = 500;    // Pulse of TRIGGER_LENGTH*20ns

wire clk_100ms;

Clock_Divider #(.CYCLES(MEASURE_CYCLE)) CLK_1 (clk,clk_100ms);
Pulse_Generator #(.PULSE_LENGTH(TRIGGER_LENGTH)) PULSE_0 (clk,clk_100ms,trig);
Pulse_Length PULSE_LENGTH (clk,trig,echo,distance);

endmodule
