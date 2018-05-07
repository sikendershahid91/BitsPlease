module SpeedyLevels(stacked, inSpd, shorterTime);
  input stacked;//check if blocks were stacked correctly | boolean T/F
  input [7:0] inSpd; //current speed;
  output [7:0] shorterTime; //spd increase == shorter time

  reg [7:0] tempTime;
  reg [7:0] setupTime;
  reg state;
  //get height
  //higher height, larger divisor;
  always @ (posedge stacked) begin
    case (state)
      1: begin
        tempTime <= tempTime >> 1;
      end
      default: begin
        tempTime <= inSpd;
        state <= 1;
      end
    endcase
  end

  assign shorterTime = tempTime;
endmodule
