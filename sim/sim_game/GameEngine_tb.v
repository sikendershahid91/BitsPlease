`timescale 1 ps/1 ps

module GameEngine_tb();
	reg clk, rstBtn;
	reg dropBtn;
	reg timer;
	
	wire EOG;
	
	GameEngine DUT_GameEngine(clk, rstBtn, dropBtn, timer,
		lineDisplay, EOG);
	
	always begin
		#10 clk = 1;
		#10 clk = 0;
	end
	
	initial begin 
		// reset push
		
		timer = 0;			// Timer start at 0
		dropBtn = 0;		// player input
		// Linenum = 0;
		#50
		timer = 1;			// countX <= 1;  1 cyle, timer = 1;
		#20
		timer = 0;			// Timer = 0 for another 5 cycles
		#50
		timer = 1;			//  countX <= 2;  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 3;  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 4;  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 5;  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 6;  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 7; direction <= 1,  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 6;  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 5;  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 4;  1 cyle, timer = 1;
		#20
		timer = 0;
		#10
		dropBtn = 1;		// dropBtn being pushed breaks from the MOVE state
		#20
		dropBtn = 0; 		// dropBtn cycle is done, stackPos <= xCount, 4
		#100				//	Move to Update	lineNum <= 1; xcount <= 0;
		// Line = 1
		timer = 1;			// countX <= 1;  1 cyle, timer = 1;
		#20
		timer = 0;			// Timer = 0 for another 5 cycles
		#50
		timer = 1;			//  countX <= 2;  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 3;  1 cyle, timer = 1;
		#20
		timer = 0;
		#50
		timer = 1;			//  countX <= 4;  1 cyle, timer = 1;
		#20
		timer = 0;
		#10
		dropBtn = 1;		// dropBtn being pushed breaks from the MOVE state
		#20
		dropBtn = 0; 		// dropBtn cycle is done, stackPos <= xCount, 4
			
	end
endmodule 
