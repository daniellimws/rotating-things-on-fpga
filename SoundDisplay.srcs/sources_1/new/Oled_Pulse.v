`timescale 1ns / 1ps

module Oled_Pulse(
    input clock,
    input on,
    input [3:0] volume,
    input [12:0] pixel_index,
    input [15:0] in_oled_data,
    output [15:0] out_oled_data);

    wire [1:0] mode, mult;
    assign mode = volume[3:2];
    assign mult = volume[1:0];

    localparam FW = 14;
    localparam offset_x = 48;
    localparam offset_y = 32;
    
    wire signed [22:0] pixel_x;
    wire signed [22:0] pixel_y;
    Index_To_XY index_to_xy(.pixel_index(pixel_index));
    assign pixel_x = (index_to_xy.pixel_x - offset_x) << FW;
    assign pixel_y = (index_to_xy.pixel_y - offset_y) << FW;

    reg [4:0] CIRCLE_RADIUS = 4;
    reg [4:0] RADIUS1 = 4;
    reg [4:0] RADIUS2 = 6;
    reg [4:0] RADIUS3 = 8;
    reg [4:0] RADIUS4 = 10;
    reg [4:0] RADIUS5 = 12;
    reg [4:0] RADIUS6 = 14;

    parameter OFFSET1_1 = 1;
    parameter OFFSET2_1 = 2;
    parameter OFFSET3_1 = 3;
    parameter OFFSET4_1 = 4;
    parameter OFFSET5_1 = 5;
    parameter OFFSET6_1 = 6;

    parameter OFFSET1_2 = 1;
    parameter OFFSET2_2 = 3;
    parameter OFFSET3_2 = 5;
    parameter OFFSET4_2 = 7;
    parameter OFFSET5_2 = 9;
    parameter OFFSET6_2 = 11;

    localparam OMEGA1 = 11'b01010000000;
    localparam OMEGA2 = 11'b01100100000;
    localparam OMEGA3 = 11'b01111101000;
    localparam OMEGA4 = 11'b10011100010;
    localparam OMEGA5 = 11'b11000011010;
    localparam OMEGA6 = 11'b11110100001;

    wire in_arc1, in_arc2, in_arc3, in_arc4, in_arc5, in_arc6, in_circle;
    Oled_In_Arc arc1(.clock(clock), .on(on), .dir(0), .thickness(2 + (mode == 3 ? 1 : 0)), .radius(RADIUS1 + (mode == 2 ? OFFSET1_1 : mode == 3 ? OFFSET1_2 : 0)), .pixel_x(pixel_x), .pixel_y(pixel_y), .inside(in_arc1), .omega(OMEGA1), .mode(mode), .mult(mult));
    Oled_In_Arc arc2(.clock(clock), .on(on), .dir(1), .thickness(2 + (mode == 3 ? 1 : 0)), .radius(RADIUS2 + (mode == 2 ? OFFSET2_1 : mode == 3 ? OFFSET2_2 : 0)), .pixel_x(pixel_x), .pixel_y(pixel_y), .inside(in_arc2), .omega(OMEGA2), .mode(mode), .mult(mult));
    Oled_In_Arc arc3(.clock(clock), .on(on), .dir(0), .thickness(2 + (mode == 3 ? 1 : 0)), .radius(RADIUS3 + (mode == 2 ? OFFSET3_1 : mode == 3 ? OFFSET3_2 : 0)), .pixel_x(pixel_x), .pixel_y(pixel_y), .inside(in_arc3), .omega(OMEGA3), .mode(mode), .mult(mult));
    Oled_In_Arc arc4(.clock(clock), .on(on), .dir(1), .thickness(2 + (mode == 3 ? 1 : 0)), .radius(RADIUS4 + (mode == 2 ? OFFSET4_1 : mode == 3 ? OFFSET4_2 : 0)), .pixel_x(pixel_x), .pixel_y(pixel_y), .inside(in_arc4), .omega(OMEGA4), .mode(mode), .mult(mult));
    Oled_In_Arc arc5(.clock(clock), .on(on), .dir(0), .thickness(2 + (mode == 3 ? 1 : 0)), .radius(RADIUS5 + (mode == 2 ? OFFSET5_1 : mode == 3 ? OFFSET5_2 : 0)), .pixel_x(pixel_x), .pixel_y(pixel_y), .inside(in_arc5), .omega(OMEGA5), .mode(mode), .mult(mult));
    Oled_In_Arc arc6(.clock(clock), .on(on), .dir(1), .thickness(2 + (mode == 3 ? 1 : 0)), .radius(RADIUS6 + (mode == 2 ? OFFSET6_1 : mode == 3 ? OFFSET6_2 : 0)), .pixel_x(pixel_x), .pixel_y(pixel_y), .inside(in_arc6), .omega(OMEGA6), .mode(mode), .mult(mult));
    Oled_In_Circle circle(.on(on), .thickness(CIRCLE_RADIUS + (mode[1] ? 1 : 0)), .radius(0), .pixel_x(pixel_x), .pixel_y(pixel_y), .inside(in_circle));

    wire [15:0] out_color;
    assign out_color =  in_arc1 ? {5'd0, 6'd8, 5'd10} :
                        in_arc2 ? {5'd0, 6'd16, 5'd15} :
                        in_arc3 ? {5'd0, 6'd24, 5'd20} :
                        in_arc4 ? {5'd0, 6'd32, 5'd25} :
                        in_arc5 ? {5'd0, 6'd40, 5'd30} :
                        in_arc6 ? {5'd0, 6'd48, 5'd31} :
                        in_circle ? {5'd0, 6'd6, 5'd8} : 0;
    assign out_oled_data = out_color ? out_color : in_oled_data;

endmodule