`timescale 1ns / 1ps

module Oled_Border(
    input on, 
    input [1:0] thickness, 
    input [12:0] pixel_index,
    input [15:0] border_color,
    input [15:0] in_oled_data,
    output [15:0] out_oled_data);
    
    localparam Width = 96;
    localparam Height = 64;
    wire [6:0] pixel_x;
    wire [5:0] pixel_y;
    assign pixel_x = pixel_index % Width;
    assign pixel_y = pixel_index / Width;

    wire [15:0] out_color;
    assign out_color = on && (pixel_y < thickness || pixel_x < thickness || pixel_x > (Width - thickness - 1) || pixel_y > (Height - thickness - 1)) ? in_oled_data | border_color : 0;
    assign out_oled_data = out_color ? out_color : in_oled_data;

endmodule