// EE20B007 Benstin Davis D
`timescale 1ns / 1ps
module BinToBCD (
    input [12:0]in,
    output [15:0]out
);

reg [28:0]sh;
reg [3:0]i;
wire [12:0]sin;
wire s;

assign s = in[12];
assign out = sh[28:13];
assign sin = in[12]?~(in-1):in;

always @(*) begin
    sh = {{(16){1'b0}},s?sin:in};
    for(i = 0;i < 12;i = i + 1)begin
        sh = sh<<1;
        if(sh[28:25] > 4)begin
            sh[28:25] = sh[28:25] + 4'b0011;
        end
        if(sh[24:21] > 4)begin
            sh[24:21] = sh[24:21] + 4'b0011;
        end
        
        if(sh[20:17] > 4)begin
            sh[20:17] = sh[20:17] + 4'b0011;
        end
        
        if(sh[16:13] > 4)begin
            sh[16:13] = sh[16:13] + 4'b0011;
        end
        $display("%b",sh);
    end
    sh = sh<<1;
end

endmodule