 `timescale 1ns/100ps

 module LEDMatrixController_Top_tb();

 reg clk, rst, enable;
 reg [63:0] matrixIn;

 wire [7:0] rowOut, colOut;
 wire ready;

 LEDMatrixControllerTop LEDMatrixControllerTop_DUT(clk, rst, matrixIn, enable, rowOut, colOut, ready);
 always
 	begin
 		#10 clk = 0;
 		#10 clk = 1;
 	end

 initial
 	begin
 		enable = 0;
 		matrixIn = 64'd0;
 		#3 rst = 0;
 		#40 rst = 1; 		
 	end

endmodule
