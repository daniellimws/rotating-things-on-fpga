`timescale 1ns / 1ps

module Clock_Divider(
    input basys_clock,
    input [25:0] count_max, 
    output reg clock = 0
    );
            
    reg [25:0] clk_counter = 0;
    
    always @ (posedge basys_clock)
    begin
        clk_counter <= (clk_counter == count_max) ? 0 : clk_counter + 1;
        clock <= clk_counter == 0 ? ~clock : clock;
    end
endmodule
