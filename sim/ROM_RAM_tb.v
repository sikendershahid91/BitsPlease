`timescale 1 ns / 1 ns

module TEST_password_match_in_RAM_ROM();
	reg [15:0] Address, Data_In; 
	reg clk, wren; 
	wire [15:0] Data_RAM, Data_ROM;  

	ROMPassword ROM(
	._Address(Address),
	.clk(clk), 
	._Data(Data_ROM)); 

	RAMPassword RAM(
	.clk(clk), 
	._Address(Address), 
	._Data_In(Data_In), 
	.wren(wren) , 
	._Data_Out(Data_RAM)); 

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

module TEST_password_for_USID();
	reg [15:0] Address; 
	reg clk; 
	wire [15:0] Data_ROM_2;  

	ROMPassword ROM(
	._Address(Address),
	.clk(clk), 
	._Data(Data_ROM_2)); 

	always begin 
		#10 clk = ~clk; 
	end

	initial begin 
		$monitor("time:[%0t], Address:[%h], Data_In:[%h]",
			$time,
			ROM._Address, 
			ROM._Data);  

		clk  = 1; 
		Address = 0; 
		#40 @(posedge clk) Address = 16'h1476; 
		#40 @(posedge clk) Address = 16'h6435;
		#40 @(posedge clk) Address = 16'h5095;

	end
endmodule

module ROM_RAM_tb(); 
	TEST_password_match_in_RAM_ROM test();
	TEST_password_for_USID test2(); 

endmodule