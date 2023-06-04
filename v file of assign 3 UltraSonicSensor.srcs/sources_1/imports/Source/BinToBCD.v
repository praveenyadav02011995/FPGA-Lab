// EE20B007 Benstin Davis D
`timescale 1ns / 1ps
module BinToBCD (
    input [9:0]in,
    output [15:0]out
);

reg [25:0]sh;
reg [3:0]i;
wire [9:0]sin;
wire s;

assign s = in[9];
assign out = sh[25:10];
assign sin = in[9]?~(in-1):in;

always @(*) begin
    sh = {{(16){1'b0}},s?sin:in};
    for(i = 0;i < 9;i = i + 1)begin
        sh = sh<<1;
        if(sh[25:22] > 4)begin
            sh[25:22] = sh[25:22] + 4'b0011;
        end
        if(sh[21:18] > 4)begin
            sh[21:18] = sh[21:18] + 4'b0011;
        end
        
        if(sh[17:14] > 4)begin
            sh[17:14] = sh[17:14] + 4'b0011;
        end
        
        if(sh[13:10] > 4)begin
            sh[13:10] = sh[13:10] + 4'b0011;
        end
        $display("%b",sh);
    end
    sh = sh<<1;
end

endmodule