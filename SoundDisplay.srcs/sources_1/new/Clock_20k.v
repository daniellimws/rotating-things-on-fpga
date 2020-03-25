`timescale 1ns / 1ps

module Clock_20k(
    input basys_clock,
    output reg clock = 0
    );
            
    // f = 6.25Mhz
    reg [12:0] clk_counter = 0;
    
    always @ (posedge basys_clock)
    begin
        clk_counter <= (clk_counter == 2499) ? 0 : clk_counter + 1;
        clock <= clk_counter == 0 ? ~clock : clock;
    end
endmodule
