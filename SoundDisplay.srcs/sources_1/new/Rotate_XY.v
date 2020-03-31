`timescale 1ns / 1ps

module Rotate_XY(
    input signed [22:0] i_pixel_x,
    input signed [22:0] i_pixel_y,
    input signed [15:0] i_sin,
    input signed [15:0] i_cos,
    output signed [22:0] o_pixel_x,
    output signed [22:0] o_pixel_y
);

    localparam FW = 14;

    wire signed [45:0] pre_pixel_x, pre_pixel_y;
    assign pre_pixel_x = i_pixel_x * i_cos - i_pixel_y * i_sin;
    assign pre_pixel_y = i_pixel_x * i_sin + i_pixel_y * i_cos;

    assign o_pixel_x = pre_pixel_x >> FW;
    assign o_pixel_y = pre_pixel_y >> FW;

endmodule