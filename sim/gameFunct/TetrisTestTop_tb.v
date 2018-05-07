`timescale 1ns / 100ps

module TetrisTestTop_tb();
  reg clk, rstBtn;
  reg stopBtn;
  wire gLED, rLED;
  wire [7:0] segOut;

  TetrisTestTop DUT_TTT(clk, rstBtn, stopBtn, rLED, gLED, segOut);

  always begin
    clk = 1;
    #10;
    clk = 0;
    #10;
  end

  initial begin
    #5;
    #40;
    rstBtn = 0;
    #40;
    rstBtn = 1;
    #40;
    stopBtn = 0;
  end
endmodule
