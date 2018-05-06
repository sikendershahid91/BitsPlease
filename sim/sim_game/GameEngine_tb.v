`timescale 1 ps/1 ps

module GameEngine_tb();
	reg clk, rstBtn;
	reg dropBtn;
	reg timer;
	
	wire [7:0] lineDisplay;
	wire EOG;
	
	GameEngine DUT_GameEngine(clk, rstBtn, dropBtn, timer,
		lineDisplay, EOG);
	
	always begin
		#10 clk = 1;
		#10 clk = 0;
	end
	
	initial begin 
		// reset push
		#3 rstBtn = 1;
      	@(posedge clk);
      	#5 rstBtn = 0;
 		@(posedge clk);
      	#20 rstBtn = 1;		// reset stays high
		
		@(posedge clk);
		timer = 0;			// Timer start at 0
		dropBtn = 0;		// player input
		// Linenum = 0;
		@(posedge clk);
		#50
		timer = 1;			// countX <= 1;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;			// Timer = 0 for another 5 cycles
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 2;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 3;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 4;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 5;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 6;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 7; direction <= 1,  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 6;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 5;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 4;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#10
		dropBtn = 1;		// dropBtn being pushed breaks from the MOVE state
		#20
		dropBtn = 0; 		// dropBtn cycle is done, stackPos <= xCount, 4
		@(posedge clk);
		#100				//	Move to Update	lineNum <= 1; xcount <= 0;
		// Line = 1
		timer = 1;			// countX <= 1;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;			// Timer = 0 for another 5 cycles
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 2;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 3;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#50
		timer = 1;			//  countX <= 4;  1 cyle, timer = 1;
		@(posedge clk);
		#20
		timer = 0;
		@(posedge clk);
		#10
		dropBtn = 1;		// dropBtn being pushed breaks from the MOVE state
		#20
		dropBtn = 0; 		// dropBtn cycle is done, stackPos <= xCount, 4
			
	end
endmodule 
