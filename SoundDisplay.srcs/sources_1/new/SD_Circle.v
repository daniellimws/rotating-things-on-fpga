`timescale 1ns / 1ps

module SD_Circle(
    input on,
    input [5:0] radius,
    input [12:0] pixel_index,
    output [13:0] d
);

    wire [6:0] pixel_x;
    wire [5:0] pixel_y;
    Index_To_XY convert(.pixel_index(pixel_index), .pixel_x(pixel_x), .pixel_y(pixel_y));

    wire [13:0] len_sq;
    Length_Sq length_sq(.pixel_x(pixel_x), .pixel_y(pixel_y), .len_sq(len_sq));

    wire [13:0] radius_sq;
    assign radius_sq = radius * radius;

    assign d = len_sq - radius_sq;

endmodule