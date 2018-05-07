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
	wire [1:0] _game_score_select;
	wire [1:0] _led_control;

	ProcessControl pc(
		.clk(clk), 
		.rst(rst), 
		.buttons(_buttons),
		.access_control_fb(_access_control_fb), 
		.game_fb(_game_fb), 
		.scoreboard_fb(_scoreboard_fb), 
		.buttons_select(_buttons_select),
		.switches_select(_switches_select),
		.lcd_control(_lcd_select),
		.led_control(_led_control),  
		.game_score_select(_game_score_select)); 


	always begin
		#10 clk = ~clk; 
	end 

	initial begin
		$monitor("time:[%0t],buttons:[%b],state:[%d],\
access_control_fb:[%b],\
game_fb:[%b],\
scoreboard_fb:[%b],\
buttons_select:[%b],\
switches_select:[%b],\
game_score_select:[%b],\
lcd_control:[%b],\
led_control:[%b]",
		$time, 
		_buttons,
		pc.STATE,
		_access_control_fb, 
		_game_fb, 
		_scoreboard_fb, 
		_buttons_select, 
		_switches_select, 
		_game_score_select,
		_lcd_select, 
		_led_control); 

		clk = 1; rst = 1; 
		#10 @(posedge clk) _buttons = 3'b001;
		#10 @(posedge clk) _buttons = 3'b000;  
		#30 @(posedge clk) _access_control_fb = 1; 
		#10 @(posedge clk) _buttons = 3'b010; 
		#10 @(posedge clk) _buttons = 3'b000;
		#10 @(posedge clk) _access_control_fb = 0; // no effect
		#10 @(posedge clk) _scoreboard_fb = 1; 
		#10 @(posedge clk) _buttons = 3'b110; 
		#10 @(posedge clk) _buttons = 3'b000;

	end
endmodule 

/* 
canary test : [x] 
test init state initalization : [x]
test does it stay in access control no feedback: [x]
test does it stay in access control if feedback 0: [x]
test does it stay in access control if feedback 1: [x] 
test transition state if buttons all 0: [x] 
test if buttons pressed for score board:[x] 
test if buttons pressed together : [x]
test if access feeback changing has any effect : [x] 

*/