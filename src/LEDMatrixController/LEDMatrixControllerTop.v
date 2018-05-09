
module LEDMatrixControllerTop(start, stopBtn, clk, rst, rowOut, colOut, gLED, doneLED);
	input clk, rst;
	input stopBtn;
	input start;

	output[7:0] rowOut, colOut;
	wire [63:0] matrixIn;
	wire microsecondTimeout, hundredMicrosecondTimeout, millisecondTimeout, hundredMillisecondTimeout, secondTimeout;

	wire [7:0] newBlockLoc[7:0];
	wire pulseOut;
	wire pulseOnems;
	wire pulseFifthS;
	wire [7:0] segOut;
	output gLED, doneLED;

	wire [7:0] startNext;

	microsecondTimer microsecondTimer_1(clk, rst, microsecondTimeout);
	hundredMicrosecondTimer hundredMicrosecondTimer_1(microsecondTimeout, clk, rst, hundredMicrosecondTimeout);
	millisecondTimer millisecondTimer_1(hundredMicrosecondTimeout, clk, rst, millisecondTimeout);
	hundredMillisecondTimer hundredMillisecondTimer_1(millisecondTimeout, clk, rst, hundredMillisecondTimeout);
	secondTimer secondTimer_1(hundredMillisecondTimeout, clk, rst, secondTimeout);

//	MockMatrixStream MockMatrixStream_1(hundredMillisecondTimeout, rst, matrixIn);

	LEDMatrixController LEDMatrixController_1(matrixIn, millisecondTimeout, rowOut, colOut, clk, rst);

	LFSRTimer_005_ms short005ms(clk, rst, pulseOut);
	One_mSecondTimer one_ms(pulseOut, pulseOnems);

	reconfigTmr8B rTmrfifthSec(pulseOnems, 200, pulseFifthS);
	reconfigTmr8B rTmrOneSec(pulseFifthS, 5, gLED);

//	BlockShift BS1(startSw, stopBtn, gLED, segOut);
	BlockShift BS0(start, 0, stopBtn, gLED, newBlockLoc[0], startNext[0]);
	BlockShift BS1(startNext[0], newBlockLoc[0], stopBtn, gLED, newBlockLoc[1], startNext[1]);
	BlockShift BS2(startNext[1], newBlockLoc[1], stopBtn, gLED, newBlockLoc[2], startNext[2]);
	BlockShift BS3(startNext[2], newBlockLoc[2], stopBtn, gLED, newBlockLoc[3], startNext[3]);
	BlockShift BS4(startNext[3], newBlockLoc[3], stopBtn, gLED, newBlockLoc[4], startNext[4]);
	BlockShift BS5(startNext[4], newBlockLoc[4], stopBtn, gLED, newBlockLoc[5], startNext[5]);
	BlockShift BS6(startNext[5], newBlockLoc[5], stopBtn, gLED, newBlockLoc[6], startNext[6]);
	BlockShift BS7(startNext[6], newBlockLoc[6], stopBtn, gLED, newBlockLoc[7], doneLED);

	assign matrixIn = {newBlockLoc[0], newBlockLoc[1], newBlockLoc[2], newBlockLoc[3], newBlockLoc[4], newBlockLoc[5], newBlockLoc[6], newBlockLoc[7]};
endmodule
