//sikender

module ProcessControl(
	input [0:0] clk, 
	input [0:0] rst, 
	input [2:0] buttons,

	//feedback signals 
	input [0:0] access_control_fb, 
	input [0:0] game_fb, 
	input [0:0] scoreboard_fb, 
	
	//hardware signals
	output reg [2:0] buttons_select,
	output reg [0:0] switches_select,
//	output reg [0:0] password_change,

	//lcd & LEDs
	output reg [2:0] lcd_control,
	output reg [3:0] led_control,  

	//score & game
	output reg [15:0] userid,
	output reg [1:0]  game_score_select
	); 

	parameter 
			  INIT=0, 
			  ACCESSCONTROL=1,
			  TRANSITION=2,
	 		  GAME=3,
	 		  SCOREBOARD=4;
	 		  DELAY=5; 

	reg [2:0] STATE;

	always @(posedge clk) begin
		if(!rst) begin
			STATE <= INIT; 
		end
		else begin
			case(STATE)
				INIT: begin
					buttons_select <= 1;
					switches_select <= 0; 
					game_score_select <= 0; 
					lcd_control <= 0; 
					led_control <= 0; 
					userid <= 0; 
					if(buttons[0] == 1) begin
						STATE <= ACCESSCONTROL; 
					end
					else begin
						STATE <= INIT; 
					end
				end
				ACCESSCONTROL: begin // need to add delays
					buttons_select <= 2;
					switches_select <= 1; 
					game_score_select <=0; 
					lcd_control <= 1; 
					led_control <= 1; 
					userid <= switches[15:0]; 
					if(access_control_fb == 1) begin
						buttons_select <= 1;
						switches_select <= 0; 
						game_score_select <=0;  
						lcd_control <= 2; 
						led_control <= 2; // green
						STATE <= TRANSITION;
					end else begin
						led_control <= 1; 
						lcd_control <= 2; // display invalid password
						STATE <= ACCESSCONTROL;
					end
				end
				TRANSITION: begin
					if(buttons[2] == 1) begin
						buttons_select <= 3; 
						game_score_select <=1;  
						lcd_control <= 2; // display play game
						STATE <= GAME;
					end
					else if(buttons[1] == 1) begin
						buttons_select <= 4;
						game_score_select <=2;  
						lcd_control <= 2; // display see see scores
						STATE <= SCOREBOARD; 
					end
					else if(buttons[0] == 1) begin
						buttons_select <= 1;
						game_score_select <=0;  
						lcd_control <= 2; // display logged out 
						STATE <= INIT; 
					end
					else begin
						STATE <= TRANSITION; 
					end
				end
				GAME: begin 
					if(game_fb == 1) begin
						STATE <= TRANSITION; 
					end
					else begin
						STATE <= GAME; 
					end
				end
				SCOREBOARD: begin
					if(scoreboard_fb == 1) begin
						STATE <= TRANSITION; 
					end else begin
						STATE <= SCOREBOARD; 
					end
				end
				default: begin
					STATE <= INIT;
				end
			endcase
		end
	end
endmodule 