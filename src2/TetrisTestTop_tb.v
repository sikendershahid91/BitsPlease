`timescale 1ns / 100ps

module TetrisTestTop_tb();
  reg start;
  reg stacked;
  reg clk, rstBtn;
  reg stopBtn;
  wire rLED;
  wire doneLED;
  wire [63:0] outputStream;

  TetrisTestTop DUT_TTT(start, stacked, clk, rstBtn, stopBtn, rLED, doneLED, outputStream);

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
  end


endmodule
