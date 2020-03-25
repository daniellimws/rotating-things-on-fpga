`timescale 1ns / 1ps

module Oled_Volume_Bar(
    input on,
    input [3:0] volume_bar,
    input [15:0] bar_color_low,
    input [15:0] bar_color_med,
    input [15:0] bar_color_high,
    input [12:0] pixel_index,
    input [15:0] in_oled_data,
    output [15:0] out_oled_data);

    wire [4:0] high_rects, medium_rects;
    wire [5:0] low_rects;

    parameter Rect_Width = 8;
    parameter Rect_Height = 2;
    parameter Bar_x = 80;
    parameter Bar_y = 8;
    parameter High_Rect_y = Bar_y;
    parameter Medium_Rect_y = Bar_y + 5 * (Rect_Height + 1);
    parameter Low_Rect_y = Bar_y + 10 * (Rect_Height + 1);

    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1)
        begin
            Oled_In_Rect rect(.on(on && (volume_bar > 15 - i)), .rect_x(Bar_x), .rect_y(High_Rect_y + i * (Rect_Height + 1)), .rect_width(Rect_Width), .rect_height(Rect_Height), .pixel_index(pixel_index), .inside(high_rects[i]));
        end

        for (i = 0; i < 5; i = i + 1)
        begin
            Oled_In_Rect rect(.on(on && (volume_bar > 10 - i)), .rect_x(Bar_x), .rect_y(Medium_Rect_y + i * (Rect_Height + 1)), .rect_width(Rect_Width), .rect_height(Rect_Height), .pixel_index(pixel_index), .inside(medium_rects[i]));
        end

        for (i = 0; i < 6; i = i + 1)
        begin
            Oled_In_Rect rect(.on(on && (volume_bar > 5 - i)), .rect_x(Bar_x), .rect_y(Low_Rect_y + i * (Rect_Height + 1)), .rect_width(Rect_Width), .rect_height(Rect_Height), .pixel_index(pixel_index), .inside(low_rects[i]));
        end
    endgenerate

    wire [15:0] out_color;
    assign out_color =  |high_rects ? bar_color_high : 
                        |medium_rects ? bar_color_med :
                        |low_rects ? bar_color_low : 0;
    assign out_oled_data = out_color ? out_color : in_oled_data;

endmodule