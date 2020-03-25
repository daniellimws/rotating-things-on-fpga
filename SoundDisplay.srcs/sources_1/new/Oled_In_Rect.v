`timescale 1ns / 1ps

module Oled_In_Rect(
    input on, 
    input [6:0] rect_x, rect_width,
    input [5:0] rect_y, rect_height,
    input [12:0] pixel_index,
    output inside);
    
    localparam Width = 96;
    localparam Height = 64;
    wire [6:0] pixel_x;
    wire [5:0] pixel_y;
    assign pixel_x = pixel_index % Width;
    assign pixel_y = pixel_index / Width;
    
    assign inside = on && (pixel_x >= rect_x && pixel_x < (rect_x + rect_width)) && (pixel_y >= rect_y && pixel_y < (rect_y + rect_height));

endmodule