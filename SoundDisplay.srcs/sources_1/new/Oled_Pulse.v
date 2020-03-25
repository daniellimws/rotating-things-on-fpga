`timescale 1ns / 1ps

module Oled_Pulse(
    input on,
    input [12:0] pixel_index,
    input [15:0] in_oled_data,
    output [15:0] out_oled_data);

    wire in_circle;
    Oled_In_Circle circle(.on(on), .thickness(3), .radius(10), .pixel_index(pixel_index), .inside(in_circle));

    wire [15:0] out_color;
    assign out_color =  in_circle ? 16'hFFFF : 0;
    assign out_oled_data = out_color ? out_color : in_oled_data;

endmodule