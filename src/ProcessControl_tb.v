//sikender

//test bench for the process control 
// we want to see proper state transitions 
`timescale 1 ns / 1 ns

module ProcessControl_tb(); 
	reg [0:0] clk, rst; 

	reg [2:0] _buttons; 
	reg [0:0] _access_control_fb,
			  _game_fb, 
			  _scoreboard_fb;

	wire [2:0] _buttons_select;
	wire [0:0] _switches_select; 
	wire [2:0] _lcd_select;
	wire [3:0] _game_score_select;
	wire [1:0] _led_control;
	wire [15:0] _userID;

	ProcessControl pc(
		.clk(clk), 
		.rst(rst), 
		.buttons(_buttons),
		.access_control_fb(_access_control_fb), 
		.game_fb(game_fb), 
		.scoreboard_fb(_scoreboard_fb), 
		.buttons_select(_buttons_select),
		.switches_select(_switches_select),
		.lcd_control(_lcd_select),
		.led_control(_led_control),  
		.userid(_userID),
		.game_score_select(_game_score_select)); 


	always begin
		#10 clk = ~clk; 
	end 

	initial begin
		$monitor("time:[%0t], buttons:[%b], \
			access_control_fb:[%b], \
			game_fb:[%b], \
			scoreboard_fb:[%b], \
			buttons_select:[%b], \
			switches_select:[%b], \
			game_score_select:[%b],\
			lcd_control:[%b], \
			led_control:[%b], \
			userid:[%b]",
			$time, 
			_buttons,
			_access_control_fb, 
			_game_fb, 
			_scoreboard_fb, 
			_buttons_select, 
			_switches_select, 
			_game_score_select,
			_lcd_select, 
			_led_control, 
			_userID,  
			_output); 

		clk = 1; rst = 1; 
//		#10 @(posedge clk) 
	end
endmodule 

/* 
canary test : [ ] 
test init state initalization : [ ]
test does it stay in access control no feedback: [ ]
test does it stay in access control if feedback 0: [ ]
test does it stay in access control if feedback 1: [ ] 
test transition state if buttons all 0: [ ] 


*/