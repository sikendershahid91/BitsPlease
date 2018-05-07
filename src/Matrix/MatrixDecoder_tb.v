`timescale 1 ns / 1 ns

module MatrixDecoder_tb();

	reg {0:0] clk; 
	reg [7:0] matrix[7:0]; 

	always begin
		#10 clk = ~clk; 
	end
	initial begin
		$monitor("[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n[%b]\n[%b]", 
			matrix[0],
			matrix[1],
			matrix[2],
			matrix[3], 
			matrix[4], 
			matrix[5],
			matrix[6],
			matrix[7]); 
		clk =1; 

		#10 (posedge clk) matrix = 1; 
		
	end

endmodule




/*

write up matrix 
*/
