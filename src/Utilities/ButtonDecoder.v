//sikender

module ButtonDecoder(
	input [2:0] Select,
	input [2:0] ButtonVector, 
	output reg [2:0] ButtonVector1, 
	output reg [2:0] ButtonVector2, 
	output reg [2:0] ButtonVector3,
	output reg [2:0] ButtonVector4);
	
	always@(Select) begin
		case(Select)
			1: begin
				ButtonVector1 = ButtonVector; 
				ButtonVector2 = 0; 
				ButtonVector3 = 0;
				ButtonVector4 = 0;  
			end
			2: begin
				ButtonVector1 = 0; 
				ButtonVector2 = ButtonVector; 
				ButtonVector3 = 0;
				ButtonVector4 = 0;  
			end
			3: begin
				ButtonVector1 = 0; 
				ButtonVector2 = 0; 
				ButtonVector3 = ButtonVector;
				ButtonVector4 = 0;  
			end
			4: begin
				ButtonVector1 = 0; 
				ButtonVector2 = 0; 
				ButtonVector3 = 0; 
				ButtonVector4 = ButtonVector; 
			end
			default: begin
				ButtonVector1 = 0; 
				ButtonVector2 = 0; 
				ButtonVector3 = 0;
				ButtonVector4 = 0;  
			end
		endcase
	end
endmodule 