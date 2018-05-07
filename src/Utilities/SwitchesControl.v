// sikender 

module SwitchesControl(
	input [0:0] control, 
	input [17:0]switches_in, 
	output[17:0]switches_out); 
	
	assign switches_out = (control)? switches_in : 18'b0;

endmodule 