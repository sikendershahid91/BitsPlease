
module One_mSecondTimer(pulseClk, pulseOneS);
  input pulseClk;
  output pulseOneS;

  reg pulse;
  reg [7:0] counter = 8'b00000000;

  always @ (posedge pulseClk) begin
    if(counter >= 200) begin
      pulse <= 1;
      counter <= 0;
    end
    else begin
      pulse <= 0;
      counter <= counter + 1;
    end
  end

  assign pulseOneS = pulse;
endmodule
