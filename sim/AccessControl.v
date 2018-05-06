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
	input [16:0] _Data_In, 
	input [0:0]  _Data_In_Load, 
	output wire [2:0]  _Status_Frame); 
// notes
// if access grant -0 than led redd 
	
	wire [15:0] ROM_data_wire; 
	wire [15:0] RAM_data_wire;
	wire [15:0] FSM_data_wire; 
	wire [15:0] Address_Wire; 
	wire [0:0] Access_Grant_wire, wren_wire; 
	wire [15:0] Memory_data_wire; 

	assign Memory_data_wire = (ROM_data_wire ^ RAM_data_wire)?
								RAM_data_wire:
								ROM_data_wire;

	ROMPassword ROM(
		._Address(Address_Wire), 
		.clk(clk), 
		._Data(ROM_data_wire));

	RAMPassword RAM(
		.clk(clk),
		._Address(Address_Wire), 
		._Data_In(FSM_data_wire), 
		.wren(wren_wire), 
		._Data_Out(RAM_data_wire));
	
	AccessControlFsm FSM(
		.clk(clk),
		.rst(rst), 
		._Data_In(_Data_In), 
		._Data_In_Load(_Data_In_Load), 
		._Memory_Data_In(Memory_data_wire), 
		.Access_Grant(Access_Grant_wire),
		.Address(Address_Wire), 
		.wren(wren_wire),
		.Data_Out(FSM_data_wire));  

	assign _Status_Frame = {2'b11,Access_Grant_wire}; // need to be changed

endmodule 
