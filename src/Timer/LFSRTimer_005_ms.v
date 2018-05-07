
module LFSRTimer_005_ms(clk, rst, pulseOut);
  input clk;
  input rst;
  output pulseOut;

  reg pulse;
  reg [7:0] LFSR;
  wire feedback = LFSR[7];

  always @(posedge clk) begin
    if (rst == 0) begin
      LFSR <= 8'b11111111;
      pulse <= 0;
    end
    else begin
      //8'b11100001 == 250th sequence
      if(LFSR == 8'b10000111) begin
          LFSR <= 8'b11111111;
          pulse <= 1;
      end
      else begin
      LFSR[0] <= LFSR[1] ^ LFSR[2] ^ LFSR[3] ^ LFSR[7];
      LFSR[7:1] <= LFSR[6:0];
        pulse <= 0;
      end
    end

  end

  assign pulseOut = pulse;
endmodule
