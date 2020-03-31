`timescale 1ns / 1ps

module Oled_In_Arc(
    input clock,
    input on, 
    input dir,
    input [1:0] mode,
    input [1:0] mult,
    input [10:0] omega,
    input [5:0] thickness,
    input [5:0] radius,
    input signed [22:0] pixel_x,
    input signed [22:0] pixel_y,
    output inside);

    localparam FW = 14;

    // CORDIC stuff
    reg [12:0] counter = 0;

    // Arc position
    reg signed [26:0] pos_phase = 0;
    wire [15:0] pos_sin, pos_cos;
    cordic_0 pos_cordic (
        .aclk(clock),                       // input wire aclk
        .s_axis_phase_tvalid(1),            // input wire s_axis_phase_tvalid
        .s_axis_phase_tdata(pos_phase[26:11]),       // input wire [15 : 0] s_axis_phase_tdata
        .m_axis_dout_tdata({pos_sin, pos_cos})         // output wire [31 : 0] m_axis_dout_tdata
    );

    // Circles that form the arc
    wire signed [22:0] rotated_x, rotated_y;
    Rotate_XY pos_rotate(.i_pixel_x(pixel_x), .i_pixel_y(pixel_y), .i_sin(pos_sin), .i_cos(pos_cos), .o_pixel_x(rotated_x), .o_pixel_y(rotated_y));

    wire [45:0] inner_radius_sq, outer_radius_sq, pixel_radius_sq;
    assign pixel_radius_sq = (rotated_x * rotated_x + rotated_y * rotated_y) >> FW;
    assign inner_radius_sq = (radius * radius) << FW;
    assign outer_radius_sq = ((radius + thickness) * (radius + thickness)) << FW;
    
    Translate_XY translate(.i_pixel_x(rotated_x), .i_pixel_y(rotated_y), .i_offset_x(radius + (thickness >> 1)), .i_offset_y(radius + (thickness >> 1)));
    wire in_circle_head, in_circle_tail, in_full_arc;
    Oled_In_Circle circle_head(.on(on), .thickness(thickness >> 1), .radius(0), .pixel_x(translate.o_pixel_x), .pixel_y(rotated_y), .inside(in_circle_head));
    Oled_In_Circle circle_tail(.on(on), .thickness(thickness >> 1), .radius(0), .pixel_x(rotated_x), .pixel_y(translate.o_pixel_y), .inside(in_circle_tail));
    assign in_full_arc = pixel_radius_sq >= inner_radius_sq && pixel_radius_sq <= outer_radius_sq && (mode == 0 ? 1 : rotated_x >= 0);

    // Limit arc to certain angle
    wire signed [22:0] rotated_x2, rotated_y2;
    Rotate_XY len_rotate(.i_pixel_x(rotated_x), .i_pixel_y(rotated_y), .i_sin(pos_sin), .i_cos(pos_cos), .o_pixel_x(rotated_x2), .o_pixel_y(rotated_y2));

    wire in_quadrant;
    assign in_quadrant =    mode == 1 ? rotated_y2 >= 0 :
                            mode == 2 ? (rotated_x2 <= 0 && rotated_y2 >= 0) || (rotated_x2 >= 0 && rotated_y2 <= 0) :
                            mode == 3 ? rotated_x2 <= 0 && rotated_y2 >= 0 :
                            1;

    assign inside = on && (in_full_arc && in_quadrant || in_circle_head || in_circle_tail);

    wire [10:0] real_omega;
    assign real_omega = omega >> (3 - mult);
    always @ (posedge clock)
    begin
        counter <= counter == 6143 ? 0 : counter + 1;
        if (counter == 0)
        begin
            if (dir)
                pos_phase <= (pos_phase >= $signed(27'h1000000)) ? 27'h7000000 : pos_phase + real_omega;
            else
                pos_phase <= (pos_phase <= $signed(27'h7000000)) ? 27'h1000000 : pos_phase - real_omega;
        end
    end
endmodule