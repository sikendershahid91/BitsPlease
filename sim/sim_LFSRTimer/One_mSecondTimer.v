
module One_mSecondTimer(pulseClk, pulseOnemS, LED);
  input pulseClk;
  output pulseOnemS;
  output LED;

  reg LEDon;
  reg pulse;
  reg [7:0] counter;

  parameter s_init = 0, s_count = 1;

  reg state;

  always @ (posedge pulseClk) begin
      case (state)
        s_init: begin
          counter <= 8'b00000000;
          state <= s_count;
        end
        s_count: begin
          if(counter >= 200) begin
            pulse <= 1;
            LEDon <= 0;
            state <= s_init;
          end
          else begin
            pulse <= 0;
            LEDon <= 1;
            counter <= counter + 1;
            state <= s_count;
          end
        end
        default: begin
          state <= s_init;
        end
      endcase
  end

  assign pulseOnemS = pulse;
  assign LED = LEDon;
endmodule
