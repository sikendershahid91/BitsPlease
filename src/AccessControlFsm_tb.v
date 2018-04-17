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
		$display("Current State : %d , Access : %b", fsm1.State, _Access_Grant); 
	end

	initial begin
		clk = 1; 
		rst = 0; 
		Request = 2'b00; 
		#10 @(posedge clk) rst =1; 
		#10 @(posedge clk) Data_In_Load = 1; Data_In = 16'h1476;
		#10 @(posedge clk) Data_In_Load = 0; 
		#10 @(posedge clk) Memory_Data_In = 16'h4789;
		#30 @(posedge clk) Data_In_Load = 1; Data_In = 16'h4789;
		// # @(posedge clk) Data_In_Load = 0; 
	end
endmodule


module AccessControlFsm_tb(); 
	TEST_State_transitions test1(); 
endmodule 