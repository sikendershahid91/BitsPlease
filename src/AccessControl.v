// ECE5440
// Sikender Shahid 1476
// Description: Access Control module compares 
// input passwords with stored password in the rom. 
// the comparator performs operation on 4bit values 
// with 4 entries in the ROM

module AccessControl(
	input clk, 
	input rst, 
	input [1:0]  _Request, 
	input [15:0] _Data_In, 
	input [0:0]  _Data_In_Load, 
	output[1:0]  _Status_Frame); 
// notes
// if access grant -0 than led redd 

endmodule 
