`timescale 1ns / 1ps

module cordic_delay();
    reg aclk = 0;
    reg s_tvalid = 0;
    reg [26:0] phase = 0;

    wire m_tvalid;
    wire [31:0] m_tdata;

    wire [15:0] sin, cos;

    cordic_0 cordic (
        .aclk(aclk),                                // input wire aclk
        .s_axis_phase_tvalid(s_tvalid),  // input wire s_axis_phase_tvalid
        .s_axis_phase_tdata(phase[26:11]),    // input wire [15 : 0] s_axis_phase_tdata
        .m_axis_dout_tvalid(m_tvalid),    // output wire m_axis_dout_tvalid
        .m_axis_dout_tdata(m_tdata)      // output wire [31 : 0] m_axis_dout_tdata
    );
    assign cos = m_tdata[31:16];
    assign sin = m_tdata[15:0];

    initial begin
        s_tvalid = 1;
    end

    always begin
        #5; aclk <= ~aclk;
    end
    
    always @ (posedge aclk) begin
        phase <= phase == 27'h1000000 ? 27'h7000000 : phase + 27'h0010000;
    end
endmodule