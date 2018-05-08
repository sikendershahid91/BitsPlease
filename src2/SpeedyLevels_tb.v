`timescale 1ns/100ps

module SpeedyLevels_tb ();
  reg clk;
  reg stacked;
  wire [7:0] shorterTime;

  SpeedyLevels DUT_SL(clk, stacked, shorterTime);

  always begin
    clk = 0;
    #2;
    clk = 1;
    #2;
  end

  always begin
    stacked = 0;
    #5;
    stacked = 1;
    #5;
  end

endmodule // SpeedyLevels
