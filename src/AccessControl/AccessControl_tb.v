`timescale 1 ns / 1 ns

module AccessControl_tb();
	
	reg [0:0] clk, rst, Data_In_Load;
	reg [17:0] Data_In; 
	wire [0:0] Access_grant; 
	AccessControl AC(
		.clk(clk), 
		.rst(rst),  
		._Data_In(Data_In), 
		._Data_In_Load(Data_In_Load), 
		._Access_grant(Access_grant)
		); 

	always begin
		#10 clk = ~clk; 
	end

	initial begin
		$monitor("time:[%0t],Data:[%h],State:[%d],AddressWire:[%h],Access_grant:[%b]",
		$time,
		Data_In, 
		AC.FSM.State,
		AC.Address_Wire,
		Access_grant);  

		clk = 1; rst = 1;  
		#10 @(posedge clk) Data_In_Load = 1; Data_In = 16'h1476;
		#30 @(posedge clk) Data_In_Load = 0; 
		#10 @(posedge clk) Data_In_Load = 1; Data_In = 16'h2456;
		#30 @(posedge clk) Data_In_Load = 0; 
		// #10 @(posedge clk) Data_In_Load = 1; Data_In = 16'hAAAA;
		// #30 @(posedge clk) Data_In_Load = 0;
		// #20 @(posedge clk) Data_In_Load = 1; Data_In = 16'h1476;
		// #30 @(posedge clk) Data_In_Load = 0;
		// #20 @(posedge clk) Data_In_Load = 1; Data_In = 16'hAAAA;
		// #30 @(posedge clk) Data_In_Load = 0; 
		

	end

endmodule

/* 
changes addition of USERID signal 
	if access grant is true then spit out user id for rest of the game 
any time the game logs out the acces control needs to remove access grant
*/ 


