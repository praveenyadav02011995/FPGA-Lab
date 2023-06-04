// EE20B007 Benstin Davis 
`timescale 1ns / 1ps

module Clock_Divider 
#(
    parameter CYCLES = 4

) 
(
    input clk,
    output reg rclk
);
    

reg [63:0] counter = 0;
initial begin
    rclk <= 0;
end

always @(posedge clk) begin
    counter <= counter + 1;
    if (counter == (CYCLES/2) + 1) begin
        counter <= 0;
        rclk <= ~rclk;
    end
end
    
endmodule