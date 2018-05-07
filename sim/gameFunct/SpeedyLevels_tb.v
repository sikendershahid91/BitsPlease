`timescale 1ns/100ps

module SpeedyLevels_tb ();
  reg stacked;
  reg [7:0] inSpd;
  wire [7:0] shorterTime;

  SpeedyLevels DUT_SL(stacked, inSpd, shorterTime);

  always begin
    stacked = 0;
    #2;
    stacked = 1;
    #2;
  end
  initial begin
    inSpd = 200;
  end
endmodule // SpeedyLevels
