module sine_wave_from_CORDIC
(   
    mclk,
    start,
    hc,
    vc,
    vidon,
    red,
    grn,
    blu
);
input mclk, start;
reg [7:0]sine_wave;
input [9:0]hc, vc;
input vidon;
output reg red, grn, blu;
reg start_cr;
reg [15:0]angle;
wire [7:0] sint; //2.6
wire done;
reg stop;
parameter N = 64;
parameter M = 128;
reg [8:0]count;
reg [9:0] ref_h_pix ; // starting reference horizontal pixel value -- 72 < ref_h_pix < 784
reg [9:0] ref_v_pix ; // starting reference vertical pixel value --31 < ref_v_pix < 511
reg [N-1:0]lcd_pixel[0:M-1];
reg [N-1:0]temp;
reg [N-1:0]temp2;
reg [7:0]temp1;
reg start1;
CORDIC_sine crd1(mclk, start_cr, angle, sint, done);
// 1 degree = 1 * pi/180 = 00.00_0001_0001_1110 = 011E
always@(negedge mclk)
begin
    if (start) begin
        start_cr = 1;
        angle    = 16'h0000;
        count    = 8'd0;
        stop     = 1'b0;
        start1   = 1'b1;
        end 
    else begin
        if (done == 1'b1) begin
            if (count <= 9'd15) begin
                angle     = angle + 16'h06B4; // 6 degrees
                count     = count + 1'b1;
                sine_wave = 8'h80 + sint;
                stop      = 1'b0;
            end
            else if (count > 9'd15 && count <= 9'd31) begin
                angle     = angle - 16'h06B4;
                count     = count + 1'b1;
                sine_wave = 8'h80 + sint;
                stop      = 1'b0;
            end
            else if (count > 9'd31 && count <= 9'd47)begin
                angle     = angle - 16'h06B4;
                count     = count + 1'b1;
                sine_wave = 8'h80 - sint;
                stop      = 1'b0;
            end
            else if (count > 9'd47 && count < 9'd64)begin
                angle     = angle + 16'h06B4;
                count     = count + 1'b1;
                sine_wave = 8'h80 - sint;
                stop      = 1'b0;
            end
            else begin
                angle  = 16'h0000;
                stop   = 1'b1;
                start1 = 1'b0;
            end
            // converting sine wave values into an ‘image'
            // lcd_pixel is a two-dimensional binary matrix which
            // contains information on the pixel that needs to ‘glow'
            // a sample matrix is shown at the end of this handout
            temp                      = lcd_pixel[sine_wave[7:1]];
            temp[64-count]            = 1'b1;
            lcd_pixel[sine_wave[7:1]] = temp;
            start_cr                  = 1'b1;
        end
        else begin
            if (stop)
                start_cr = 1'b1;
            else
                start_cr = 1'b0;
        end
    end
end
// starting reference horizontal pixel value -- 72 < ref_h_pix < 784
// starting reference vertical pixel value --31 < ref_v_pix < 511
// Use arguments hc (horizontal count), vc (vertical count), vidon of VGA_hs_vs module below for
// display of value
always@(posedge mclk)
begin
if (start1)
begin
    ref_h_pix = 10'd 256; // reference values as a power of 2
    ref_v_pix = 10'd 128;
end
else if (vidon)
begin
    if ((hc>ref_h_pix)&&(hc < ref_h_pix + 128) && (vc>ref_v_pix)&&(vc < ref_v_pix + 64))
    begin
        temp2 = lcd_pixel[vc[6:0]];
        if (temp2[hc[5:0]] == 1'b1)
            grn      = 1;
            else grn = 0;
            end
        else begin
            grn = 0;
        end
        // Creating Horizontal and Vertical lines
        if ((hc == ref_h_pix) || (vc == ref_v_pix + 64))
            blu = 1;
        else
            blu = 0;
            red = 1;
    end
    else
    begin
    grn = 0;
    blu = 0;
    red = 0;
end
end
endmodule
