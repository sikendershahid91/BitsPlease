

module AccessControlFsm2(
	input [0:0] clk, 
	input [0:0] rst, 
	input [16:0] _Data_In, 
	input [0:0]  _Data_In_Load, 
	input [15:0] _Memory_In, 
	output reg [0:0] Access_Grant, 
	output reg [15:0] Address, 
	output reg [0:0]  wren, 
	output reg [15:0] Data_Out);  

	reg [0:0] Invalid_Input_Flag;
	reg [0:0] Password_Change_Flag; 
	reg [15:0] Password_User_Reg; 
	reg [15:0] Password_Memory_Reg;  

	reg [2:0] State; 
	reg [1:0] Fail_Count;

	parameter 
		INIT   =0, 
		GETPASSWORD =1, 
		DELAY0 =2,  
		LOADPASSWORD =3, 
		CHECK  =4, 
		ACCESS =5, 
		CHANGE =6; 

	always @ (posedge clk) begin
		if(rst == 0) begin
			State <= INIT;
		end  
		case(State)
			INIT: begin
				Access_Grant <= 0; 
				Address <= 0; 
				Invalid_Input_Flag <= 0; 
				Password_Change_Flag <= 0; 
				Password_User_Reg <= 0; 
				Password_Memory_Reg <= 0; 
				Fail_Count <= 0;
				wren <= 0; 
				if(_Data_In_Load !== 1) begin
					State <= INIT; 
				end else begin
					State 	<= GETPASSWORD; 
					{Password_Change_Flag, Address} <= _Data_In_Load; 
				end
			end
			GETPASSWORD: begin
				State <= DELAY0; 
			end
			DELAY0: begin
				if(_Data_In_Load !== 1) begin
					State <= DELAY0;
				end else begin
					State <= LOADPASSWORD; 
				end
			end
			LOADPASSWORD: begin
				Password_User_Reg <= _Data_In; 
				Password_Memory_Reg <= _Memory_In; 
				State <= CHECK; 
			end
			CHECK: begin
				Invalid_Input_Flag <= (Password_User_Reg ^ Password_Memory_Reg)?1:0; 
				State <= ACCESS; 
			end
			ACCESS: begin
				if(Invalid_Input_Flag == 1 && Fail_Count != 3) begin
					State <= GETPASSWORD; 
					Fail_Count <= Fail_Count + 1'b1; 
				end else if(Invalid_Input_Flag == 1 && Fail_Count == 3) begin
					State <= ACCESS; 
					Access_Grant <=0;  
				end else if(Password_Change_Flag === 1'b1) begin
					State <= CHANGE; 
				end else begin
					State <= ACCESS; 
					Access_Grant <=1; 
				end
			end
			CHANGE: begin
				 if(_Data_In_Load !== 1'b1) begin
				 	State <= CHANGE;
				 	wren <= 1;
				 	Password_User_Reg <= _Data_In_Load;   
				 end else begin
				 	// write new password 
				 	Data_Out <= Password_User_Reg; 
				 	State <= INIT; 
				 end
			end
			default: begin
				State <= INIT; 
			end
		endcase 
	end
endmodule 