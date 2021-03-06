module TetrisTestTop(startSw, stacked, clk, rstBtn, stopBtn, rLED, doneLED, outputStream);
  input stacked;
  input clk, rstBtn;
  input stopBtn;
  input startSw;
  // reg [7:0] segOut[7:0];
  output rLED;
  output doneLED;
  output [63:0] outputStream;

  wire [7:0] startNext;
  wire [7:0] newBlockLoc[7:0];
  wire pulseOut;
  wire pulseOnems;
  wire pulseFifthS;
  wire stopBtnOut;
  wire [7:0] shortenedTime;
  wire endTimer;
  LFSRTimer_005_ms short005ms(clk, rstBtn, pulseOut);
  One_mSecondTimer one_ms(pulseOut, pulseOnems, rLED);

  SpeedyLevels spd(clk, stacked, shortenedTime);

  reconfigTmr8B rTmrQuick(pulseOut, shortenedTime, pulseQuick);
  reconfigTmr8B rTmrMul(pulseQuick, 5, endTimer);

  //ALL BS instances can be on the same clock signal as they subsequent are paused and not shown.
  BlockShift BS0(startSw, 8'b10000000, stopBtn, endTimer, newBlockLoc[0], startNext[0]);
  BlockShift BS1(startNext[0], 8'b10000000, stopBtn, endTimer, newBlockLoc[1], startNext[1]);
  BlockShift BS2(startNext[1], 8'b10000000, stopBtn, endTimer, newBlockLoc[2], startNext[2]);
  BlockShift BS3(startNext[2], 8'b10000000, stopBtn, endTimer, newBlockLoc[3], startNext[3]);
  BlockShift BS4(startNext[3], 8'b10000000, stopBtn, endTimer, newBlockLoc[4], startNext[4]);
  BlockShift BS5(startNext[4], 8'b10000000, stopBtn, endTimer, newBlockLoc[5], startNext[5]);
  BlockShift BS6(startNext[5], 8'b10000000, stopBtn, endTimer, newBlockLoc[6], startNext[6]);
  BlockShift BS7(startNext[6], 8'b10000000, stopBtn, endTimer, newBlockLoc[7], doneLED);

  assign outputStream = {newBlockLoc[0], newBlockLoc[1], newBlockLoc[2], newBlockLoc[3], newBlockLoc[4], newBlockLoc[5], newBlockLoc[6], newBlockLoc[7]};
endmodule
