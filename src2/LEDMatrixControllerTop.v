
module LEDMatrixControllerTop(clk, rst, matrixIn, rowOut, colOut);
	input clk, rst;
	output[7:0] rowOut, colOut;
	input [63:0] matrixIn;
	wire microsecondTimeout, hundredMicrosecondTimeout, millisecondTimeout, hundredMillisecondTimeout, secondTimeout;

	microsecondTimer microsecondTimer_1(clk, rst, microsecondTimeout);
	hundredMicrosecondTimer hundredMicrosecondTimer_1(microsecondTimeout, clk, rst, hundredMicrosecondTimeout);
	millisecondTimer millisecondTimer_1(hundredMicrosecondTimeout, clk, rst, millisecondTimeout);
	hundredMillisecondTimer hundredMillisecondTimer_1(millisecondTimeout, clk, rst, hundredMillisecondTimeout);
	secondTimer secondTimer_1(hundredMillisecondTimeout, clk, rst, secondTimeout);

	//MockMatrixStream MockMatrixStream_1(hundredMillisecondTimeout, rst, matrixIn);

	LEDMatrixController LEDMatrixController_1(matrixIn, millisecondTimeout, rowOut, colOut, clk, rst);

endmodule

//sikender -  might face syn problems with the game 