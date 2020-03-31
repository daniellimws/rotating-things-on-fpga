`timescale 1ns / 1ps

module Oled_In_Circle(
    input on,
    input [5:0] thickness,
    input [5:0] radius,
    input signed [22:0] pixel_x,
    input signed [22:0] pixel_y,
    output inside);

    localparam FW = 14;

    wire [45:0] inner_radius_sq, outer_radius_sq, pixel_radius_sq;
    assign pixel_radius_sq = (pixel_x * pixel_x + pixel_y * pixel_y) >> FW;
    assign inner_radius_sq = (radius * radius) << FW;
    assign outer_radius_sq = ((radius + thickness) * (radius + thickness)) << FW;
    
    assign inside = on && (pixel_radius_sq >= inner_radius_sq) && (pixel_radius_sq <= outer_radius_sq);
endmodule