

module Test_password_match_in_RAM_ROM()
	reg [15:0] Address, Data_In; 
	reg clk, wren; 
	wire [15:0] Data_RAM, Data_ROM;  

	ROMPassword ROM(
	_Address(Address),
	clk(clk), 
	_Data(Data_ROM)); 

	RAMPassword RAM(
	clk(clk), 
	_Address(Address), 
	_Data_In(Data_In, 
	wren(wren) , 
	_Data_Out(Data_RAM)); 

	always begin 
		#10 clk = ~clk; 
	end

	always begin
		#10 @(posedge clk) Address = Address + 1'h1;  
	end

	initial begin 
		clk  = 1; Address = 16'h0000;
		wren = 0; Data_In = 16'hAAAA; 
	end
endmodule 

module ROM_RAM_TEST_BENCH(); 
	Test_password_match_in_RAM_ROM test();
endmodule