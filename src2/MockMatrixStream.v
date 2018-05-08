

module MockMatrixStream(clk,rst,output_stream); 

	input [0:0] clk, rst; 
	output [63:0] output_stream; 
	reg [7:0] matrix[7:0];
	reg [3:0] state; 
	always @ (posedge clk) 
		begin
			if (!rst) 
				begin
					state <= 0;
				end	
			else 
				begin
					case(state)
						0: 
						begin
							matrix[0] = 8'b00000000; 
							matrix[1] = 8'b00000000;
							matrix[2] = 8'b00000000;
							matrix[3] = 8'b00000000;
							matrix[4] = 8'b00000000;
							matrix[5] = 8'b00000000;
							matrix[6] = 8'b00000000; 
							matrix[7] = 8'b00000000;  
							state<= 1;
						end
						1: begin matrix[7] = 8'b00111100; state<= 2;end
						2: begin matrix[6] = 8'b00111100; state<= 3;end
						3: begin matrix[5] = 8'b00011100; state<= 4;end
						4: begin matrix[4] = 8'b00011000; state<= 5;end
						5: begin matrix[3] = 8'b00011000; state<= 6;end
						6: begin matrix[2] = 8'b00001000; state<= 7;end
						7: begin matrix[1] = 8'b00001000; state<= 8;end
						8: begin matrix[0] = 8'b00001000; state<= 0;end
						default: begin state<= 0; end	
					endcase
				end
			end

	assign output_stream = {matrix[7],matrix[6],matrix[5],matrix[4],matrix[3],matrix[2],matrix[1],matrix[0]};

endmodule
