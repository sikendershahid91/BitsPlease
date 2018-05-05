`timescale 1ns/100ps
module reconfigTmr8B_tb();
  reg pulseClk;
  reg enable;
  reg [7:0] timeAdj;
  wire pulseROut;

  reconfigTmr8B DUT_rTmr(enable, pulseClk, timeAdj, pulseROut);

  always begin
    pulseClk = 1;
    #10;
    pulseClk = 0;
    #10;
  end

  initial begin
    timeAdj = 8'b11001000;
    enable = 1;
    #13;
    enable = 0; 
  end
endmodule
