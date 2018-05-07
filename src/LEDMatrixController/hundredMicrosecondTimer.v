/*
100 microsecond timer works. pulseIn needs to come from microsecondTimer
*/

module hundredMicrosecondTimer(pulseIn, clk, rst, pulseOut);

	input pulseIn, clk, rst;
	output wire pulseOut;
	reg pulse;

	reg [7:0] LFSR;
  	wire feedback = LFSR[7];


	always @ (posedge clk)
		begin
			if(rst == 0)
				begin
					LFSR <= 8'b11111111;
					pulse <= 0;
				end
			else 
				begin
					if(pulseIn == 1)
						begin
							if(LFSR == 8'b01011010)
								begin
									LFSR <= 8'b11111111;
									pulse <= 1;
								end
							else 
								begin
									LFSR[0] <= feedback;
		    						LFSR[1] <= LFSR[0];
		    						LFSR[2] <= LFSR[1] ^ feedback;
		    						LFSR[3] <= LFSR[2] ^ feedback;
		    						LFSR[4] <= LFSR[3] ^ feedback;
		    						LFSR[5] <= LFSR[4];
								    LFSR[6] <= LFSR[5];
								    LFSR[7] <= LFSR[6];
									pulse <= 0;
								end
						end
					else 
						begin
							pulse <= 0;
						end
				end
		end
	assign pulseOut = pulse;
endmodule
