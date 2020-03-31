`timescale 1ns / 1ps

module twocomp();
    parameter FW = 14;
    reg aclk = 0;
    reg [12:0] cnt = 0;

    // CORDIC
    // reg s_tvalid = 1;
    // reg [15:0] s_tdata = 16'h2000;
    // wire m_tvalid;
    // wire [31:0] m_tdata;
    // wire [15:0] sin, cos;
    // cordic_0 your_instance_name (
    //     .aclk(aclk),                                // input wire aclk
    //     .s_axis_phase_tvalid(s_tvalid),  // input wire s_axis_phase_tvalid
    //     .s_axis_phase_tdata(s_tdata),    // input wire [15 : 0] s_axis_phase_tdata
    //     .m_axis_dout_tvalid(m_tvalid),    // output wire m_axis_dout_tvalid
    //     .m_axis_dout_tdata(m_tdata)      // output wire [31 : 0] m_axis_dout_tdata
    // );
    // assign cos = m_tdata[31:16];
    // assign sin = m_tdata[15:0];

    // pixels
    reg [12:0] pixel_index = 0;
    parameter offset_x = 48;
    parameter offset_y = 32;
    wire signed [22:0] pixel_x;
    wire signed [22:0] pixel_y;
    Index_To_XY index_to_xy(.pixel_index(pixel_index));
    assign pixel_x = (index_to_xy.pixel_x - offset_x) << FW;
    assign pixel_y = (index_to_xy.pixel_y - offset_y) << FW;

    wire in_arc1, in_arc2, in_arc3;
    Oled_In_Arc arc1(.clock(aclk), .on(1), .thickness(2), .radius(5), .pixel_x(pixel_x), .pixel_y(pixel_y), .inside(in_arc1), .omega(11'b01010000000));
    // Oled_In_Arc arc2(.on(1), .thickness(2), .radius(10), .pixel_x(rotated_x), .pixel_y(rotated_y), .inside(in_arc2));
    // Oled_In_Arc arc3(.on(1), .thickness(2), .radius(15), .pixel_x(rotated_x), .pixel_y(rotated_y), .inside(in_arc3));
    // Oled_In_Circle arc1(.on(1), .thickness(2), .radius(5), .pixel_x(pixel_x), .pixel_y(pixel_y), .inside(in_arc1));

    // wire[15:0] out_oled_data;
    // Oled_Pulse pulse(.clock(aclk), .on(1), .pixel_index(pixel_index), .in_oled_data(0), .out_oled_data(out_oled_data));

    always begin
        #1;
        pixel_index <= pixel_index + 1;
        aclk <= ~aclk;
    end

endmodule