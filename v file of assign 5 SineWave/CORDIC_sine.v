// Unscaled sine value generation
module CORDIC_sine
(
    clk,
    start,
    angle,
    sint,
    done
);

input clk, start;
input [15:0] angle; //2 bits for integer and 14 for fractional part
// adequate to consider maximum value of angle for sine as 90 degrees
// angle = 90 * pi/180 = 01.10010010001000 = 16'h6488 (radians)
output reg [7:0] sint; //2 bits integer, 6 bits fraction
output reg done;
reg [15:0]x0, y0; // 2 bits integer, 14 bits fraction
reg [15:0] sx, sy; //2.14
reg [15:0]z0;
reg [15:0]atan; // 2 bits integer, 14 bits fraction
reg d;
reg [4:0]i;
always@(posedge clk)
begin
    if (start) begin // Initialize
        z0   = angle;
        x0   = 16'h4000; // decimal value of 1.000
        y0   = 16'd0;
        i    = 5'd0;
        d    = 1'b0;
        done = 1'b0;
    end
    else begin
        if (i < 5'b10000) begin
            // case module to implement tan^-1(2^-i)
            // Arithmetic right shift of "x0" and "y0"; store in "sx" and "sy" respectively
            // i.e sx = x0 * 2^-i
            // i.e sy = y0 * 2^-i
            // the atan values are stored with 2-bit integer part and 14-bit fractional part
            //tan^-1(2^-0) = 45 degrees = 45 * pi/180 = 00.11_0010_0100_0100 = 16'h3244
            case(i)
                5'd0: begin 
                    atan = 16'h3244; // fill in for tan^-1(2^-0) (in radians)
                    sx = x0;
                    sy = y0 ; 
                end
                5'd1: begin 
                    atan = 16'h1dac; // fill in for tan^-1(2^-1) (in radians)
                    sx = {{1{x0[15]}},x0[15:1] };
                    sy = {{1{y0[15]}}, y0[15:1] }; 
                end
                5'd2: begin 
                    atan = 16'hfae; // fill in for tan^-1(2^-2) (in radians)
                    sx = {{2{x0[15]}}, x0[15:2] };
                    sy = {{2{y0[15]}}, y0[15:2] }; 
                end
                5'd3: begin 
                    atan = 16'h7f5; // extend to other elementary angles
                    sx = {{3{x0[15]}}, x0[15:3] };
                    sy = {{3{y0[15]}}, y0[15:3] };  
                end
                5'd4: begin 
                    atan = 16'h3ff;
                    sx = {{4{x0[15]}}, x0[15:4] };
                    sy = {{4{y0[15]}}, y0[15:4] };  
                end
                5'd5: begin 
                    atan = 16'h200;
                    sx = {{5{x0[15]}}, x0[15:5] };
                    sy = {{5{y0[15]}}, y0[15:5] };  
                end
                5'd6: begin 
                    atan = 16'h100;
                    sx = {{6{x0[15]}}, x0[15:6] };
                    sy = {{6{y0[15]}}, y0[15:6] };  
                end
                5'd7: begin 
                    atan = 16'h80;
                    sx = {{7{x0[15]}}, x0[15:7] };
                    sy = {{7{y0[15]}}, y0[15:7] };  
                end
                5'd8: begin 
                    atan = 16'h40;
                    sx = {{8{x0[15]}}, x0[15:8] };
                    sy = {{8{y0[15]}}, y0[15:8] };  
                end
                5'd9: begin 
                    atan = 16'h20;
                    sx = {{9{x0[15]}}, x0[15:9] };
                    sy = {{9{y0[15]}}, y0[15:9] };  
                end
                5'd10: begin 
                    atan = 16'h10;
                    sx = {{10{x0[15]}}, x0[15:10] };
                    sy = {{10{y0[15]}}, y0[15:10] };  
                end
                5'd11: begin 
                    atan = 16'h8;
                    sx = {{11{x0[15]}}, x0[15:11] };
                    sy = {{11{y0[15]}}, y0[15:11] };  
                end
                5'd12: begin 
                    atan = 16'h4;
                    sx = {{12{x0[15]}}, x0[15:12] };
                    sy = {{12{y0[15]}}, y0[15:12] };  
                end
                5'd13: begin 
                    atan = 16'h2;
                    sx = {{13{x0[15]}}, x0[15:13] };
                    sy = {{13{y0[15]}}, y0[15:13] };  
                end
                5'd14: begin 
                    atan = 16'h1;
                    sx = {{14{x0[15]}}, x0[15:14] };
                    sy = {{14{y0[15]}}, y0[15:14] };  
                end
                5'd15: begin 
                    atan = 16'h0;
                    sx = {{15{x0[15]}}, {x0[15]} };
                    sy = {{15{y0[15]}}, {y0[15]} };  
                end
                default: atan = 16'h0000;
            endcase
            // here d == 0 represents +1 and d == 1 represents -1
            if (d == 1'b0)begin
                x0 = x0 - sy;
                y0 = y0 + sx;
                z0 = z0 - atan;
            end
            else begin
                x0 = x0 + sy;
                y0 = y0 - sx;
                z0 = z0 + atan;
            end
            d    = z0[15];// assume z0 is in 2's compl form ... use msb ..
            done = 1'b0;
            i    = i + 1;
        end
        else begin
            done = 1'b1;
            sint = y0[15:8];
        end
    end
end
endmodule
