`timescale 1ns/100ps

module LFSRTimer_1ms_tb();

  reg clk, rst, enable;
  wire pulseOut;

  LFSRTimer_1ms DUT_LFSRTimer_1ms(clk, rst, enable, pulseOut);

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
    enable = 0;
    #40;
    rst = 1;
    #40;
    enable = 1;
    #40;
  end
endmodule
