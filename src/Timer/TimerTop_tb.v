`timescale 1ns / 100ps

module TimerTop_tb();
  reg clk, rst;

  wire gLED, rLED;

  TimerTop DUT_1s_tb(clk, rst, rLED, gLED);

  always begin
    clk = 1;
    #10;
    clk = 0;
    #10;
  end

  initial begin
    #5;
    #40;
    rst = 0;
    #40;
    rst = 1;
    #40;
  end
endmodule
