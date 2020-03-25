`timescale 1ns / 1ps

module Oled_In_Circle(
    input on, 
    input [1:0] thickness,
    input [5:0] radius,
    input [12:0] pixel_index,
    output inside);
    
    localparam Width = 96;
    localparam Height = 64;
    wire [6:0] pixel_x;
    wire [5:0] pixel_y;
    assign pixel_x = pixel_index % Width;
    assign pixel_y = pixel_index / Width;

    parameter offset_x = 48;
    parameter offset_y = 32;
    parameter offset_x_sq = offset_x * offset_x;
    parameter offset_y_sq = offset_y * offset_y;

    wire [13:0] pixel_radius_sq, inner_radius_sq, outer_radius_sq, pixel_x_sq, pixel_y_sq, pixel_offset_x_sq, pixel_offset_y_sq;
    assign pixel_x_sq = pixel_x * pixel_x;
    assign pixel_y_sq = pixel_y * pixel_y;
    assign pixel_offset_x_sq = pixel_x_sq + offset_x_sq - 2 * offset_x * pixel_x;
    assign pixel_offset_y_sq = pixel_y_sq + offset_y_sq - 2 * offset_y * pixel_y;
    assign pixel_radius_sq = pixel_offset_x_sq + pixel_offset_y_sq;
    assign inner_radius_sq = radius * radius;
    assign outer_radius_sq = (radius + thickness) * (radius + thickness);
    
    assign inside = on && (pixel_radius_sq >= inner_radius_sq) && (pixel_radius_sq <= outer_radius_sq);
endmodule