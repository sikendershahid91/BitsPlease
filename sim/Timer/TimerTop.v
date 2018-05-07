module TimerTop(clk, rstBtn, rLED, gLED);
  input clk, rstBtn;

  output gLED, rLED;

  wire pulseOut;
  wire pulseOnems;
  wire pulseFifthS;

  LFSRTimer_005_ms short005ms(clk, rstBtn, pulseOut);

  One_mSecondTimer one_ms(pulseOut, pulseOnems, rLED);

  reconfigTmr8B rTmrfifthSec(pulseOnems, 200, pulseFifthS);
  
  reconfigTmr8B rTmrOneSec(pulseFifthS, 5, gLED);
endmodule
