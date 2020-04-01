`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2020 00:40:16
// Design Name: 
// Module Name: max_vol
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module max_volume(input twentyclock, input [11:0] mic_in, output reg [3:0] max_vol);
reg [30:0] slowerclock_count=0;//consider init to 0
//init in for loop

//init to 0 (very first time)
reg [12:0] max_signal_value;


always @ (posedge twentyclock)begin
    slowerclock_count <= slowerclock_count + 1;
    //reset max value at active edge of slowerclock
    if(slowerclock_count >= 5500)begin
        //RESET
        max_signal_value <= 0;
        slowerclock_count <= 0;end
    //update max value at instant when it is largest ever recorded
    if(mic_in>max_signal_value)begin
        //padding of max to 16 bits
        max_signal_value = {4'b0000, mic_in};
    end
    //get max_vol
    if(max_signal_value >= 16'h0000 && max_signal_value<16'h0900)
        max_vol = 0;
    else if(max_signal_value >= 16'h0900 && max_signal_value<16'h0977)
        max_vol = 1;
    else if(max_signal_value >= 16'h0977 && max_signal_value<16'h09EE)
        max_vol = 2;
    else if(max_signal_value >= 16'h09EE && max_signal_value<16'h0A65)
        max_vol = 3;
    else if(max_signal_value >= 16'h0A65 && max_signal_value<16'h0ADC)
        max_vol = 4;
    else if(max_signal_value >= 16'h0ADC && max_signal_value<16'h0B53)
        max_vol = 5;
    else if(max_signal_value >= 16'h0B53 && max_signal_value<16'h0BCA)
        max_vol = 6;
    else if(max_signal_value >= 16'h0BCA && max_signal_value<16'h0C41)
        max_vol = 7;
    else if(max_signal_value >= 16'h0C41 && max_signal_value<16'h0CB8)
        max_vol = 8;
    else if(max_signal_value >= 16'h0CB8 && max_signal_value<16'h0D2F)
        max_vol = 9;
    else if(max_signal_value >= 16'h0D2F && max_signal_value<16'h0DA6)
        max_vol = 10;
    else if(max_signal_value >= 16'h0DA6 && max_signal_value<16'h0E1D)
        max_vol = 11;
    else if(max_signal_value >= 16'h0E1D && max_signal_value<16'h0E94)
        max_vol = 12;
    else if(max_signal_value >= 16'h0E94 && max_signal_value<16'h0F0B)
        max_vol = 13;
    else if(max_signal_value >= 16'h0F0B && max_signal_value<16'h0F82)
        max_vol = 14;
    else if(max_signal_value >= 16'h0F82 && max_signal_value<16'h0FFF)
        max_vol = 15;
    end
endmodule
