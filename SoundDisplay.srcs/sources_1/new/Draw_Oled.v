`timescale 1ns / 1ps

module Draw_Oled(
    input CLK100MHZ,
    input [1:0] color_scheme,
    input [1:0] thickness_sel,
    input volume_bar_sel,
    input [3:0] volume_bar,
    input [12:0] pixel_index,
    output [15:0] oled_data);

    wire clk_1;
    Clock_Divider clock_1(.basys_clock(CLK100MHZ), .count_max(12499999), .clock(clk_1));

    `define RGB_TO_OLED(C, R, G, B) wire [15:0] C; assign C[15:11] = R * 31 / 255; assign C[10:5] = G * 63 / 255; assign C[4:0] = B * 31 / 255;

    `RGB_TO_OLED(BG0, 0, 0, 0);
    `RGB_TO_OLED(BG1, 'h5c, 'h41, 'h66);
    `RGB_TO_OLED(BG2, 'hee, 'hfc, 'he8);

    `RGB_TO_OLED(BORDER0, 255, 255, 255);
    `RGB_TO_OLED(BORDER1, 'hfa, 'hce, 'hcf);
    `RGB_TO_OLED(BORDER2, 'h3a, 'h3d, 'h39);

    `RGB_TO_OLED(BAR_COLOR_HIGH0, 255, 0, 0);
    `RGB_TO_OLED(BAR_COLOR_MED0, 255, 255, 0);
    `RGB_TO_OLED(BAR_COLOR_LOW0, 0, 255, 0);

    `RGB_TO_OLED(BAR_COLOR_HIGH1, 'hf5, 'h80, 'h03);
    `RGB_TO_OLED(BAR_COLOR_MED1, 'h11, 'h09, 'heb);
    `RGB_TO_OLED(BAR_COLOR_LOW1, 'h04, 'hdb, 'h28);

    `RGB_TO_OLED(BAR_COLOR_HIGH2, 'h03, 'h81, 'hff);
    `RGB_TO_OLED(BAR_COLOR_MED2, 'hff, 'h64, 'h03);
    `RGB_TO_OLED(BAR_COLOR_LOW2, 'hff, 'h05, 'h44);

    wire [15:0] background_color, border_color, bar_color_high, bar_color_med, bar_color_low;

    assign background_color =   color_scheme == 0 ? BG0 :
                                color_scheme == 1 ? BG1 : 
                                color_scheme == 2 ? BG2 : BG0;
    assign border_color =   color_scheme == 0 ? BORDER0 :
                            color_scheme == 1 ? BORDER1 : 
                            color_scheme == 2 ? BORDER2 : BORDER0;
    assign bar_color_high = color_scheme == 0 ? BAR_COLOR_HIGH0 :
                            color_scheme == 1 ? BAR_COLOR_HIGH1 : 
                            color_scheme == 2 ? BAR_COLOR_HIGH2 : BAR_COLOR_HIGH0;
    assign bar_color_med =  color_scheme == 0 ? BAR_COLOR_MED0 :
                            color_scheme == 1 ? BAR_COLOR_MED1 : 
                            color_scheme == 2 ? BAR_COLOR_MED2 : BAR_COLOR_MED0;
    assign bar_color_low =  color_scheme == 0 ? BAR_COLOR_LOW0 :
                            color_scheme == 1 ? BAR_COLOR_LOW1 :
                            color_scheme == 2 ? BAR_COLOR_LOW2 : BAR_COLOR_LOW0;

    wire [1:0] thickness;
    assign thickness = thickness_sel[0] ? 1 : 3;

    Oled_Border oled_border(.on(thickness_sel[1]), .thickness(thickness), .pixel_index(pixel_index), .border_color(border_color), .in_oled_data(background_color));
    Oled_Volume_Bar oled_volume_bar(.on(volume_bar_sel), .pixel_index(pixel_index), .bar_color_high(bar_color_high), .bar_color_med(bar_color_med), .bar_color_low(bar_color_low), .in_oled_data(oled_border.out_oled_data), .volume_bar(volume_bar));
    Oled_Pulse oled_pulse(.clock(CLK100MHZ), .on(1), .pixel_index(pixel_index), .in_oled_data(oled_volume_bar.out_oled_data), .volume(volume_bar));
    assign oled_data = oled_pulse.out_oled_data;

endmodule