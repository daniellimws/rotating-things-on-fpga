`timescale 1ns / 1ps

module Translate_XY(
    input [22:0] i_pixel_x,
    input [22:0] i_pixel_y,
    input [6:0] i_offset_x,
    input [5:0] i_offset_y,
    output [22:0] o_pixel_x,
    output [22:0] o_pixel_y
);

    localparam FW = 14;

    assign o_pixel_x = i_pixel_x - (i_offset_x << FW);
    assign o_pixel_y = i_pixel_y - (i_offset_y << FW);

endmodule