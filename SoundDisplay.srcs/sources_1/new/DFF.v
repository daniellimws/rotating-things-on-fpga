`timescale 1ns / 1ps


module DFF(
    input DFF_CLOCK,
    input D,
    output reg Q = 0
    );
    
    always @ (posedge DFF_CLOCK) begin
        Q <= D;
    end
endmodule
