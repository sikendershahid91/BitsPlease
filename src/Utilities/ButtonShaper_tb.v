//sikender
// testing shaping of more than one button 

`timescale 1 ns / 1 ns

module ButtonShaper_tb(); 
	reg [0:0] clk, rst; 
	reg [2:0] _input; 
	wire[2:0] _output;

	ButtonShaper b1(clk, _input[0], _output[0]), 
				 b2(clk, _input[1], _output[1]),
				 b3(clk, _input[2], _output[2]);

	always begin
		#10 clk = ~clk; 
	end 

	initial begin
		$monitor("time:[%0t], input:[%b], output:[%b]",
			$time, 
			_input, 
			_output); 
		clk = 1; rst = 1; 
		@(posedge clk) #10 _input = 3'b111;
		@(posedge clk) #10 _input = 3'b000; 
		@(posedge clk) #30 _input = 3'b111;  
		@(posedge clk) #10 _input = 3'b010; 
		@(posedge clk) #30 _input = 3'b111; 
	end
endmodule 