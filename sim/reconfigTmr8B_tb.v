`timescale 1ns/100ps
module reconfigTmr8B_tb();
  reg pulseClk;
  reg rst;
  reg [7:0] timeAdj;
  wire pulseROut;

  reconfigTmr8B DUT_rTmr(rst, pulseClk, timeAdj, pulseROut);

  always begin
    pulseClk = 1;
    #10;
    pulseClk = 0;
    #10;
  end

  initial begin
    timeAdj = 8'b11001000;
    rst = 0;
    #13;
    rst = 1;
  end
endmodule
