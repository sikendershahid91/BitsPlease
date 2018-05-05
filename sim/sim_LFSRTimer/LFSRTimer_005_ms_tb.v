`timescale 1ns/100ps

module LFSRTimer_005_ms_tb();

  reg clk, rst;
  wire pulseOut;

  LFSRTimer_005_ms DUT_LFSRTimer_005(clk, rst, pulseOut);

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
