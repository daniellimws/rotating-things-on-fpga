`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2020 12:06:45
// Design Name: 
// Module Name: display_audio_intensity
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module display_audio_intensity(input twentyclock, input [3:0] max_vol, input [11:0] mic_in, input sw, output reg [15:0] led, output reg [6:0] seg, output reg [3:0] AN);
//digits
reg [6:0] zero = 7'b1000000;
reg [6:0] one = 7'b1111001;
reg [6:0] two = 7'b0100100;
reg [6:0] three = 7'b0110000;
reg [6:0] four = 7'b0011001;
reg [6:0] five = 7'b0010010;
reg [6:0] six = 7'b0000010;
reg [6:0] seven = 7'b1000000;
reg [6:0] eight = 7'b0000000;
reg [6:0] nine = 7'b0010000;
reg [15:0] selected_output;
reg [15:0] max_leds;

//counters for each max_vol
reg [0:0] counter_0 = 0;
reg [0:0] counter_1 = 0;
reg [0:0] counter_2 = 0;
reg [0:0] counter_3 = 0;
reg [0:0] counter_4 = 0;
reg [0:0] counter_5 = 0;
reg [0:0] counter_6 = 0;
reg [0:0] counter_7 = 0;
reg [0:0] counter_8 = 0;
reg [0:0] counter_9 = 0;
reg [0:0] counter_10 = 0;
reg [0:0] counter_11= 0;
reg [0:0] counter_12= 0;
reg [0:0] counter_13= 0;
reg [0:0] counter_14= 0;
reg [0:0] counter_15= 0;

//slowclk
reg [30:0] slowerclock_count=0;
always @ (posedge twentyclock)begin
    //counter_0 <= counter_0 + 1;
    //counter_1 <= counter_1 + 1;
    //counter_2 <= counter_2 + 1;
    //counter_3 <= counter_3 + 1;
    //counter_4 <= counter_4 + 1;
    //counter_5 <= counter_5 + 1;
    //counter_6 <= counter_6 + 1;
    //counter_7 <= counter_7 + 1;
    //counter_8 <= counter_8 + 1;
    //counter_9 <= counter_9 + 1;
    //counter_10 <= counter_10 + 1;
    //counter_11 <= counter_11 + 1;
    //counter_12 <= counter_12 + 1;
    //counter_13 <= counter_13 + 1;
    //counter_14 <= counter_14 + 1;
    //counter_15 <= counter_15 + 1;
    //slowerclock_count <= slowerclock_count + 1;
    //if(slowerclock_count <= 2000)
       // slowerclock_count<=0;
    led <= sw ? max_leds : {4'b0000, mic_in};
    
    case(max_vol)
        0:begin
            max_leds <= 16'b0000000000000000;
            //counter_0 <= counter_0 + 1;
            case(counter_0)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= zero;
                counter_0<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_0<=0;end
            endcase
            end
        1:begin
            max_leds <= 16'b0000000000000001;
            //counter_1 <= counter_1 + 1;
            case(counter_1)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= one;
                counter_1<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_1<=0;end
            endcase
            end        
        2:begin
            max_leds <= 16'b0000000000000011;
            //counter_2 <= counter_2 + 1;
            case(counter_2)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= two;
                counter_2<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_2<=0;end
            endcase
            end
        3:begin
            max_leds <= 16'b0000000000000111;
            //counter_3 <= counter_3 + 1;
            case(counter_3)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= three;
                counter_3<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_3<=0;end
                endcase
                end                
        4:begin
            max_leds <= 16'b0000000000001111;
            //counter_4 <= counter_4 + 1;
            case(counter_4)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= four;
                counter_4<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_4<=0;end
            endcase
            end
        5:begin
            max_leds <= 16'b0000000000011111;
            //counter_5 <= counter_5 + 1;
            case(counter_5)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= five;
                counter_5<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_5<=0;end
            endcase
            end
        6:begin
            max_leds <= 16'b0000000000111111;
            //counter_6 <= counter_6 + 1;
            case(counter_6)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= six;
                counter_6<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_6<=0;end
            endcase
            end        

        7:begin
            max_leds <= 16'b0000000001111111;
            //counter_7 <= counter_7 + 1;
            case(counter_7)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= seven;
                counter_7<=0;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_7<=1;end
            endcase
            end
        8:begin
            max_leds <= 16'b000000011111111;
            //counter_8 <= counter_8 + 1;
            case(counter_8)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= eight;
                counter_8<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_8<=0;end
            endcase
            end
        9:begin
            max_leds <= 16'b0000000111111111;
            //counter_9 <= counter_9 + 1;
            case(counter_9)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= nine;
                counter_9<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_9<=0;end
        endcase
        end
        10:begin
            max_leds <= 16'b0000001111111111;
            //counter_10 <= counter_10 + 1;
            case(counter_10)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= one;
                counter_10<=1;end
            1:begin
                AN<=4'b1101;
                seg<= zero;
                counter_10<=0;end
            endcase
            end
        11:begin
            max_leds <= 16'b0000011111111111;
            //counter_11 <= counter_11 + 1;
            case(counter_11)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= one;
                counter_11<=1;end
            1:begin
                AN<=4'b1101;
                seg<= one;
                counter_11<=0;end
            endcase
            end
        12:begin
           max_leds <= 16'b0000111111111111;
           //counter_12 <= counter_12 + 1;
           case(counter_12)
           //AN[0]
           0:begin
                AN<=4'b1110;
                seg<= two;
                counter_12<=1;end
           1:begin
                AN<=4'b1101;
                seg<= one;
                counter_12<=0;end
           endcase
           end

        13:begin
            max_leds <= 16'b0001111111111111;
            //counter_13 <= counter_13 + 1;
            case(counter_13)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= three;
                counter_13<=1;end
            1:begin
                AN<=4'b1101;
                seg<= one;
                counter_13<=0;end
            endcase
            end
        14:begin
            max_leds <= 16'b0111111111111111;
            //counter_14 <= counter_14 + 1;
            case(counter_14)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= four;
                counter_14<=0;end
            1:begin
                AN<=4'b1101;
                seg<= one;
                counter_14<=0;end
            endcase
            end
        15:begin
            max_leds <= 16'b0111111111111111;
            //counter_15 <= counter_15 + 1;
            case(counter_15)
            //AN[0]
            0:begin
                AN<=4'b1110;
                seg<= five;
                counter_15<=1;end
            1:begin
                AN<=4'b1101;
                seg<= one;
                counter_15<=0;end
            endcase
            end
        endcase
        end
        
endmodule

