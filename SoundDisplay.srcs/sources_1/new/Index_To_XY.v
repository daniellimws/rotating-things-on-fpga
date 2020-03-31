`timescale 1ns / 1ps

module Index_To_XY(
    input [12:0] pixel_index,
    output [6:0] pixel_x,
    output [5:0] pixel_y);
    
    localparam Width = 96;
    localparam Height = 64;
    assign pixel_x = pixel_index % Width;
    assign pixel_y = pixel_index / Width;

endmodule