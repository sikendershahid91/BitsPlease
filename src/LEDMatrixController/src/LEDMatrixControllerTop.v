
module LEDMatrixControllerTop(clk, rst, matrixIn, enable, rowOut, colOut, ready);
	input clk, rst, enable;
	input [63:0] matrixIn;

	output[7:0] rowOut, colOut;
	output ready;


	wire microsecondTimeout, hundredMicrosecondTimeout, millisecondTimeout, hundredMillisecondTimeout, secondTimeout;

	microsecondTimer microsecondTimer_1(clk, rst, microsecondTimeout);
	hundredMicrosecondTimer hundredMicrosecondTimer_1(microsecondTimeout, clk, rst, hundredMicrosecondTimeout);
	millisecondTimer millisecondTimer_1(hundredMicrosecondTimeout, clk, rst, millisecondTimeout);
	hundredMillisecondTimer hundredMillisecondTimer_1(millisecondTimeout, clk, rst, hundredMillisecondTimeout);
	secondTimer secondTimer_1(hundredMillisecondTimeout, clk, rst, secondTimeout);

	LEDMatrixController LEDMatrixController_1(matrixIn, enable, secondTimeout, rowOut, colOut, ready, clk, rst);

endmodule
