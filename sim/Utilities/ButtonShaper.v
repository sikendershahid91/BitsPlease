// ECE5440
// Sikender Shahid 0981476
// This module debounces button input and outputs single cycle high
// new input is only recorded when the button is released 
// This module utilizes a 2 procedure FSM

module ButtonShaper(clk, RawInput, ShapedOutput);
	input clk, RawInput; 
	output reg ShapedOutput; 

	parameter OFF_STATE = 0,
		ON_STATE = 1, 
		DELAY_STATE = 2;

	reg [1:0] State, StateNext; 

	always @ (State, RawInput)begin
		case(State)
			OFF_STATE: begin
				ShapedOutput = 0; 
				if(RawInput == 0) begin
					StateNext = ON_STATE; 
				end 
				else begin
					StateNext = OFF_STATE; 
				end
			end
			ON_STATE: begin
				ShapedOutput = 1;
				StateNext = DELAY_STATE;
			end
			DELAY_STATE: begin
				ShapedOutput = 0; 
				if(RawInput == 0) begin
					StateNext = DELAY_STATE;  
				end 
				else begin
					StateNext = OFF_STATE;
				end
			end
			default: begin
				ShapedOutput = 0; 
				StateNext = OFF_STATE; 
			end
		endcase
	end 

	always @ (posedge clk) begin
		State <= StateNext;
	end

endmodule
