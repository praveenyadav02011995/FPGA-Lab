/*
This module is for transmitting 1 byte of data from FPGA to UART
Instructions:
1. Update XDC file
2. Generate Bitstream
3. Program FPGA
4. Make ld_tx_data high for load the data (and then low)
5. After loading the data make tx_enable high (to send the data)
6. Make reset high to reset the UART
*/

module transmiter(
    input clk,          //Connect this to System Clock
    input tx_enable,    //It will transmit the data when tx_enable is 1
    input reset,        //It will reset when posetive edge of reset is triggered
    input ld_tx_data,   //Positive edge of ld_tx_data will load tx_data to the transmitter
    output tx_empty,    //It is high when there is no data to send in the UART
    output tx_out       //This is TX of sender and connect this to RX of receiver
    );

wire [7:0]tx_data = 8'b01101100; //This data wil be send from UART

//--------------------- Uart TX ----------------------------------
wire txclk;
uart_tx_clk clk_tx(clk,txclk);
uart_tx tx(reset,txclk,ld_tx_data,tx_data,tx_enable,tx_out,tx_empty);


endmodule
