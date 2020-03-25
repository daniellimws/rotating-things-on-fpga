`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////

module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v

    output [7:0] JX,

    input CLK100MHZ,
    input btnC,
    input [6:0] sw,
    output [11:0] led
    );

    // Mic
    wire clk_20k;
    wire [11:0] mic_in;

    Clock_Divider clock_20k(.basys_clock(CLK100MHZ), .count_max(2499), .clock(clk_20k));
    Audio_Capture audio_capture(.CLK(CLK100MHZ), .cs(clk_20k), .MISO(J_MIC3_Pin3), .clk_samp(J_MIC3_Pin1), .sclk(J_MIC3_Pin4), .sample(mic_in));
    assign led = sw[0] ? mic_in : 0;

    // Oled Display
    wire clk_6p25m, clk_sp, reset;
    wire [15:0] oled_data;
    wire [12:0] pixel_index;
    
    wire [3:0] volume_level;
    reg [3:0] volume_bar_level = 13;
    // assign oled_data = 16'h07E0; // {5'b0, 6'd63, 5'b0};

    Clock_Divider clock_6p25m(.basys_clock(CLK100MHZ), .count_max(7), .clock(clk_6p25m));
    Clock_Single_Pulse clock_single_pulse(.basys_clock(CLK100MHZ), .clock(clk_sp));
    Single_Pulse(.clock(clk_sp), .button(btnC), .out(reset));
    Oled_Display oled_display(.clk(clk_6p25m), .reset(reset), .pixel_data(oled_data), .pixel_index(pixel_index), .cs(JX[0]), .sdin(JX[1]), .sclk(JX[3]), .d_cn(JX[4]), .resn(JX[5]), .vccen(JX[6]), .pmoden(JX[7]));

    wire clk_1;
    Clock_Divider clock_1(.basys_clock(CLK100MHZ), .count_max(49999999), .clock(clk_1));
    Draw_Oled draw_oled(.color_scheme(sw[6:5]), .thickness_sel(sw[2:1]), .volume_bar_sel(sw[3]), .volume_bar(volume_bar_level), .pixel_index(pixel_index), .oled_data(oled_data));

    always @ (posedge CLK100MHZ)
    begin
        volume_bar_level = sw[4] ? volume_level : volume_bar_level;
    end

endmodule