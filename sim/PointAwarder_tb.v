`timescale 1ns/100ps

module PointAwarder_tb();
  reg stacked;
  reg [1:0] blocksPlaced;
  reg [2:0] heightMultiplier;

  wire [4:0] pntOutput;

  PointAwarder DUT_PA(stacked, blocksPlaced, heightMultiplier, pntOutput);

  always begin
    stacked = 1;
    #10;
    stacked = 0;
    #10;
    stacked = 1;
    #30;
    stacked = 0;
    #20;
  end

  initial begin
    blocksPlaced = 1;
    heightMultiplier = 3;
    #100;
    blocksPlaced = 2;
    heightMultiplier = 7;
    #100;
  end
endmodule
