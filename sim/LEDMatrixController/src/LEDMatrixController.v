/*
ROW1 = [63:56]
ROW2 = [55:48]
ROW3 = [47:40]
ROW4 = [39:32]
ROW5 = [31:24]
ROW6 = [23:16]
ROW7 = [15:8]
ROW8 = [7:0]
*/


module LEDMatrixController(matrixIn, enable, timePulseIn, rowOut, colOut, ready, clk, rst);

	input [63:0] matrixIn;
	input clk, rst, enable, timePulseIn;
	output [7:0] rowOut, colOut;
	output ready;

	reg [3:0] State;
	reg [3:0] stateCounter;
	reg [63:0] savedMatrixIn;
	reg [7:0] rowOut, colOut;
	reg ready;

	parameter INIT = 0, SETROW1 = 1, SETROW2 = 2, SETROW3 = 3, SETROW4 = 4, SETROW5 = 5, SETROW6 = 6, SETROW7 = 7, SETROW8 = 8, END = 9, WAIT = 10;
	always @(posedge clk)
		begin
			if(rst == 0)
				begin//					 1111111111111111111111111111111111111111111111111111111111111111
					 //					 1010101001010101101010100101010110101010010101011010101001010101
					savedMatrixIn <= 64'b1111111111111111111111111111111111111111111111111111111111111111;
					rowOut <= 8'b0;
					colOut <= 8'bz;
					ready <= 1;
					State <= INIT;
					stateCounter <= 0;
					
				end
			else 
				begin
					if(enable == 1 && ready == 1)
						begin
							//savedMatrixIn <= matrixIn;
						end
					else
						begin
							case(State)
								INIT:
									begin
										rowOut <= 8'b0;
										colOut <= 8'bz;
										ready <= 0;
										stateCounter <= 1;
										State <= stateCounter;
									end
								SETROW1:
									begin
										rowOut <= savedMatrixIn[63:56];
										colOut <= 8'b0zzzzzzz;
										stateCounter <= stateCounter + 1;
										State <= WAIT;
									end
								SETROW2:
									begin
										rowOut <= savedMatrixIn[55:48];
										colOut <= 8'bz0zzzzzz;
										stateCounter <= stateCounter + 1;
										State <= WAIT;
									end
								SETROW3:
									begin
										rowOut <= savedMatrixIn[47:40];
										colOut <= 8'bzz0zzzzz;
										stateCounter <= stateCounter + 1;
										State <= WAIT;
									end
								SETROW4:
									begin
										rowOut <= savedMatrixIn[39:32];
										colOut <= 8'bzzz0zzzz;
										stateCounter <= stateCounter + 1;
										State <= WAIT;
									end
								SETROW5:
									begin
										rowOut <= savedMatrixIn[31:24];
										colOut <= 8'bzzzz0zzz;
										stateCounter <= stateCounter + 1;
										State <= WAIT;
									end
								SETROW6:
									begin
										rowOut <= savedMatrixIn[23:16];
										colOut <= 8'bzzzzz0zz;
										stateCounter <= stateCounter + 1;
										State <= WAIT;
									end
								SETROW7:
									begin
										rowOut <= savedMatrixIn[15:8];
										colOut <= 8'bzzzzzz0z;
										stateCounter <= stateCounter + 1;
										State <= WAIT;
									end
								SETROW8:
									begin
										rowOut <= savedMatrixIn[7:0];
										colOut <= 8'bzzzzzzz0;
										stateCounter <= stateCounter + 1;
										State <= WAIT;
									end
								WAIT:
									begin
										if(timePulseIn == 1)//some condition to wait set delay
											begin
												State <= stateCounter;
											end
										else 
											begin
												State <= WAIT;
											end
									end
								END:
									begin
										rowOut <= 8'b0;
										colOut <= 8'bz;
										ready <= 1;
										State <= INIT;
									end
								default:
									begin
										State <= INIT;									
									end								
							endcase
						end
				end
		end
endmodule
