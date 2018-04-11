`timescale 1 ns / 1 ns

module TEST_password_read();
	reg  [0:0]  clk, rst, Data_In_Load; 
	reg  [15:0] Data_In;
	reg  [1:0]  Request; 
	wire [2:0]  Status; 

 	AccessControl AC(
 		.clk(clk), 
 		.rst(rst), 
 		._Request(Request), 
 		._Data_In(Data_In),
 		._Data_In_Load(Data_In_Load), 
 		._Status_Frame(Status)); 

	always begin 
		#10 clk = ~clk; 
	end
	initial begin 
		clk  = 1; 
		rst  = 0; 
		#10 @ (posedge clk) rst = 1; 
		
	end

endmodule 
module AccessControl_TEST_BENCH();
	TEST_password_read test1(); 
endmodule


