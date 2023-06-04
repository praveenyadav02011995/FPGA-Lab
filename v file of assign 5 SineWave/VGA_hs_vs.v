`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:49:31 10/12/2011 
// Design Name: 
// Module Name:    VGA_hs_vs 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module VGA_hs_vs
(
	mclk, start, hs, vs, hc, vc, vidon  
);

input mclk, start;

output reg hs, vs;

output reg vidon;											 //Tells whether or not its ok to display data
output reg [9:0] hc = 10'd0, vc=10'd0;			    //These are the Horizontal and Vertical counters

	parameter [9:0] hpixels = 10'b1100100000;	 //Value of pixels in a horizontal line (800)
	parameter [9:0] vlines	= 10'b1000001001;	 //Number of horizontal lines in the display (521)
	
	parameter [9:0] hbp     = 10'b0010010000;	 //Horizontal back porch (72)
	parameter [9:0] hfp		= 10'b1100010000;	 //Horizontal front porch (784)
	parameter [9:0] vbp		= 10'b0000011111;	 //Vertical back porch (31)
	parameter [9:0] vfp		= 10'b0111111111;	 //Vertical front porch (511)
	
	reg clkdiv ;											 //Clock divider
	reg vsenable;										 //Enable for the Vertical counter



  always@(posedge mclk)
		begin
				if(!start)
					clkdiv <=  ! clkdiv;  //25MHz clock
				else
					clkdiv <= 1'b0;
		end 
		
		
		//Runs the horizontal counter
  always@(posedge clkdiv)
		begin
				if (hc == hpixels) 				//If the counter has reached the end of pixel count
					begin
						hc <= 10'b0000000000;							//reset the counter
						vsenable <= 1'b1;								//Enable the vertical counter to increment
					end
				else
					begin
						hc <= hc + 1;									//Increment the horizontal counter
						vsenable <= 1'b0;								//Leave the vsenable off
					end	
				
				if(hc[9:7] == 3'b000)								      //Horizontal Sync Pulse
		          hs <= 1'b1;
			   else
				    hs <= 1'b0;
		     
		end 
		
	always@(posedge clkdiv)
	begin
		if(vsenable == 1'b1) 		                        //Increment when enabled
			begin 
				if ( vc == vlines) 					//Reset when the number of lines is reached
					vc <= 10'b0000000000;
				else 
					vc <= vc + 1;										//Increment the vertical counter
			end 
		else
			vc <= vc;
	
		if(vc[9:1] == 9'b000000000)									 //Vertical Sync Pulse
			vs <= 1'b1;
		else
			vs <= 1'b0;

	end 

  always@(posedge clkdiv)
	begin
		if(((hc < hfp) && (hc > hbp)) || ((vc < vfp) && (vc > vbp))) 	    //Enable video out when within the porches
         	vidon <= 1'b1;
		else
				vidon <= 1'b0;
	
	
	
	end


endmodule 