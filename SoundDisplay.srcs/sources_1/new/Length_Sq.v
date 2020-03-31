`timescale 1ns / 1ps

module Length_Sq(
    input [6:0] pixel_x,
    input [5:0] pixel_y,
    output [13:0] len_sq
);

    parameter offset_x = 48;
    parameter offset_y = 32;

    wire [13:0] real_x, real_y, real_x_sq, real_y_sq;
    assign real_x = pixel_x - offset_x;
    assign real_y = pixel_y - offset_y;
    assign real_x_sq = real_x * real_x;
    assign real_y_sq = real_y * real_y;
    assign length_sq = real_x_sq + real_y_sq;

endmodule