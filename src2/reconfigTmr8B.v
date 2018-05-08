module reconfigTmr8B(pulseClk, timeAdj, pulseROut);
  input pulseClk;
  input [7:0] timeAdj;
  output pulseROut;

  reg pulse;
  reg [7:0] adjCounter;

  parameter s_init = 0, s_count = 1, s_pulseHigh = 2;
  reg [1:0] state;

  always @ (posedge pulseClk) begin
      case(state)
        s_init: begin
          pulse <= 0;
          adjCounter <= timeAdj;
          state <= s_count;
        end
        s_count: begin
          if(adjCounter > 0) begin
            adjCounter <= adjCounter - 1;
            pulse <= 0;
            state <= s_count;
          end
          else begin
            state <= s_pulseHigh;
          end
        end
        s_pulseHigh: begin
          pulse <= 1;
          state <= s_init;
        end
        default: begin
          state <= s_init;
        end
      endcase
  end
  assign pulseROut = pulse;
endmodule
