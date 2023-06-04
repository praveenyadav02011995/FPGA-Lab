`timescale 1ns / 1ps

module Top (input clk,
            input echo,
            output [7:0] Seven_Seg,
            output [3:0] digit,
            output trig,
            output [12:0] dis
            );
    
    wire [12:0] distance;
    reg [12:0] disp_in;
    
    assign dis = distance;
    UltraSonicSensor S0 (clk,echo,distance,trig);
    
    DisplayController D0 (clk,disp_in,Seven_Seg,digit);
    
    always @(posedge clk ) begin
        disp_in <= distance;
    end

endmodule
