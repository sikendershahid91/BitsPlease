module SpeedyLevels(clk, stacked, shorterTime);
  input clk;
  input stacked;//check if blocks were stacked correctly | boolean T/F
  output [7:0] shorterTime; //spd increase == shorter time
  reg [7:0] tempTime;
  reg [7:0] setupTime;
  reg state;

  always @ (posedge clk) begin
    case (state)
      1: begin
        if(stacked == 1) begin
          tempTime <= tempTime >> 1;
        end
      end
      default: begin
        tempTime <= 200;
        state <= 1;
      end
    endcase
  end

  assign shorterTime = tempTime;
endmodule
