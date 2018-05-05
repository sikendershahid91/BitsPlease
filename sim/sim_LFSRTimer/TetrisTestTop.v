module TetrisTestTop(clk, rstBtn, rLED, gLED);
  input clk, rstBtn;

  output gLED, rLED;

  wire pulseOut;
  wire pulseOnems;

  LFSRTimer_005_ms short005ms(clk, rstBtn, pulseOut);

  One_mSecondTimer one_ms(pulseOut, pulseOnems, rLED);

  // reconfigTmr8B rTmr1(rstBtn, pulseOnems, 200, gLED);
endmodule
