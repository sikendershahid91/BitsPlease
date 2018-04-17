`timescale 1 ns / 1 ns

module TEST_State_transitions(); 
	reg [0:0]  clk, rst, Data_In_Load; 
	reg [16:0] Data_In;
	reg [15:0] Memory_Data_In;

	//output signals
	wire [0:0]  _Access_Grant, _wren; 
	wire [15:0] _Address, _Data_Out; 

	AccessControlFsm fsm1(
		.clk(clk),
		.rst(rst), 
		._Data_In(Data_In), 
		._Data_In_Load(Data_In_Load), 
		._Memory_Data_In(Memory_Data_In),  
		.Access_Grant(_Access_Grant),
		.Address(_Address), 
		.wren(_wren),
		.Data_Out(_Data_Out)); 

	always begin
		#10 clk = ~clk; 
	end

	initial begin
		$monitor("time:[%0t us], State:[%d], Fail_Count:[%d], PassUserReg:[%h], PassMemReg:[%h], wren:[%b], Data_Out:[%h]",
			$time, 
			fsm1.State, 
			fsm1.Fail_Count, 
			fsm1.Password_User_Reg, 
			fsm1.Password_Memory_Reg, 
			_wren,
			_Data_Out);

		clk = 1; 
		rst = 0; 
		#10 @(posedge clk) rst =1; 
		#10 @(posedge clk) Data_In_Load = 1; Data_In = 17'h01476;
		#10 @(posedge clk) Data_In_Load = 0; 
		// #10 @(posedge clk) Memory_Data_In = 16'h4789;
		// #30 @(posedge clk) Data_In_Load = 1; Data_In = 16'h4789;
		// # @(posedge clk) Data_In_Load = 0;
	end
endmodule

module AccessControlFsm_tb(); 
	TEST_State_transitions test1(); 
endmodule 