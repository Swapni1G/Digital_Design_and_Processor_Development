module counter_2digit (
    input clk,  // 100 MHz input clock
    output reg [3:0] D0_AN,   // Display 0 anodes
    output reg [3:0] D1_AN,   // Display 1 anodes
    output reg [7:0] D0_SEG,  // Display 0 segments (units place)
    output reg [7:0] D1_SEG   // Display 1 segments (tens place)
);

    reg [26:0] clk_div = 0;
    reg slow_clk = 0;

    // Two decimal digits
    reg [3:0] ones = 0;
    reg [3:0] tens = 0;

    // 7-segment decoder function
    function [7:0] seg_decode;
        input [3:0] digit;
        begin
            case (digit)
                4'd0: seg_decode = 8'b11000000;
                4'd1: seg_decode = 8'b11111001;
                4'd2: seg_decode = 8'b10100100;
                4'd3: seg_decode = 8'b10110000;
                4'd4: seg_decode = 8'b10011001;
                4'd5: seg_decode = 8'b10010010;
                4'd6: seg_decode = 8'b10000010;
                4'd7: seg_decode = 8'b11111000;
                4'd8: seg_decode = 8'b10000000;
                4'd9: seg_decode = 8'b10010000;
                default: seg_decode = 8'b11111111;
            endcase
        end
    endfunction

    // Clock divider for 1 Hz pulse
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
        if (clk_div == 10000000) begin  // 0.5 sec high, 0.5 sec low → 1 Hz
            clk_div <= 0;
            slow_clk <= ~slow_clk;
        end
    end

    // Count logic: increment ones and tens
    always @(posedge slow_clk) begin
        if (ones == 9) begin
            ones <= 0;
            if (tens == 9)
                tens <= 0;
            else
                tens <= tens + 1;
        end else begin
            ones <= ones + 1;
        end
    end

    // Always show both digits (one on each 7-seg)
    always @(*) begin
        D0_AN = 4'b1110;             // Enable digit 0 (unit's place)
        D1_AN = 4'b0111;             // Enable digit 1 (ten's place)
        D0_SEG = seg_decode(tens);  // Segment pattern for one's place
        D1_SEG = seg_decode(ones);  // Segment pattern for ten's place
    end

endmodule
