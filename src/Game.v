module Game(
	input [0:0] clk, // timer
	input [0:0] rst,
	input [2:0] buttons,
	input [15:0] userid,
	input [1:0] gamestate,
	output reg [0:0] game_eog,
	//output reg [7:0] timer_reconfig_fb,
	output [63:0] game_display,
	output [31:0] game_data,
	output rLED);
	
	wire pulseOut;
	wire oneSecPulse;
	wire pulseOnems;
	wire pulseFifthS;
	
	LFSRTimer_005_ms short005ms(clk, rstBtn, pulseOut);
	One_mSecondTimer one_ms(pulseOut, pulseOnems, rLED);

	reconfigTmr8B rTmrfifthSec(pulseOnems, 200, pulseFifthS);
	reconfigTmr8B rTmrOneSec(pulseFifthS, 5 , oneSecPulse);
	
	GameStacker Tetris(
		oneSecPulse, // timer
		rst,
		buttons,
		userid,
		gamestate,
		game_eog,
		//output reg [7:0] timer_reconfig_fb,
		game_display,
		game_data);
endmodule
