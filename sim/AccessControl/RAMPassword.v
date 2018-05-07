// ECE 5440 
// Sikender Shahid 1476
// description: RAM module generated through Quartus

module RAMPassword(
	clk, 
	_Address, 
	_Data_In, 
	wren, 
	_Data_Out); 

	input clk, wren; 
	input [15:0] _Address, _Data_In; 
	output [15:0] _Data_Out; 

	wire [15:0] _Data_Out_wire; 
	wire [15:0] _Data_Out = _Data_Out_wire[15:0]; 

	`ifndef ALTERA_RESERVED_QIS
	// synopsys translate_off
	`endif
		tri1	  clock;
	`ifndef ALTERA_RESERVED_QIS
	// synopsys translate_on
	`endif

	altsyncram	altsyncram_component (
				.address_a (_Address),
				.clock0 (clk),
				.data_a (_Data_In),
				.wren_a (wren),
				.q_a (_Data_Out_wire),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.address_b (1'b1),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.clock1 (1'b1),
				.clocken0 (1'b1),
				.clocken1 (1'b1),
				.clocken2 (1'b1),
				.clocken3 (1'b1),
				.data_b (1'b1),
				.eccstatus (),
				.q_b (),
				.rden_a (1'b1),
				.rden_b (1'b1),
				.wren_b (1'b0));

	defparam
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.init_file = "Password.mif",
		altsyncram_component.intended_device_family = "Cyclone IV E",
		altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 65536,
		altsyncram_component.operation_mode = "SINGLE_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_reg_a = "CLOCK0",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.read_during_write_mode_port_a = "DONT_CARE",
		altsyncram_component.widthad_a = 16,
		altsyncram_component.width_a = 16,
		altsyncram_component.width_byteena_a = 1;

endmodule  