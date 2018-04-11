`timescale 1 ns / 1 ns

module TEST_State_transitions(); 
	reg [0:0]  clk, rst, Data_In_Load; 
	reg [15:0] Data_In, Memory_Data_In; 
	reg [1:0]  Request; 

	//output signals
	wire [0:0]  _Access_Grant, _wren; 
	wire [15:0] _Address, _Data_Out; 

	AccessControlFsm fsm1(
		.clk(clk),
		.rst(rst), 
		._Data_In(Data_In), 
		._Data_In_Load(Data_In_Load), 
		._Memory_Data_In(Memory_Data_In), 
		._Request(Request), 
		.Access_Grant(_Access_Grant),
		.Address(_Address), 
		.wren(_wren),
		.Data_Out(_Data_Out)); 

	always begin
		#10 clk = 1 - clk; 
	end

	always @ (fsm1.State) begin
		$display("Current State : %d", fsm1.State); 
	end

	initial begin
		clk = 1; 
		rst = 0; 
		#10 @(posedge clk) rst =1; 
	end
endmodule


module AccessControlFsm_TEST_BENCH(); 
	TEST_State_transitions test1(); 
endmodule 