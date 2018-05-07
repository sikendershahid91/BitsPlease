//sikender

//test bench for the process control 

module ProcessControl_tb(); 
	reg [0:0] clk, rst; 

	reg []
	reg [2:0] _select; 
	reg [2:0] _buttons; 

	wire[11:0] _output; 

	ButtonDecoder decode(
		_select, 
		_buttons, 
		_output[2:0], 
		_output[5:3], 
		_output[8:6],
		_output[11:9]); 

	always begin
		#10 clk = ~clk; 
	end 

	initial begin
		$monitor("time:[%0t], select:[%b], output:[%b]",
			$time, 
			_select, 
			_output); 

		clk = 1; rst = 1; _buttons = 3'b111; _select = 0; 
		#10 @(posedge clk) _select = 1;
		#10 @(posedge clk) _select = 2; 
		#10 @(posedge clk) _select = 3; 
		#10 @(posedge clk) _select = 4; 
		#10 @(posedge clk) _select = 0; 
	end
endmodule 

endmodule 