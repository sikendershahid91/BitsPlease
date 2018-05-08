// ECE5440
// Sikender Shahid 0981476
// The decoder to convert a 4 bit value into 7 bit that displays 
// correct value on the 7 segment display

module Dec7Seg(
	input_4_bits, 
	output_7_bits);

	input [3:0] input_4_bits;
	output reg [6:0] output_7_bits; 

	always @ (input_4_bits) begin
		case(input_4_bits)
			0: begin
				output_7_bits = 7'b1000000;	
			end
			1: begin
				output_7_bits = 7'b1111001; 
			end
			2: begin
				output_7_bits = 7'b0100100; 
			end
			3: begin
				output_7_bits = 7'b0110000;
			end
			4: begin
				output_7_bits = 7'b0011001; 
			end
			5: begin
				output_7_bits = 7'b0010010; 
			end
			6: begin
				output_7_bits = 7'b0000010; 
			end
			7: begin
				output_7_bits = 7'b1111000; 
			end
			8: begin
				output_7_bits = 7'b0000000; 
			end
			9: begin
				output_7_bits = 7'b0011000;
			end	
			4'hA: begin
				output_7_bits = 7'b0001000; 
			end	
			4'hB: begin
				output_7_bits = 7'b0000011; 
			end	
			4'hC: begin
				output_7_bits = 7'b1000110; 
			end	
			4'hD: begin
				output_7_bits = 7'b0100001; 
			end	
			4'hE: begin
				output_7_bits = 7'b0000110;
			end	
			4'hF: begin
				output_7_bits = 7'b0001110; 
			end			
			default: begin
				output_7_bits = 7'b1111111;
			end
		endcase
	end
endmodule  

