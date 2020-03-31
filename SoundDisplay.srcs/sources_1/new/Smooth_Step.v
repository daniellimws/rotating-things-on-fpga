`timescale 1ns / 1ps

module Smooth_Step(
    input [13:0] d,
    output [13:0] o
);

    parameter bound = 18'b101;

    wire [17:0] d_ext;
    assign d_ext = {d, {(3){1'b0}}};

    wire [17:0] t0;
    wire [13:0] t;
    assign t0 = (d_ext - bound) / (bound << 1);
    assign t =  t0 < 0 ? 0 :
                t0 > 5'b10000 ? 5'b10000 : t;
    
    wire [13:0] t2;
    assign t2 = t * t;

    wire [13:0] t3;
    assign t3 = 10'b1100000000 - (6'b100000 * t);

    assign o = (t2 >> 4) * (t3 >> 4);

endmodule