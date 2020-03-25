`timescale 1ns / 1ps


module Sim_Clock_20k(

    );

    reg basys_clock = 1;
    wire clk_20k;
    Clock_20k clock_20k(.basys_clock(basys_clock), .clock(clk_20k));
    
    always
    begin
        basys_clock = ~basys_clock;
        #5;
    end
endmodule
