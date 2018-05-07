module TetrisTestTop(clk, rstBtn, stopBtn, rLED, gLED, segOut);
  input clk, rstBtn;
  input stopBtn;
  output [7:0] segOut;
  output gLED, rLED;

  // reg clockVal; //= 200;
  wire [7:0] newBlockLoc;
  wire pulseOut;
  wire pulseOnems;
  wire pulseFifthS;
  wire stopBtnOut;
  // tempTime = clockVal;
  LFSRTimer_005_ms short005ms(clk, rstBtn, pulseOut);
  One_mSecondTimer one_ms(pulseOut, pulseOnems, rLED);

  // SpeedyLevels spd(stacked, tempTime, shortenedTime);
//  button_shaper btnShaper(stopBtn, stopBtnOut, pulseFifthS, rstBtn);
  // assign tempTime = shortenedTime;

  reconfigTmr8B rTmrfifthSec(pulseOnems, 200, pulseFifthS);
  reconfigTmr8B rTmrOneSec(pulseFifthS, 5, gLED);
//  reconfigTmr8B rTmrfifthSec(pulseOnems, 1, pulseFifthS);
//  reconfigTmr8B rTmrOneSec(pulseFifthS, 1, gLED);

  BlockShift BS1(8'b10000000, stopBtn, pulseFifthS, newBlockLoc);
  SegRunner SR1(newBlockLoc, segOut);
endmodule
