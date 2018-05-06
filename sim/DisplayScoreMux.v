//sikender

module DisplayScoreMux(
	input [1:0]  select, 
	input [31:0] game_data, 
	input [31:0] score_board_data,
	output reg[31:0] data); 
	
	always@(select) begin
		case(select)
			0: begin
				data = 0; 
			end
			1: begin
				data = game_data; 
			end
			2: begin
				data = score_board_data; 
			end
		endcase
	end
endmodule 