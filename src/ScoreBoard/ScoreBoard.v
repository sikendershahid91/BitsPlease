//sikender 


module ScoreBoard(
	input [0:0] clk, 
	input [0:0] rst, 
	input [15:0] userid, 
	input [1:0] game_state, 
	input [15:0] ram_data,
	output[31:0] scoreboard_output, 
	output [0:0] wren, 
	output [15:0] address, 
	output [15:0] data 
	); 

	//rember two cycle delay on the ram access 

	always@(game_state) begin
		if(game_state === 2'b10) begin
			// access report then entire RAM 
			// probably  more efficent way to do this 
		end 
	end

	parameter INIT=1, 
			  UPDATE=2, // access ram update players score 
			  SCOREBARD=3; /// acccess ram report scores 

	reg [0:0] STATE; 
	always@(posedge clk) begin
		if(!rst) begin
			//
		end else begin
			case(STATE)
				INIT: begin
					
				end
				default:begin
					
				end
			endcase
		end
	end

endmodule 