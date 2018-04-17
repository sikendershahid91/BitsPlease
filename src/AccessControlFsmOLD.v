
module AccessControlFsm(
	input [0:0] clk, 
	input [0:0] rst, 
	input [15:0] _Data_In, 
	input [0:0]  _Data_In_Load,
	input [15:0] _Memory_Data_In, 
	input [1:0]  _Request, // stall 11 / change password 01 / access password 00     
	output reg [0:0]  Access_Grant,
	output reg [15:0] Address, 
	output reg [0:0]  wren,
	output reg [15:0] Data_Out);

	reg [0:0] Invalid_Input_Flag;
	reg [0:0] Password_Change_Flag; 
	reg [15:0] Password_User_Reg; 
	reg [15:0] Password_Memory_Reg;   

	parameter
		INIT   =0, 
		REQUEST=1, 
		ENTER  =2, 
		DELAY0 =3, 
		DELAY1 =4, 
		LOAD   =5, 
		CHECK  =6, 
		CHANGE =7, 
		ACCESS =8, 
		GRANT  =9;

	reg [3:0] State; 
	reg [1:0] Fail_Count; 

	always @(posedge clk) begin
		if (rst == 0) begin
			// reset
			State <= INIT; 
		end
		else begin
			case(State)
				INIT: begin
					Invalid_Input_Flag <= 0; 
					Password_Change_Flag <= 0; 
					Access_Grant <= 0; 
					// Address <= 0; 
					wren <= 0; 
					State <= REQUEST; 	
				end
				REQUEST: begin
					if (_Request[1] !== 1'b0)begin
						State <= REQUEST; 
					end else begin
						State <= ENTER; 
					end
				end
				ENTER: begin
					if(_Data_In_Load == 1)begin // shaped 
						Address <=_Data_In; 
						State <= DELAY0; 
					end	else begin
						State <= ENTER; 
					end
				end
				DELAY0: begin
					State <= DELAY1;
				end
				DELAY1: begin
					if(_Data_In_Load == 1) begin
						State <= LOAD; 
					end else begin
						State <= DELAY1; 
					end
				end
				LOAD: begin
					Password_User_Reg <= _Data_In; 
					Password_Memory_Reg <= _Memory_Data_In;				
					if(Password_Change_Flag == 1) begin
						wren <=1; 
						State <= CHANGE; 
					end else begin
						State <= CHECK; 
					end
				end
				CHECK: begin
					Invalid_Input_Flag <= (Password_User_Reg ^ Password_Memory_Reg)? 1:0; 
					Password_Change_Flag <=(_Request[0] == 1)? 1 - Password_Change_Flag:0; 
					State <= ACCESS; 
				end
				ACCESS: begin
					if (Invalid_Input_Flag == 1 && Fail_Count !== 2'd3) begin 
						Invalid_Input_Flag <=0; 
						Fail_Count <= Fail_Count + 1'b1; 
						State <= ENTER;
					end else if (Invalid_Input_Flag == 1 && Fail_Count === 2'd3) begin
						State <= GRANT; 
					end else if (Password_Change_Flag == 1) begin
						State <= DELAY1; 
					end else begin
						State <= GRANT; 
					end
				end
				GRANT: begin
					if (Invalid_Input_Flag == 1) begin
						State <= GRANT; 
						Access_Grant <= 0; 
					end else begin
						State <= GRANT; 
						Access_Grant <= 1; 
					end
				end
				CHANGE: begin
					Data_Out <= Password_User_Reg; 
					wren <= 0; 
					State <= INIT; 
					// note: toggle flag after changing password 
					// note.1: dont need to because its toggled in check 
				end
			endcase
		end
	end
endmodule 
