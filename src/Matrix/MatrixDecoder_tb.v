`timescale 1 ns / 1 ns

module MatrixDecoder_tb();

	reg [0:0] clk; 
	reg [7:0] matrix[7:0]; 


	/* 

	use this input to test your LED matrix 
	mondify the delay as needed. 

	{matrix[7],matrix[6],matrix[5],matrix[4],matrix[3],matrix[2],matrix[1],matrix[0]}

	*/

	always begin
		#10 clk = ~clk; 
	end
	initial begin
		$monitor("[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n****************", 
			matrix[0],
			matrix[1],
			matrix[2],
			matrix[3], 
			matrix[4], 
			matrix[5],
			matrix[6],
			matrix[7]); 
		clk =1;  
		matrix[0] = 8'b00000000; 
		matrix[1] = 8'b00000000;
		matrix[2] = 8'b00000000;
		matrix[3] = 8'b00000000;
		matrix[4] = 8'b00000000;
		matrix[5] = 8'b00000000;
		matrix[6] = 8'b00000000; 
		matrix[7] = 8'b00000000;

		

		#10 @(posedge clk)  
		matrix[7] = 8'b00111100;
		#10 @(posedge clk) 
		matrix[6] = 8'b00111100; 
		#10 @(posedge clk) 
		matrix[5] = 8'b00011100;
		#10 @(posedge clk) 
		matrix[4] = 8'b00011000;
		#10 @(posedge clk) 
		matrix[3] = 8'b00011000;
		#10 @(posedge clk) 
		matrix[2] = 8'b00001000;
		#10 @(posedge clk)  
		matrix[1] = 8'b00001000;
		#10 @(posedge clk) 
		matrix[0] = 8'b00001000; 


	end

endmodule




/*

write up matrix 
*/
