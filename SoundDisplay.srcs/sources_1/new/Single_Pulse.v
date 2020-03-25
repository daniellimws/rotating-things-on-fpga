`timescale 1ns / 1ps

module Single_Pulse(
    input clock,
    input button,
    output out
    );
    
    wire q1, q2;
    DFF dff1(clock, button, q1);
    DFF dff2(clock, q1, q2);
    
    assign out = q1 & ~q2;
endmodule
