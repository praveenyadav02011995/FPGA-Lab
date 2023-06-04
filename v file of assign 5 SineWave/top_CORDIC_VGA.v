module top_CORDIC_VGA(mclk,
                      start,
                      hs,
                      vs,
                      red,
                      grn,
                      blu);
    input mclk, start;
    output hs, vs;
    output red, grn, blu;
    wire [9:0] hc , vc ; // These are the Horizontal and Vertical counters
    wire vidon; // Tells whether or not it is ok to display data
    VGA_hs_vs VHV1 (mclk, start, hs, vs, hc, vc, vidon);
    sine_wave_from_CORDIC SCV1(mclk, start, hc, vc, vidon, red, grn, blu);
endmodule
