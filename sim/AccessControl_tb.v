`timescale 1 ns / 1 ns

module AccessControl_tb();
	
	reg [0:0] clk, rst, Data_In_Load; 
	reg [15:0] Data_In; 
	reg [1:0] Request;

	wire [2:0] Status_Frame; 
	AccessControl AC(
		.clk(clk), 
		.rst(rst), 
		._Request(Request), 
		._Data_In(Data_In), 
		._Data_In_Load(Data_In_Load), 
		._Status_Frame(Status_Frame)
		); 

	always begin
		#10 clk = ~clk; 
	end



	initial begin

		$monitor("UserLoadValue:[%h] , Status_Frame:[%b]",
			AC._Data_In, AC._Status_Frame); 
		clk = 1; 
		rst = 0; 
		Request = 2'b01; 
		#10 @ (posedge clk) rst = 1; 
		#10 @(posedge clk) Data_In_Load = 1; Data_In = 16'h1476;
		#30 @(posedge clk) Data_In_Load = 0; 
		#10 @(posedge clk) Data_In_Load = 1; Data_In = 16'h2456;
		#30 @(posedge clk) Data_In_Load = 0; 
		#10 @(posedge clk) Data_In_Load = 1; Data_In = 16'hAAAA;
		#30 @(posedge clk) Data_In_Load = 0;
		 Request = 2'b00;
		#20 @(posedge clk) Data_In_Load = 1; Data_In = 16'h1476;
		#30 @(posedge clk) Data_In_Load = 0;
		#20 @(posedge clk) Data_In_Load = 1; Data_In = 16'hAAAA;
		#30 @(posedge clk) Data_In_Load = 0; 
		

	end

endmodule


